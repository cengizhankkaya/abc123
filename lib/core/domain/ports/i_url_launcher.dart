import 'package:abc123/core/infrastructure/security/url_launch_guard.dart' show UrlLaunchGuardImpl;

/// Dış URL açma işlemleri için domain portu.
///
/// Presentation katmanı bu interface üzerinden URL açma işlemlerini çağırır;
/// somut implementasyon [UrlLaunchGuardImpl]
/// (`core/infrastructure/security/url_launch_guard.dart`).
abstract interface class IUrlLauncher {
  /// Verilen [uri]'nin açılmasına izin verilip verilmediğini döner.
  /// Yalnızca HTTPS şemalı, host'u olan URI'lara izin verilir.
  bool isAllowed(Uri uri);

  /// URI'yi harici tarayıcıda açar. Başarı durumunu döner.
  Future<bool> launch(Uri uri);
}
