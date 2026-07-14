import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  /// Geçerli [ScreenSize].
  ScreenSize get screenSize {
    final width = MediaQuery.sizeOf(this).width;
    return ScreenSize.fromWidth(width);
  }

  bool get isMobile => screenSize.isMobile;

  bool get supportsTwoPane => screenSize.supportsTwoPane;

  bool get supportsThreePane => screenSize.supportsThreePane;

  /// Yatay/düşey padding (doc önerisi).
  EdgeInsets get responsivePadding {
    return EdgeInsets.all(screenSize.isMobile ? 16 : 24);
  }

  /// [ScreenSize]’a göre boşluk adımı.
  double get responsiveSpacing {
    return switch (screenSize) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 12,
      ScreenSize.expanded => 16,
      ScreenSize.large => 20,
      ScreenSize.extraLarge => 24,
    };
  }
}
