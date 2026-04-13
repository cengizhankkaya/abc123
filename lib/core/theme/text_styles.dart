import 'package:abc123/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Bağlama duyarlı tipografi — renkler [ColorScheme] üzerinden okunur.
abstract final class AppTextStyles {
  static TextStyle headlineLarge(BuildContext context) =>
      AppTheme.headingLarge(context);

  static TextStyle headlineMedium(BuildContext context) =>
      AppTheme.headingMedium(context);

  static TextStyle headlineSmall(BuildContext context) =>
      AppTheme.headingSmall(context);

  static TextStyle bodyLarge(BuildContext context) => AppTheme.bodyLarge(context);

  static TextStyle bodyMedium(BuildContext context) =>
      AppTheme.bodyMedium(context);

  static TextStyle bodySmall(BuildContext context) => AppTheme.bodySmall(context);
}
