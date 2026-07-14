import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// Çizim ve araç çubuğu için [ScreenSize] tabanlı sabit adımlar (`14_adaptive_ui_strategy.md`).
class ResponsiveSize {
  ResponsiveSize(this.context)
      : _screenSize = ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

  final BuildContext context;
  final ScreenSize _screenSize;

  Size get _logicalSize => MediaQuery.sizeOf(context);

  double get width => _logicalSize.width;

  double get height => _logicalSize.height;

  bool get isSmallScreen => _screenSize == ScreenSize.compact;
  bool get isMediumScreen => _screenSize == ScreenSize.medium || _screenSize == ScreenSize.expanded;
  bool get isLargeScreen => _screenSize == ScreenSize.large || _screenSize == ScreenSize.extraLarge;

  double get headerFontSize {
    return switch (_screenSize) {
      ScreenSize.compact => 18,
      ScreenSize.medium => 20,
      ScreenSize.expanded => 22,
      ScreenSize.large => 24,
      ScreenSize.extraLarge => 26,
    };
  }

  double get titleFontSize {
    return switch (_screenSize) {
      ScreenSize.compact => 16,
      ScreenSize.medium => 17,
      ScreenSize.expanded => 18,
      ScreenSize.large => 19,
      ScreenSize.extraLarge => 20,
    };
  }

  double get subtitleFontSize {
    return switch (_screenSize) {
      ScreenSize.compact => 14,
      ScreenSize.medium => 15,
      ScreenSize.expanded => 16,
      ScreenSize.large => 17,
      ScreenSize.extraLarge => 18,
    };
  }

  double get bodyFontSize {
    return switch (_screenSize) {
      ScreenSize.compact => 13,
      ScreenSize.medium => 14,
      _ => 15,
    };
  }

  double get smallFontSize {
    return switch (_screenSize) {
      ScreenSize.compact => 11,
      ScreenSize.medium => 12,
      _ => 13,
    };
  }

  double get sidePadding {
    return switch (_screenSize) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 12,
      ScreenSize.expanded => 14,
      ScreenSize.large => 16,
      ScreenSize.extraLarge => 20,
    };
  }

  double get verticalPadding {
    return switch (_screenSize) {
      ScreenSize.compact => 8,
      ScreenSize.medium => 10,
      _ => 12,
    };
  }

  double get smallPadding {
    return switch (_screenSize) {
      ScreenSize.compact => 6,
      _ => 8,
    };
  }

  double get tinyPadding => 4;

  double get largeIconSize {
    return switch (_screenSize) {
      ScreenSize.compact => 32,
      ScreenSize.medium => 36,
      ScreenSize.expanded => 40,
      ScreenSize.large => 44,
      ScreenSize.extraLarge => 48,
    };
  }

  double get mediumIconSize {
    return switch (_screenSize) {
      ScreenSize.compact => 24,
      ScreenSize.medium => 26,
      _ => 28,
    };
  }

  double get smallIconSize => mediumIconSize;

  double get tinyIconSize {
    return switch (_screenSize) {
      ScreenSize.compact => 18,
      _ => 20,
    };
  }

  double get thinStrokeWidth {
    return switch (_screenSize) {
      ScreenSize.compact => 12,
      ScreenSize.medium => 14,
      ScreenSize.expanded => 16,
      ScreenSize.large => 18,
      ScreenSize.extraLarge => 20,
    };
  }

  double get mediumStrokeWidth {
    return switch (_screenSize) {
      ScreenSize.compact => 22,
      ScreenSize.medium => 24,
      ScreenSize.expanded => 26,
      ScreenSize.large => 28,
      ScreenSize.extraLarge => 30,
    };
  }

  double get thickStrokeWidth {
    return switch (_screenSize) {
      ScreenSize.compact => 30,
      ScreenSize.medium => 32,
      ScreenSize.expanded => 34,
      ScreenSize.large => 36,
      ScreenSize.extraLarge => 38,
    };
  }

  double get eraserStrokeWidth {
    return switch (_screenSize) {
      ScreenSize.compact => 44,
      ScreenSize.medium => 46,
      ScreenSize.expanded => 48,
      ScreenSize.large => 50,
      ScreenSize.extraLarge => 52,
    };
  }

  /// Çizim alanı: yüksekliğe bağlı üst sınır + sınıf bazlı tavan (`14_adaptive_ui_strategy.md`).
  double get drawingAreaSize {
    final maxCap = switch (_screenSize) {
      ScreenSize.compact => 320.0,
      ScreenSize.medium => 380.0,
      ScreenSize.expanded => 440.0,
      ScreenSize.large => 520.0,
      ScreenSize.extraLarge => 580.0,
    };
    final fromHeight = height * 0.52;
    return fromHeight.clamp(280.0, maxCap);
  }
}
