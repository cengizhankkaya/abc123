import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

/// Uygulama tema ayarlarını yöneten sınıf
class AppTheme {
  // Ana tema
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimaryColor,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondaryColor,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
            error: AppColors.errorColor,
          )
          .copyWith(surface: AppColors.backgroundColor),
    );
  }

  // Dinamik metin stilleri
  static TextStyle headingLarge(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(24),
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryColor,
    );
  }

  static TextStyle headingMedium(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(20),
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryColor,
    );
  }

  static TextStyle headingSmall(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(16),
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryColor,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(16),
      color: AppColors.textSecondaryColor,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(14),
      color: AppColors.textSecondaryColor,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: ScreenUtil.sp(12),
      color: AppColors.textTertiaryColor,
    );
  }

  // Yaygın kullanılan dekorasyon stilleri
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    );
  }

  static BoxDecoration panelHeaderDecoration() {
    return const BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    );
  }
}
