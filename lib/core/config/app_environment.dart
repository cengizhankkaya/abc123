/// Derleme / çalışma ortamı ve uç nokta tabanı (`15_security.md`).
///
/// Gizli değerler için `--dart-define=KEY=value` kullanın; `.env` dosyalarını
/// repoya eklemeyin.
enum AppEnvironment {
  development,
  staging,
  production;

  /// `--dart-define=APP_ENV=development|staging|production` (varsayılan: production).
  static AppEnvironment get current {
    const raw = String.fromEnvironment('APP_ENV', defaultValue: 'production');
    return switch (raw.toLowerCase()) {
      'development' || 'dev' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      _ => AppEnvironment.production,
    };
  }

  /// Tüm ortamlarda HTTPS taban adresi (HTTP yasak).
  String get apiBaseUrl {
    return switch (this) {
      AppEnvironment.development => const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.dev.example.com',
        ),
      AppEnvironment.staging => const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.staging.example.com',
        ),
      AppEnvironment.production => const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.example.com',
        ),
    };
  }

  /// Taban adresin `https` olduğunu doğrular (assert ile geliştirme güvencesi).
  static void assertHttpsApiBase() {
    final uri = Uri.tryParse(current.apiBaseUrl);
    assert(
      uri != null && uri.scheme == 'https',
      'API_BASE_URL yalnızca https olmalıdır',
    );
  }
}
