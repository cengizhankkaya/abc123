import 'dart:async';

import 'package:abc123/core/theme/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAppThemeModeName = 'app_theme_mode_name';

/// Tema modu kalıcılığı. ADR-0015’teki HydratedBloc + ThemeCubit yerine
/// mevcut yığınla (Provider + [SharedPreferences]) uygulanır.
class ThemeModeProvider extends ChangeNotifier {
  ThemeModeProvider() {
    unawaited(_restore());
  }

  AppThemeMode _mode = AppThemeMode.system;

  AppThemeMode get appThemeMode => _mode;

  ThemeMode get materialThemeMode => _mode.asThemeMode;

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_kAppThemeModeName);
    if (name == null) {
      return;
    }
    for (final v in AppThemeMode.values) {
      if (v.name == name) {
        _mode = v;
        notifyListeners();
        return;
      }
    }
  }

  Future<void> setAppThemeMode(AppThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAppThemeModeName, mode.name);
  }
}
