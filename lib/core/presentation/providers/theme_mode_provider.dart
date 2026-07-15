import 'package:abc123/core/theme/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAppThemeModeName = 'app_theme_mode_name';

/// Tema modu kalıcılığı. ADR-0015'teki HydratedBloc + ThemeCubit yerine
/// mevcut yığınla (Provider + [SharedPreferences]) uygulanır.
class ThemeModeProvider extends ChangeNotifier {
  ThemeModeProvider(this._prefs) {
    _restore();
  }

  final SharedPreferences _prefs;

  AppThemeMode _mode = AppThemeMode.system;

  AppThemeMode get appThemeMode => _mode;

  ThemeMode get materialThemeMode => _mode.asThemeMode;

  void _restore() {
    final name = _prefs.getString(_kAppThemeModeName);
    if (name == null) return;
    for (final v in AppThemeMode.values) {
      if (v.name == name) {
        _mode = v;
        notifyListeners();
        return;
      }
    }
  }

  Future<void> setAppThemeMode(AppThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    await _prefs.setString(_kAppThemeModeName, mode.name);
  }
}
