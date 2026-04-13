import 'package:abc123/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Tema tohumu ve marka renkleri (`23_theming.md` / ADR-0016 ile uyumlu).
/// Yeni kodda mümkünse [ColorScheme] / [ThemeExtension] tercih edin.
abstract final class ColorPalette {
  static const Color seed = AppColors.primaryColor;
  static const Color secondary = AppColors.secondaryColor;
  static const Color tertiary = AppColors.accentColor;
  static const Color error = AppColors.errorColor;
  static const Color appBar = AppColors.primaryColor;
  static const Color scaffoldLight = AppColors.backgroundColor;
}
