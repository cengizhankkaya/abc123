import 'package:abc123/core/constants/language_constants.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  AppLanguage _language = AppLanguage.turkish;

  AppLanguage get language => _language;

  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }
}
