import 'package:flutter/material.dart';

/// Ekran boyutlarına göre ölçeklendirme yapmak için kullanılan yardımcı sınıf
class ScreenUtil {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late bool isLargeScreen;
  static late bool isMediumScreen;
  static late bool isSmallScreen;

  // Ekran boyutlarını başlatır
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    // Ekran büyüklüğüne göre sınıflandırma
    isLargeScreen = screenWidth > 1200;
    isMediumScreen = screenWidth > 700 && screenWidth <= 1200;
    isSmallScreen = screenWidth <= 700;

    // Varsayılan boyut hesaplama (responsive tasarım için)
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.022
        : screenWidth * 0.022;
  }

  // Yükseklik için ölçeklendirme (ekran yüksekliğine göre)
  static double h(double height) {
    return (height / 812.0) * screenHeight;
  }

  // Genişlik için ölçeklendirme (ekran genişliğine göre)
  static double w(double width) {
    return (width / 375.0) * screenWidth;
  }

  // Yazı tipi boyutu için ölçeklendirme
  static double sp(double size) {
    final scale = isLargeScreen
        ? 1.2
        : isMediumScreen
            ? 1.1
            : 1.0;
    return (size / 375.0) * screenWidth * scale;
  }

  // Ekran boyutuna göre kalem kalınlığını hesapla
  static double calculateStrokeWidth() {
    if (isLargeScreen) {
      return 50.0;
    } else if (isMediumScreen) {
      return 40.0;
    } else {
      return 35.0;
    }
  }

  // Çizim alanı boyutunu hesaplama
  static double calculateDrawingSize() {
    final minSize = 280.0;
    final adaptiveSize = screenHeight * 0.6;
    return adaptiveSize > minSize ? adaptiveSize : minSize;
  }
}
