import 'package:flutter/foundation.dart';

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

  /// Taban adresin güvenli olduğunu doğrular (assert; release derlemelerde kapalı).
  ///
  /// Release dışında (`!kReleaseMode`) yerel ve tipik LAN adresleri için `http`
  /// kabul edilir; aksi halde yalnızca `https` (ör. staging/production).
  static void assertHttpsApiBase() {
    final raw = current.apiBaseUrl;
    final uri = Uri.tryParse(raw);
    assert(
      uri != null && uri.hasAuthority,
      'API_BASE_URL çözümlenemedi veya host eksik: $raw',
    );
    final u = uri!;
    assert(
      u.scheme == 'https' || _insecureDevApiBaseAllowed(u),
      'API_BASE_URL yalnızca https olmalıdır '
      '(debug/profile: http yalnızca localhost / 127.0.0.1 / 10.0.2.2 / RFC1918)',
    );
  }

  /// Debug ve profile derlemelerde; yalnızca bilinen yerel / özel ağ HTTP tabanı.
  static bool _insecureDevApiBaseAllowed(Uri uri) {
    if (kReleaseMode) return false;
    if (uri.scheme != 'http') return false;
    final h = uri.host.toLowerCase();
    if (h.isEmpty) return false;
    if (h == 'localhost' || h.endsWith('.localhost')) return true;
    if (h == '127.0.0.1' || h == '::1') return true;
    if (h == '10.0.2.2') return true;
    if (h.startsWith('192.168.')) return true;
    if (h.startsWith('10.')) return true;
    final re172 = RegExp(r'^172\.(1[6-9]|2\d|3[0-1])\.');
    return re172.hasMatch(h);
  }
}
