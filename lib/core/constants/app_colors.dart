import 'package:flutter/material.dart';

/// Uygulama genelinde kullanılan renk sabitleri.
class AppColors {
  // Ana renkler
  static const Color backgroundColor = Color(0xFFBCC9D7);
  static const Color primaryColor = Color(0xFF2196F3); // Maviß
  static const Color secondaryColor = Color(0xFF03DAC6); // Turkuaz
  static const Color accentColor = Color(0xFFFFC107); // Amber
  static const Color panelColor = Color.fromARGB(255, 27, 138, 229); // Mavi

  // Nötr renkler
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020); // Kırmızı

  // Metin renkleri
  static const Color textPrimaryColor = Color(0xFF212121); // Koyu gri
  static const Color textSecondaryColor = Color(0xFF757575); // Orta gri
  static const Color textTertiaryColor = Color(0xFFBDBDBD); // Açık gri

  // Durum renkleri
  static const Color successColor = Color(0xFF4CAF50); // Yeşil
  static const Color warningColor = Color(0xFFFF9800); // Turuncu
  static const Color infoColor = Color(0xFF2196F3); // Mavi

  // Diğer kullanılabilecek renkler
  static const Color disabledColor = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFFEEEEEE);
  static const Color shadowColor = Color(0x1A000000); // %10 siyah opaklık
}
