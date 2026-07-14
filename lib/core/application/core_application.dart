/// Core uygulama düzeyinde servisler (`01_project_structure.md` — core/application).
///
/// Bu katman, birden fazla feature tarafından paylaşılan uygulama servisleri içerir.
/// Feature'a özgü uygulama servisleri `features/[feature]/application/` altında tutulur.
///
/// ## Kullanım Kılavuzu
///
/// - Birden fazla feature kullanan cross-cutting uygulama mantığı buraya gelir.
/// - Örnek: analitik servis, deep link yönetimi, push notification handler.
/// - Tek bir feature tarafından kullanılan servisler o feature'ın `application/` katmanına aittir.
library;
