import 'package:flutter/material.dart';

/// Tema tercihi (ADR-0015 ile uyumlu; Flutter [ThemeMode] sınırında eşlenir).
enum AppThemeMode {
  light,
  dark,
  system,
}

extension AppThemeModeX on AppThemeMode {
  ThemeMode get asThemeMode => switch (this) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };
}
