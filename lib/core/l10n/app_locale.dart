import 'package:abc123/core/constants/language_constants.dart';
import 'package:flutter/material.dart';

/// [AppLanguage] → BCP 47 dil kodu (`18_i18n.md`, çoklu ARB ile uyumlu).
String localeCodeForAppLanguage(AppLanguage language) => switch (language) {
      AppLanguage.turkish => 'tr',
      AppLanguage.english => 'en',
      AppLanguage.chinese => 'zh',
      AppLanguage.spanish => 'es',
      AppLanguage.hindi => 'hi',
      AppLanguage.french => 'fr',
      AppLanguage.arabic => 'ar',
      AppLanguage.portuguese => 'pt',
      AppLanguage.bengali => 'bn',
      AppLanguage.russian => 'ru',
      AppLanguage.urdu => 'ur',
      AppLanguage.azerbaijani => 'az',
      AppLanguage.german => 'de',
    };

Locale materialLocaleForAppLanguage(AppLanguage language) =>
    Locale(localeCodeForAppLanguage(language));
