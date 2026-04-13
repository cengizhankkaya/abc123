import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/features/draw/l10n/generated/draw_localizations.dart';
import 'package:abc123/features/home/l10n/generated/home_localizations.dart';
import 'package:abc123/features/info/l10n/generated/info_localizations.dart';
import 'package:abc123/features/shapes/l10n/generated/shapes_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';

/// `18_i18n.md`: tüm özellik delegeleri + Material/Cupertino/Widgets.
const List<LocalizationsDelegate<dynamic>> kAppLocalizationDelegates = [
  AppLocalizations.delegate,
  HomeLocalizations.delegate,
  DrawLocalizations.delegate,
  ShapesLocalizations.delegate,
  InfoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

List<Locale> get kAppSupportedLocales => AppLocalizations.supportedLocales;
