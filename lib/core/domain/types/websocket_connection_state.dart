/// Domain'e özgü tipler — bağlantı durumu vb. (`01_project_structure.md` — core/domain/types).
library;

/// WebSocket bağlantısının durumunu temsil eden enum.
///
/// Feature'lar bu tipi kullanarak altyapı detaylarına bağımlı olmadan
/// bağlantı durumunu yönetebilir.
enum WebSocketConnectionState {
  /// Bağlantı kurulmamış veya kapalı.
  disconnected,

  /// Bağlanmaya çalışılıyor.
  connecting,

  /// Bağlantı başarıyla kuruldu.
  connected,

  /// Beklenmedik kopma nedeniyle yeniden bağlanmaya çalışılıyor.
  reconnecting,

  /// Kalıcı hata; kullanıcı müdahalesi gerekiyor.
  failed,
}
