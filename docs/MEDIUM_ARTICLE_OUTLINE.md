# Medium makalesi — kararlar ve outline

Bu dosya, [ARCHITECTURE.md](../ARCHITECTURE.md) ve ilgili ADR’lere dayanarak tek bir Medium yazısı için hedef kitle, format ve bölüm taslağını sabitler.

---

## 1. Hedef kitle (todo: pick-audience)

**Seçim: Mimari odaklı Flutter geliştiricileri** (orta–ileri seviye).

**Gerekçe:**

- Starter, “widget yazmayı yeni öğrendim” seviyesinden çok **katmanlı mimari, test edilebilirlik ve ekip ölçeği** ile konuşuyor.
- Okuyucu Flutter’ı biliyor; eksik kalan taraf genelde **bağımlılık yönü, port/adapter ve hata modeli** oluyor.
- Junior okuyucuya kısa bir “Önkoşullar” kutusu (BLoC, async/Dart temel) ile kapı açılabilir; ana anlatım yine mimari üzerinde kalır.

**İkincil okuyucu:** Backend’de DDD/CQRS görmüş, mobil tarafta aynı dili arayan geliştiriciler.

---

## 2. Format ve ana başlıklar (todo: pick-angle)

**Seçim: Tek güçlü makale** — planın önerdiği birleşik akış: **Konu 1 + 2 + 3** (Clean Architecture + CQRS + `Either<Failure, T>`).

| Parametre | Değer |
|-----------|--------|
| Makale sayısı | 1 |
| Çalışma başlığı (Türkçe) | *Flutter’da Clean Architecture: CQRS ve Either ile uçtan uca akış* |
| İsteğe bağlı alt başlık | *Enterprise starter’dan örneklerle* |

**Seri notu:** İleride aynı repodan **Parça 2** (auth + interceptor + token) ve **Parça 3** (Mason + test) ayrı yazılara ayrılabilir; bu outline yalnızca ilk makaleyi kapsar.

---

## 3. Makale outline — kaynak eşlemesi (todo: outline-from-sources)

Aşağıdaki sıra okuyucuyu “neden”den “nasıl”a taşır; her bölümde 1 kısa kod veya diyagram yeter.

### Başlık ve özet

- Kanca: “İş mantığı widget’lara kaçıyor, test yazılamıyor, API değişince her yer kırılıyor.”
- Vaat: Dört katman + CQRS + açık hata tipi ile **tek özellik üzerinden** (auth) akışı gösterme.

**Kaynak:** [README.md](../README.md) “What Makes This Different”, [ADR-0001](adr/0001-clean-architecture-ddd.md) Context.

---

### Bölüm A — Katmanlar ve bağımlılık kuralı

- Domain’in Flutter’dan bağımsız kalması; Application’ın use case orkestrasyonu; Infrastructure’ın adapter rolü; Presentation’da BLoC.
- “İçe doğru bağımlılık”ı bir cümle + diyagram ile özetle.

**Kaynak:** [ARCHITECTURE.md](../ARCHITECTURE.md) (High-Level Overview, Layers, mermaid grafikleri), [ADR-0001](adr/0001-clean-architecture-ddd.md) Layer Structure ve Key Principles.

**Örnek diyagram:** ARCHITECTURE.md içindeki `Presentation → Application → Domain ← Infrastructure` akışı.

---

### Bölüm B — Feature-first yapı ve neden

- `lib/core` vs `lib/features/*` ayrımının ekip paralelliği ve onboarding’e etkisi.
- Tek cümlelik trade-off: daha fazla boilerplate, daha net sınırlar.

**Kaynak:** [ARCHITECTURE.md](../ARCHITECTURE.md) “Project Structure”, [docs/architecture-rules/01_project_structure.md](architecture-rules/01_project_structure.md) (isteğe bağlı derinlik).

---

### Bölüm C — CQRS: Command vs Query

- Yazma (Command) ve okuma (Query) ayrımının use case seviyesinde ifadesi.
- İsimlendirme: `Login` (command) vs `GetUserProfile` (query) gibi.

**Kaynak:** [ARCHITECTURE.md](../ARCHITECTURE.md) “CQRS”, [ADR-0010](adr/0010-cqrs-command-query.md) (hiyerarşi tablosu ve örnek kod blokları).

**Kod alıntısı:** ADR-0010’daki `Login` / `GetUserProfile` örnekleri (kısaltılmış).

---

### Bölüm D — Hata yönetimi: `Either` ve Failure sınırı

- Exception’ların infrastructure’da kalıp `Failure`’a dönmesi.
- Use case’in `FutureResult<T>` ile sonuç döndürmesi.
- BLoC’ta `fold`: sol dal → hata durumu, sağ dal → başarı.

**Kaynak:** [ARCHITECTURE.md](../ARCHITECTURE.md) “Error Handling Flow”, “Result Pattern”, [ADR-0003](adr/0003-fpdart-error-handling.md), [ADR-0011](adr/0011-context-aware-failure-mapping.md) (exception → failure → kullanıcı mesajı iki katmanı).

**Kod alıntısı:** ADR-0003’teki `result.fold(...)` örneği.

---

### Bölüm E — Özellik örneği: Auth akışı (uçtan uca)

Bu bölüm planın “1 özellik README” gereksinimini karşılar.

- Email-first akış (kısaca).
- `IAuthRepository` port → `AuthRepositoryImpl` adapter.
- Domain event’lerin (UserLoggedIn vb.) ürün davranışı için özet anlamı.
- Token + interceptor konusuna **yalnızca bir cümle** ile dokunup “ayrı yazı” için köprü bırak.

**Kaynak:** [lib/features/auth/README.md](../lib/features/auth/README.md) (Architecture ağacı, Authentication Flow diyagramı, Railway-Oriented Error Handling, Secure Token Storage maddeleri).

---

### Bölüm F — Sonuç ve ne zaman “fazla mühendislik”

- ADR-0001 Consequences’taki pozitif/negatif maddeleri okuyucu diline çevir.
- Küçük prototipte sadeleşme; büyüyen üründe bu yapının ödenen bedel / kazanç dengesi.

**Kaynak:** [ADR-0001](adr/0001-clean-architecture-ddd.md) Consequences.

---

### Yayın öncesi kontrol listesi

- [ ] Tüm kod örnekleri repodaki gerçek pattern ile uyumlu (ADR’deki snippet’ler güncel mi tekrar bak).
- [ ] En fazla 2–3 diyagram (okunabilirlik).
- [ ] Repo linki ve lisans (MIT) kısa not.
- [ ] İsteğe bağlı: İngilizce özet paragraf (Medium uluslararası kitle için).

---

## 4. İlgili dosya indeksi (hızlı erişim)

| Konu | Dosya |
|------|--------|
| Genel mimari | [ARCHITECTURE.md](../ARCHITECTURE.md) |
| Clean Architecture + DDD | [docs/adr/0001-clean-architecture-ddd.md](adr/0001-clean-architecture-ddd.md) |
| CQRS | [docs/adr/0010-cqrs-command-query.md](adr/0010-cqrs-command-query.md) |
| fpdart / Either | [docs/adr/0003-fpdart-error-handling.md](adr/0003-fpdart-error-handling.md) |
| Failure → mesaj | [docs/adr/0011-context-aware-failure-mapping.md](adr/0011-context-aware-failure-mapping.md) |
| Auth özelliği | [lib/features/auth/README.md](../lib/features/auth/README.md) |
