import 'package:flutter/widgets.dart';

import 'package:abc123/core/presentation/responsive/screen_size.dart';

ScreenSize _screenSize(BuildContext context) =>
    ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

class AppSizes {
  /// Geniş ekran; [ScreenSize] compact dışı (`14_adaptive_ui_strategy.md`).
  static bool isWideLayout(BuildContext context) => _screenSize(context) != ScreenSize.compact;

  static double paddingNormal(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 12,
      ScreenSize.medium => 14,
      ScreenSize.expanded => 16,
      ScreenSize.large => 20,
      ScreenSize.extraLarge => 24,
    };
  }

  static double paddingSmall(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 10,
      ScreenSize.expanded => 12,
      ScreenSize.large => 14,
      ScreenSize.extraLarge => 16,
    };
  }

  static double paddingLarge(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 16,
      ScreenSize.medium => 20,
      ScreenSize.expanded => 24,
      ScreenSize.large => 28,
      ScreenSize.extraLarge => 32,
    };
  }

  static double imageSize(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 72,
      ScreenSize.medium => 88,
      ScreenSize.expanded => 100,
      ScreenSize.large => 112,
      ScreenSize.extraLarge => 120,
    };
  }

  static double drawingAreaSize(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 220,
      ScreenSize.medium => 260,
      ScreenSize.expanded => 300,
      ScreenSize.large => 340,
      ScreenSize.extraLarge => 360,
    };
  }

  static double sliderWidth(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 48,
      ScreenSize.medium => 56,
      ScreenSize.expanded => 64,
      ScreenSize.large => 72,
      ScreenSize.extraLarge => 80,
    };
  }

  static double sliderHeight(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 9,
      _ => 10,
    };
  }

  static double actionBarHeight(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 48,
      ScreenSize.medium => 52,
      ScreenSize.expanded => 56,
      ScreenSize.large => 56,
      ScreenSize.extraLarge => 60,
    };
  }

  static double actionBarButtonFontSize(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 14,
      ScreenSize.medium => 15,
      _ => 16,
    };
  }

  static double actionBarButtonIconSize(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 20,
      ScreenSize.medium => 22,
      _ => 24,
    };
  }

  static double actionBarButtonHPadding(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 10,
      _ => 12,
    };
  }

  static double actionBarButtonVPadding(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 6,
      _ => 8,
    };
  }
}
