import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:abc123/core/theme/color_palette.dart';
import 'package:abc123/core/theme/theme_extensions.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ScreenSize _screenSize(BuildContext context) =>
    ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

/// FlexColorScheme + Material 3 (`23_theming.md`, ADR-0015).
abstract final class AppTheme {
  static final FlexSchemeColor _flexLight = FlexSchemeColor.from(
    primary: ColorPalette.seed,
    secondary: ColorPalette.secondary,
    tertiary: ColorPalette.tertiary,
    error: ColorPalette.error,
    appBarColor: ColorPalette.appBar,
  );

  static final FlexSchemeColor _flexDark = _flexLight.toDark();

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      colors: _flexLight,
      scaffoldBackground: ColorPalette.scaffoldLight,
      extensions: const <ThemeExtension<dynamic>>[
        SemanticColors.light,
        MathColors.light,
      ],
      subThemesData: const FlexSubThemesData(
        elevatedButtonRadius: 10,
        elevatedButtonElevation: 4,
      ),
    ).copyWith(
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
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: _flexDark,
      extensions: const <ThemeExtension<dynamic>>[
        SemanticColors.dark,
        MathColors.dark,
      ],
      subThemesData: const FlexSubThemesData(
        elevatedButtonRadius: 10,
        elevatedButtonElevation: 4,
      ),
    ).copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  static double _step(
    BuildContext context, {
    required double compact,
    required double medium,
    required double expanded,
    required double large,
    required double extraLarge,
  }) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => compact,
      ScreenSize.medium => medium,
      ScreenSize.expanded => expanded,
      ScreenSize.large => large,
      ScreenSize.extraLarge => extraLarge,
    };
  }

  static TextStyle headingLarge(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 20, medium: 22, expanded: 24, large: 26, extraLarge: 28),
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
    );
  }

  static TextStyle headingMedium(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 18, medium: 19, expanded: 20, large: 21, extraLarge: 22),
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
    );
  }

  static TextStyle headingSmall(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 15, medium: 15.5, expanded: 16, large: 17, extraLarge: 18),
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 15, medium: 15.5, expanded: 16, large: 17, extraLarge: 18),
      color: scheme.onSurfaceVariant,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 13, medium: 13.5, expanded: 14, large: 15, extraLarge: 16),
      color: scheme.onSurfaceVariant,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    final scheme = ColorScheme.of(context);
    return TextStyle(
      fontSize: _step(context, compact: 11, medium: 11.5, expanded: 12, large: 13, extraLarge: 14),
      color: scheme.outline,
    );
  }

  static BoxDecoration cardDecoration({Color? surface}) {
    return BoxDecoration(
      color: surface ?? Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
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
