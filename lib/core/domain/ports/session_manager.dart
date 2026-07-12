/// Oturum yönetimi için soyut port arayüzü (`01_project_structure.md` — core/domain/ports).
///
/// Infrastructure katmanı bu arayüzü implemente eder; domain katmanı
/// doğrudan storage/network kütüphanelerine bağımlı olmaz.
///
/// ```dart
/// class SecureSessionManager implements SessionManager {
///   @override
///   Future<String?> getToken() async { ... }
/// }
/// ```
abstract interface class SessionManager {
  /// Mevcut erişim token'ını döndürür; yoksa `null`.
  Future<String?> getToken();

  /// Token'ı güvenli depolamaya kaydeder.
  Future<void> saveToken(String token);

  /// Token ve oturum verilerini temizler.
  Future<void> clearSession();

  /// Geçerli bir oturum açık mı?
  Future<bool> get isAuthenticated;
}
