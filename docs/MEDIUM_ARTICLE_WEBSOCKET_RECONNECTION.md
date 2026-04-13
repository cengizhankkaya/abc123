# Flutter’da WebSocket, oturum ve yeniden bağlanma: Bu projede nasıl kurgulandı?

**Alt başlık:** Hexagonal portlar, çoklu bağlantı, üstel gecikme + jitter ve token yenileme ile auth WebSocket’inin bir arada çalışması

**Okuyucu:** Gerçek zamanlı kanal açan ama ağ kopması, arka plana geçiş veya access token yenilenmesi sonrası bağlantının sağlıklı kalmasını isteyen Flutter geliştiricileri.

**Kaynaklar:** [docs/adr/0014-websocket-reconnection.md](adr/0014-websocket-reconnection.md), [lib/core/infrastructure/websocket/README.md](../lib/core/infrastructure/websocket/README.md), [RECONNECTION.md](../lib/core/infrastructure/websocket/RECONNECTION.md), aşağıda referans verilen Dart dosyaları.

---

## 1. Neden ayrı bir WebSocket altyapısı?

WebSocket bağlantıları doğası gereği kırılgandır: Wi‑Fi / hücre geçişi, sunucu yeniden başlatma, idle timeout, uygulama arka plana alınması. Bu projede hedef şunlar olarak özetleniyor (ADR-0014):

- Kopunca **otomatik** yeniden bağlanmak  
- Sunucuyu **spam** etmeyecek şekilde denemeleri yaymak  
- Bağlantı durumunun **gözlemlenebilir** olması  
- **Access token yenilendiğinde** kanalın güncel kimlik bilgisiyle devam etmesi  

Bunun için çekirdekte **hexagonal** bir ayrım var: sözleşmeler domain’de port olarak tanımlanır, gerçek `web_socket_channel` kullanımı infrastructure’da kalır.

---

## 2. Katmanlar: Portlar ve bağdaştırıcılar

### `IWebSocketConnection`

Tek bir uç noktaya giden bağlantının sözleşmesi: mesaj akışı, durum akışı, `connect` / `send` / `disconnect` / `dispose`. Özet imza:

```36:93:lib/core/domain/ports/i_websocket_connection.dart
abstract interface class IWebSocketConnection {
  Stream<String> get messages;
  Stream<WebSocketConnectionState> get connectionState;
  WebSocketConnectionState get currentState;
  bool get isConnected;
  bool get isConnecting;
  Future<void> connect({Map<String, String>? headers});
  void send(String message);
  Future<void> disconnect();
  Future<void> dispose();
}
```

### `IWebSocketManager`

Aynı anda **birden fazla** bağımsız WebSocket (ör. `/ws/auth`, `/ws/notifications`) üretmek için fabrika:

```31:42:lib/core/domain/ports/i_websocket_manager.dart
abstract interface class IWebSocketManager {
  IWebSocketConnection createConnection(
    String path, {
    IReconnectionPolicy? reconnectionPolicy,
  });
  // ...
}
```

`WebSocketManager` adapter’ı, `websocketBaseUrl` ile gelen taban adrese path ekleyerek `WebSocketConnection` örneği oluşturur ve listesinde tutar ([websocket_manager.dart](../lib/core/infrastructure/websocket/websocket_manager.dart)).

### `IReconnectionPolicy`

Yeniden bağlanma **davranışı** domain tarafında arayüzle soyutlanır; gecikme formülü infrastructure’daki somut sınıfta verilir:

```25:52:lib/core/domain/types/i_reconnection_policy.dart
abstract interface class IReconnectionPolicy {
  bool get enabled;
  int? get maxAttempts;
  bool canRetry(int currentAttempt);
  Duration getDelayForAttempt(int attempt);
}
```

Bu sayede testte veya farklı ürün politikalarında policy takas edilebilir.

---

## 3. Bağlantı durumu: Basit bir durum makinesi

`WebSocketConnection`, `onError` / `onDone` sonrası `_handleConnectionLost` ile kopuşu merkezileştirir. Manuel `disconnect` veya `dispose` ise `_isManualDisconnect` / `_isDisposed` ile **yeniden bağlanmayı** kesin olarak kapatır.

Önemli akış özeti:

1. `connect` → `_lastHeaders` saklanır, deneme sayacı sıfırlanır, `_attemptConnection` çalışır.  
2. İlk denemede durum `connecting`; sonraki otomatik denemelerde `reconnecting`.  
3. `WebSocketChannel.connect` + `ready` sonrası `connected`; başarıda `_reconnectionAttempt = 0` ile sayaç sıfırlanır.  
4. Kopuşta policy izin veriyorsa `_scheduleReconnection`; aksi halde `failed` ve temizlik.

```251:290:lib/core/infrastructure/websocket/websocket_connection.dart
  Future<void> _handleConnectionLost() async {
    if (_isDisposed || _isManualDisconnect) {
      await _cleanup();
      return;
    }

    if (_reconnectionPolicy.enabled &&
        _reconnectionPolicy.canRetry(_reconnectionAttempt)) {
      _scheduleReconnection();
    } else {
      _updateConnectionState(WebSocketConnectionState.failed);
      // ...
      await _cleanup();
      onDisconnected?.call();
    }
  }

  void _scheduleReconnection() {
    _reconnectionTimer?.cancel();

    final delay = _reconnectionPolicy.getDelayForAttempt(_reconnectionAttempt);
    _updateConnectionState(WebSocketConnectionState.reconnecting);
    onReconnecting?.call(_reconnectionAttempt + 1);

    _reconnectionTimer = Timer(delay, () async {
      _reconnectionAttempt++;
      await _cleanup(keepController: true);
      await _attemptConnection();
    });
  }
```

`messages` dinleyicilerinin kopukluk sırasında kaybolmaması için yeniden denemede `_cleanup(keepController: true)` ile mesaj `StreamController` korunur.

---

## 4. Gecikme politikası: Jitter’lı backoff

Somut sınıf `WebSocketReconnectionConfig`. Üç hazır profil var: `defaultConfig`, `aggressive`, `conservative`; ayrıca `noReconnection`.

Gecikme hesabı (özet): taban süre ile `(backoffMultiplier * (attempt + 1))` çarpılır, `maxDelay` ile sınırlanır, ardından `jitterFactor` ile rastgele çarpan uygulanır — böylece binlerce istemcinin aynı milisaniyede tekrar bağlanması (“thundering herd”) yumuşatılır.

```128:166:lib/core/infrastructure/websocket/websocket_reconnection_config.dart
  @override
  Duration getDelayForAttempt(int attempt) {
    if (attempt < 0) {
      return _applyJitter(initialDelay.inMilliseconds.toDouble());
    }

    final delayMs =
        initialDelay.inMilliseconds * (backoffMultiplier * (attempt + 1));

    final cappedDelayMs = delayMs.clamp(
      initialDelay.inMilliseconds.toDouble(),
      maxDelay.inMilliseconds.toDouble(),
    );

    return _applyJitter(cappedDelayMs);
  }

  Duration _applyJitter(double delayMs) {
    if (jitterFactor <= 0) {
      return Duration(milliseconds: delayMs.toInt());
    }

    final jitterMultiplier =
        1.0 + (_random.nextDouble() * 2 - 1) * jitterFactor;
    final jitteredDelayMs = delayMs * jitterMultiplier;

    return Duration(
      milliseconds: jitteredDelayMs.toInt().clamp(1, delayMs.toInt() * 2),
    );
  }
```

Not: ADR-0014 metnindeki örnek üstel `pow` formülü ile bu dosyadaki implementasyon satır satır aynı değil; **makale ve üretim davranışı için kaynak gerçek kod** olmalıdır.

---

## 5. Kimlik doğrulama: Bearer header’dan query `token`’a

Tarayıcı uyumluluğu için el sıkışmada özel header kısıtları nedeniyle, `Authorization: Bearer …` header’ı içeriden **URI query parametresi** `token` olarak eklenir:

```195:209:lib/core/infrastructure/websocket/websocket_connection.dart
      var uri = Uri.parse(_url);

      final authHeader = _lastHeaders?['Authorization'];
      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        final token = authHeader.substring(7);
        uri = uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            'token': token,
          },
        );
      }

      _channel = _channelFactory?.call(uri) ?? WebSocketChannel.connect(uri);
```

README’de ayrıntılı güvenlik uyarıları var: query logları, kısa ömürlü WS token, sunucu log maskeleme, token yenilemede yeniden bağlanma. Bunlar Medium yazısında “bilinçli trade-off” bölümü için ideal.

---

## 6. Auth özelliğinde oturum: `AuthWebSocketDataSource`

Bu proje, auth state’i sunucudan **event** ile almak için ayrı bir veri kaynağı kullanır: `IAuthWebSocketDataSource` → `AuthWebSocketDataSource`.

### Akış

1. `watchAuthChanges()` ilk dinleyicide `_onListen` tetiklenir.  
2. `ITokenStorage`’dan access token alınır; yoksa stream’e `null` gönderilir.  
3. **`ITokenRefreshNotifier.onTokenRefreshed`** dinlenir; HTTP tarafında token yenilenince `_reconnectWithNewToken` çağrılır (ADR’deki “token ile entegrasyon” burada somutlaşır).  
4. `IWebSocketManager.createConnection('/ws/auth')` ile bağlantı oluşturulur, `connectionState` ile `failed` izlenir.  
5. `connect(headers: { Authorization: Bearer … })` sonrası `messages` üzerinde JSON parse → `AuthWsEventModel` → authenticated ise `UserModel`, logout/session ise `null`.

Token yenileme tarafı (özet):

```97:100:lib/features/auth/infrastructure/datasources/auth_websocket_data_source.dart
      _tokenRefreshSubscription = _tokenRefreshNotifier.onTokenRefreshed.listen(
        (_) => _reconnectWithNewToken(),
      );
```

`_reconnectWithNewToken` içinde eski abonelikler iptal edilir, bağlantı `disconnect` edilir, **yeni** `createConnection('/ws/auth')` ile taze token ile tekrar `connect` edilir ([auth_websocket_data_source.dart](../lib/features/auth/infrastructure/datasources/auth_websocket_data_source.dart) içindeki tam metot).

Böylece:

- Ağ kopunca `WebSocketConnection` kendi backoff’u ile tekrar dener.  
- Access token **yenilenince** auth veri kaynağı bilinçli olarak kanalı kapatıp yeni token ile açar (uzun ömürlü oturumlarda eski token ile takılı kalmama).

---

## 7. UI ve domain ile köprü

README’de önerilen desen: özellik başına bir WebSocket veri kaynağı, `Stream` üzerinden domain modelleri; repository gerekiyorsa `StreamResult` ile `Either`’a map’leme. Auth tarafında stream doğrudan `UserModel?` taşır; kalıcı `failed` durumunda `NetworkException` ile `addError` kullanılır — üst katman mevcut hata / BLoC desenleriyle birleştirilebilir.

Durum göstergesi için `connectionState` dinleyip `connecting` / `reconnecting` / `failed` için banner veya ikon göstermek RECONNECTION.md’de örneklenmiştir.

---

## 8. Özet tablo

| Bileşen | Rol |
|--------|-----|
| `IWebSocketManager` | Çoklu bağlantı fabrikası, taban URL |
| `WebSocketConnection` | Kanal yaşam döngüsü, backoff + jitter, token query |
| `IReconnectionPolicy` / `WebSocketReconnectionConfig` | Deneme sayısı ve gecikme stratejisi |
| `AuthWebSocketDataSource` | Auth path, token storage, token refresh ile yeniden bağlanma, event parse |
| Manuel `disconnect` / `dispose` | Otomatik reconnect’i güvenli şekilde durdurma |

---

## 9. Medium’da kullanım önerisi

- Bir **sequence diyagramı**: `connect` → mesaj → `onDone` → `reconnecting` → tekrar `connected`.  
- Bir **karar kutusu**: “Neden query `token`?” — tek paragraf + mitigasyon linki.  
- Kod: Bu dosyadaki kısa alıntılar + repoya link; uzun blokları gist’e taşıyın.  
- Sonuç: “Stateful socket kodunu widget’tan çıkarıp port + adapter + policy ile yönetmek” cümlesiyle kapatın.

---

*Bu metin starter_app kod tabanına dayanır; sürüm farklarında satır numaraları değişebilir, mantık için ilgili dosyaları doğrulayın.*
