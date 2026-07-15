/// Uygulama genelinde kullanılan süre sabitleri.
///
/// Animasyon, debounce ve timeout gibi `Duration` değerlerini merkezi olarak
/// tanımlar; widget ve servis katmanlarında magic number kullanımının önüne geçer.
///
/// Örnek kullanım:
/// ```dart
/// await Future.delayed(DurationConstants.debounce);
/// AnimatedContainer(duration: DurationConstants.animationMedium, ...);
/// ```
final class DurationConstants {
  const DurationConstants._();

  /// Kısa UI animasyonları için süre (200 ms).
  static const Duration animationShort = Duration(milliseconds: 200);

  /// Standart UI animasyonları için süre (300 ms).
  static const Duration animationMedium = Duration(milliseconds: 300);

  /// Kullanıcı giriş debounce süresi — arama, form doğrulama vb. (300 ms).
  static const Duration debounce = Duration(milliseconds: 300);

  /// Ağ isteği ve işlem zaman aşımı süresi (30 sn).
  static const Duration timeout = Duration(seconds: 30);
}
