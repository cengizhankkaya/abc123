import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/widgets.dart';

ScreenSize _screenSize(BuildContext context) =>
    ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

/// Ekran boyutuna göre uyarlanmış yazı boyutu sabitleri.
///
/// Tüm text style tanımlarında magic number yerine bu sınıf kullanılır;
/// [ScreenSize] breakpoint'lerine göre adaptif font boyutları döndürür.
final class AppFontSizes {
  const AppFontSizes._();
  static double title(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 22,
      ScreenSize.medium => 24,
      ScreenSize.expanded => 26,
      ScreenSize.large => 28,
      ScreenSize.extraLarge => 30,
    };
  }

  static double subtitle(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 16,
      ScreenSize.medium => 17,
      ScreenSize.expanded => 18,
      ScreenSize.large => 19,
      ScreenSize.extraLarge => 20,
    };
  }
}
