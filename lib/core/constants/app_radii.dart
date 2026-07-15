import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/widgets.dart';

ScreenSize _screenSize(BuildContext context) =>
    ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

/// Ekran boyutuna göre uyarlanmış köşe yarıçapı sabitleri.
///
/// Widget'larda magic number kullanımının önüne geçer;
/// adaptif tasarım için [ScreenSize] breakpoint'lerine göre değer döndürür.
final class AppRadii {
  const AppRadii._();
  static double cardRadius(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 12,
      ScreenSize.medium => 14,
      ScreenSize.expanded => 16,
      ScreenSize.large => 18,
      ScreenSize.extraLarge => 20,
    };
  }

  static double imageRadius(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 10,
      ScreenSize.medium => 11,
      _ => 12,
    };
  }
}
