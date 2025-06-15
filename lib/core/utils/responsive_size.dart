import 'package:flutter/material.dart';

/// ResponsiveSize, ekran boyutlarına göre dinamik değerler sağlar
class ResponsiveSize {
  final BuildContext context;
  final Size _screenSize;

  ResponsiveSize(this.context) : _screenSize = MediaQuery.of(context).size;

  // Ekran genişliği
  double get width => _screenSize.width;

  // Ekran yüksekliği
  double get height => _screenSize.height;

  // Ekran boyutu kontrolü
  bool get isSmallScreen => width < 600;
  bool get isMediumScreen => width >= 600 && width < 1200;
  bool get isLargeScreen => width >= 1200;

  // Duyarlı ölçeklendirme faktörü
  double get scaleFactor {
    if (isLargeScreen) return 1.1;
    if (isMediumScreen) return 0.9;
    return 0.7;
  }

  // Metin ölçeklendirme
  double get textScaleFactor {
    if (isLargeScreen) return 1.1;
    if (isMediumScreen) return 0.9;
    return 0.8;
  }

  // Özel boyutlar
  double get headerFontSize => height * 0.035 * textScaleFactor;
  double get titleFontSize => height * 0.025 * textScaleFactor;
  double get subtitleFontSize => height * 0.022 * textScaleFactor;
  double get bodyFontSize => height * 0.02 * textScaleFactor;
  double get smallFontSize => height * 0.016 * textScaleFactor;

  // Boşluk (padding/margin) değerleri
  double get sidePadding => width * 0.012;
  double get verticalPadding => height * 0.012;
  double get smallPadding => width * 0.008;
  double get tinyPadding => width * 0.004;

  // İkon boyutları
  double get largeIconSize => height * 0.045 * scaleFactor;
  double get mediumIconSize => height * 0.03 * scaleFactor;
  double get smallIconSize => height * 0.025 * scaleFactor;

  // Kalem kalınlıkları
  double get thinStrokeWidth => 15.0 * scaleFactor;
  double get mediumStrokeWidth => 25.0 * scaleFactor;
  double get thickStrokeWidth => 35.0 * scaleFactor;
  double get eraserStrokeWidth => 50.0 * scaleFactor;

  // Çizim alanının boyutları
  double get drawingAreaSize => height * 0.6 > 280 ? height * 0.6 : 280.0;
}
