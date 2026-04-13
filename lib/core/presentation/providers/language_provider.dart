import 'dart:async';

import 'package:abc123/core/constants/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAppLanguageEnumName = 'app_language_enum_name';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider() {
    unawaited(_restore());
  }

  AppLanguage _language = AppLanguage.turkish;

  AppLanguage get language => _language;

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_kAppLanguageEnumName);
    if (name == null) {
      return;
    }
    try {
      _language = AppLanguage.values.byName(name);
      notifyListeners();
    } on ArgumentError {
      // Bozuk veya eski kayıt: varsayılan Türkçe kalır.
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAppLanguageEnumName, lang.name);
  }
}
