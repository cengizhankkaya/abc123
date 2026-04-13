# Flutter’da fonksiyonel hata yönetimi: `Either<Failure, T>` ve katmanlar arası mapping

**Alt başlık:** Exception’ları domain’e sızdırmadan, `fpdart` ve BLoC’ta `fold` ile okunabilir bir hata yüzeyi kurmak

**Okuyucu:** Widget ve BLoC içinde `try/catch` ile şişen, hangi hatanın nereden geldiğini takip etmekte zorlanan ekipler.

**Kaynak repo:** Bu metin, [ARCHITECTURE.md](../ARCHITECTURE.md) içindeki hata akışı diyagramı ile [ADR-0003](adr/0003-fpdart-error-handling.md) ve [ADR-0011](adr/0011-context-aware-failure-mapping.md) kararlarını; ayrıca `starter_app` kod tabanındaki `FutureResult`, `ErrorModel` ve `AuthBloc` örneklerini temel alır.

---

## Giriş: Sorun “hata olması” değil, “hatanın görünmez olması”

Dart ve Flutter’da en yaygın yaklaşım şudur: repository veya servis doğrudan değer döner, bir şey ters giderse exception fırlatılır; üst katmanda `try/catch` ile yakalanır. Bu model çalışır, fakat ölçek büyüdükçe üç problem çıkar:

1. **Kontrol akışı görünmez olur.** Metod imzası “`User` döner” der; aslında patlayabilir. Çağıran her seviye için “acaba burada da catch lazım mı?” sorusu kalır.
2. **İş hatası ile teknik kırılma iç içe geçer.** “Şifre yanlış” ile “socket kapandı” aynı `catch` bloğunda toplanır; kullanıcıya gösterilecek mesaj ve yeniden deneme (retry) kararı bulanıklaşır.
3. **Test ve refaktör maliyeti artar.** Başarı yolunu test etmek kolay; tüm exception dallarını sistematik kapsamak zor.

Çözüm yönü, **Railway Oriented Programming** diye de anılan kalıptır: başarı ve başarısızlık tür sisteminde açıkça ifade edilir. Dart tarafında bunu pratikleştiren paketlerden biri **fpdart**; tip olarak **`Either<Failure, T>`** (bu projede `Result<T>` typedef’i ile).

---

## Mimari sözleşme: Exception’lar infrastructure’da kalır

Clean Architecture ve hexagonal düşüncede domain ve application katmanları, HTTP istemcisi veya platform API’lerinden habersiz olmalı. Exception’lar çoğu zaman tam da bu dış dünyadan gelir. Bu yüzden net bir kural koymak gerekir:

- **Infrastructure:** Harici kütüphaneler exception fırlatabilir; burada yakalanır ve **anlamlı bir `Failure`**’a çevrilir.
- **Domain / Application:** `FutureResult<T>` (yani `Future<Either<Failure, T>>`) döner; exception sızdırmaz.
- **Presentation (BLoC):** `try/catch` yerine **`fold`** ile iki dalı işler; gerekiyorsa hatayı UI dostu bir modele sarar.

[ARCHITECTURE.md](../ARCHITECTURE.md) bu akışı şöyle özetler: API çağrısı → exception varsa `ExceptionHandler` / mapper → `InfrastructureFailure` veya özellik bazlı `AuthFailure` gibi tipler → `Left` veya başarıda `Right` → BLoC’ta `fold` → hata veya başarı state’i.

---

## `Result<T>` ve `FutureResult<T>`: İmzada “başarısız olabilir” demek

Projede tekrarlayan imzaları kısaltmak için şu typedef kullanılır ([lib/core/types/types.dart](../lib/core/types/types.dart)):

```dart
typedef Result<T> = Either<Failure, T>;
typedef FutureResult<T> = Future<Result<T>>;
```

Böylece repository ve use case imzaları hem okunaklı hem de **başarısızlığı zorunlu kılıyor**: çağıran, eninde sonunda `Either` ile yüzleşmek zorunda.

Use case tarafında tipik desen, repository’den gelen `Either`’ı olduğu gibi iletmek veya zincirlemektir; BLoC ise **tek bir yerde** `fold` ile state üretir.

---

## `Failure` hiyerarşisi: Teknik mi, iş kuralı mı?

Domain’deki kök tip `Failure` soyut sınıfıdır. Projede yorum satırlarında özetlenen ağaç kabaca şöyledir ([lib/core/error/failures/failure.dart](../lib/core/error/failures/failure.dart)):

- **Teknik / altyapı:** `InfrastructureFailure` (ağ, sunucu, önbellek, beklenmeyen vb.).
- **Özellik odaklı:** Örneğin `AuthFailure` — HTTP durum koduna göre `unauthorized`, `forbidden`, `emailAlreadyInUse` gibi anlamlı varyantlar.
- **Doğrulama:** `ValueFailure<T>` altında e-posta/şifre gibi alan hataları.

Bu ayrımın presentation’a faydası şudur: örneğin **yeniden denenebilir mi?** sorusu `TechnicalFailure.isRetryable` ile tutarlı şekilde çözülür; saf doğrulama hatalarında retry anlamsızdır. Bunu `ErrorModel.fromFailure` şeffafça uygular ([lib/core/presentation/models/error_model.dart](../lib/core/presentation/models/error_model.dart)):

```dart
factory ErrorModel.fromFailure(Failure failure) {
  final isRetryable = failure is TechnicalFailure && failure.isRetryable;
  return ErrorModel(failure: failure, isRetryable: isRetryable);
}
```

BLoC tarafında `BuildContext` yoktur; sadece `Failure` → `ErrorModel` dönüşümü yapılır. **Lokalize mesaj** ise widget katmanında `FailureMessageService` ve `BuildContext` ile üretilir. Böylece domain framework’ten kopuk kalır, metinler i18n’e uygun kalır.

---

## İki katmanlı mapping: Exception → Failure → kullanıcı mesajı

ADR-0011’in çözdüğü gerilim şudur: domain `BuildContext` istemez; UI ise `context.authL10n` ister. Çözüm **iki aşamalı mapper**’dır.

### 1) Infrastructure: Exception → `Failure`

Örneğin auth özelliğinde HTTP hataları, özellik domain’inde tanımlı `AuthFailure` varyantlarına eşlenir (ADR’deki örnek):

```dart
@override
Failure mapToFailure(ServerException exception) {
  return switch (exception.statusCode) {
    HttpStatus.unauthorized => AuthFailure.unauthorized(),
    HttpStatus.forbidden => AuthFailure.forbidden(),
    HttpStatus.conflict => const AuthFailure.emailAlreadyInUse(),
    _ => InfrastructureFailure.server(message: exception.message),
  };
}
```

Burada kritik nokta: **status code bilgisi** sunucu katmanında kalır; domain tarafında ise **anlamlı bir iş olayı** (`emailAlreadyInUse` gibi) ortaya çıkar.

### 2) Presentation: `Failure` → lokalize string

Aynı özellik, presentation’da `FailureMessageMapper` türevi ile `Failure`’ı `BuildContext` üzerinden metne çevirir. ADR’deki örnekte `AuthFailure` için `map` ile tüm varyantlar tek yerde listelenir.

Kayıt (registry) ile mapper’ların unutulmaması hedeflenir; özellik başına bu iki dosya “biraz daha fazla dosya” maliyeti getirir, karşılığında sınırlar netleşir.

Özet akış:

```text
Exception
  → AuthExceptionMapper (infrastructure)
  → AuthFailure (domain)
  → AuthFailureMessageMapper (presentation)
  → "E-posta zaten kullanımda" (l10n)
```

---

## BLoC’ta `fold`: `try/catch` sarmalaması yok

Aşağıdaki örnek, gerçek `AuthBloc` akışından uyarlanmıştır ([lib/features/auth/presentation/bloc/auth_bloc.dart](../lib/features/auth/presentation/bloc/auth_bloc.dart)). Login sonrası sonuç işlenirken desen tekrar eder:

```dart
final result = await _login(credentials);

result.fold(
  (failure) => emit(
    s.copyWith(
      isSubmitting: false,
      error: ErrorModel.fromFailure(failure),
      validation: FieldValidationState.allTouched(),
    ),
  ),
  (user) => _handleAuthSuccess(user, emit),
);
```

Burada dikkat edilmesi gerekenler:

- **İki dal zorunlu:** Derleyici `fold` ile her iki yolu da kapatmanızı ister; unutulan “sessiz başarısızlık” azalır.
- **State şişmez:** Hata için ayrı bir `ErrorModel` alanı; başarıda domain `User` ile devam.
- **Logout gibi ikincil akışlarda** aynı `Either` kullanılabilir; örneğin hata sadece log’a yazılıp state yine temizlenebilir (aynı dosyada `logout` örneği).

Stream tabanlı auth dinleyicilerinde de `onData: (result) => result.fold(...)` ile aynı dil korunur; reactive ve tek seferlik çağrılar tek tip `Result<T>` üzerinden birleşir.

---

## Zincirleme ve okunabilirlik: `flatMap`, `map`

ADR-0003’ün “Positive” maddelerinden biri **composability**’dir. Birden fazla adım birbirine bağlanırken her adım `Either` döndürüyorsa, `flatMap` ile başarı yolunda ilerleyip ilk `Left`’te durmak doğal gelir. Bu makalenin odağı katman sınırları olduğu için derin FP turuna girmiyoruz; yeter ki ekipler şunu bilsin: **Either sadece BLoC’ta değil, domain servislerinde de** (örneğin kayıt akışında alt adımlar) aynı disiplinle kullanılabilir.

---

## Trade-off’lar: Ne kazanıyoruz, ne öğreniyoruz?

ADR-0003 ve ADR-0011 bunları dürüstçe listeler:

**Kazançlar**

- Hatalar **imzada görünür**; çağıran kaçamaz.
- Domain **Flutter’dan bağımsız** kalır; test etmek kolaylaşır.
- BLoC içi **try/catch karmaşası** azalır; state geçişleri okunur.
- Kullanıcı mesajı ile **teknik sebep** ayrışır (iki mapper katmanı).

**Bedeller**

- `fpdart` ve `Either` için **öğrenme eğrisi**.
- Metod imzalarında **biraz daha fazla yazım** (`FutureResult<T>`).
- Özellik başına **mapper + mesaj mapper** dosyaları.

Küçük prototipte bu yapı ağır gelebilir; **ürün ve ekip büyüdükçe** tutarlılık ve güvenlik açısından genelde telafi eder.

---

## Sonuç

Fonksiyonel hata yönetimi, Flutter’da “daha akademik bir stil” değil; **hata yüzeyini sözleşmeye dökmek** demektir. Exception’ları infrastructure’da yakalayıp `Failure`’a çevirmek, use case ve repository’de `FutureResult<T>` kullanmak, BLoC’ta `fold` ile state üretmek ve mesajı `FailureMessageService` + mapper ile UI sınırına taşımak — bu zincir, `try/catch` ile şişen presentation katmanını ciddi ölçüde sadeleştirir.

Kendi projenizde adım adım ilerlemek için pratik sıra önerisi:

1. `Result<T>` / `FutureResult<T>` typedef’lerini ve kök `Failure`’ı tanımlayın.
2. Bir repository’de tüm exception’ları `Left(InfrastructureFailure...)` veya özellik `Failure`’larına eşleyin.
3. Bir BLoC’ta tek bir use case için `fold` + ince bir `ErrorModel` (veya direkt `Failure` taşıyan state) deneyin.
4. Lokalizasyon ihtiyacı arttıkça ikinci mapper katmanını ekleyin.

---

## Okuma listesi

- [fpdart](https://pub.dev/packages/fpdart)
- [Railway Oriented Programming](https://fsharpforfunandprofit.com/rop/) (kavramsal arka plan)
- Bu repo: [ARCHITECTURE.md](../ARCHITECTURE.md) — “Error Handling Flow”, “Result Pattern”
- Bu repo: [ADR-0003](adr/0003-fpdart-error-handling.md), [ADR-0011](adr/0011-context-aware-failure-mapping.md)

---

*Medium’a yapıştırırken: kod bloklarını Medium’un “code” veya gist embed ile sunabilir; diyagram için ARCHITECTURE.md’deki Mermaid’i export edip görsel olarak ekleyebilirsiniz.*
