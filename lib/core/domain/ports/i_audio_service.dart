import 'package:abc123/core/infrastructure/audio/audio_service.dart' show AudioService;

/// Ses servisi için domain portu.
///
/// Presentation katmanı bu interface üzerinden ses işlemlerini çağırır;
/// somut implementasyon [AudioService] (`core/infrastructure/audio/audio_service.dart`).
abstract interface class IAudioService {
  /// O anki ses seviyesi (0.0 – 1.0).
  double get currentVolume;

  /// Daha önce kaydedilmiş ses seviyesini yükler; uygulama başlangıcında çağrılır.
  Future<void> init();

  /// [assetPath] dosyasını arka planda çalar. [loop] true ise döngüye girer.
  Future<void> playBackground(String assetPath, {bool loop = true});

  /// Arka plan sesini durdurur.
  Future<void> stopBackground();

  /// [assetPath] ses efektini çalar (tek seferlik).
  Future<void> playEffect(String assetPath);

  /// Efekti çalar, bitince arka planı devam ettirir.
  Future<void> playEffectAndResumeBackground(String effectPath, String bgPath);

  /// Ses seviyesini ayarlar ve kalıcı olarak kaydeder.
  Future<void> setVolume(double volume);

  /// Oynatıcıları serbest bırakır.
  Future<void> dispose();
}
