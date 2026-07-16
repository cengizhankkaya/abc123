import 'package:flutter/services.dart';

/// iPadOS 16+ scene-based windowing'de [SystemChrome.setPreferredOrientations]
/// çağrısı Split View / Slide Over modunda `UISceneErrorDomain Code=101` ile
/// başarısız olup uygulamayı çökertebilir.
///
/// Bu yardımcı fonksiyonlar çağrıyı try-catch ile güvenli hale getirir.
/// Tam ekran modunda oryantasyon değişikliği yine de uygulanır;
/// pencereli modda ise sessizce görmezden gelinir.
abstract final class OrientationHelper {
  /// Ekranı yatay (landscape) moda kilitler.
  static Future<void> setLandscape() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } on Object catch (_) {
      // iPadOS Split View / Slide Over: programatik yön değişikliğine izin yok.
    }
  }

  /// Ekranı dikey (portrait) moda geri döndürür.
  static Future<void> setPortrait() async {
    try {
      // iOS 16+'da geçiş animasyonu sırasında oryantasyon değiştirilirse Code=101 hatası fırlatılır.
      // Animasyonun bitmesine izin vermek için çok kısa bir gecikme ekliyoruz.
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } on Object catch (_) {
      // iPadOS Split View / Slide Over: programatik yön değişikliğine izin yok.
    }
  }

  /// Tüm yönlere izin verir (kısıtlamayı kaldırır).
  static Future<void> setUnlocked() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } on Object catch (_) {
      // iPadOS Split View / Slide Over: programatik yön değişikliğine izin yok.
    }
  }
}
