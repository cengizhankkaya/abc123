import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'shapes_localizations_ar.dart';
import 'shapes_localizations_az.dart';
import 'shapes_localizations_bn.dart';
import 'shapes_localizations_de.dart';
import 'shapes_localizations_en.dart';
import 'shapes_localizations_es.dart';
import 'shapes_localizations_fr.dart';
import 'shapes_localizations_hi.dart';
import 'shapes_localizations_pt.dart';
import 'shapes_localizations_ru.dart';
import 'shapes_localizations_tr.dart';
import 'shapes_localizations_ur.dart';
import 'shapes_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ShapesLocalizations
/// returned by `ShapesLocalizations.of(context)`.
///
/// Applications need to include `ShapesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/shapes_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ShapesLocalizations.localizationsDelegates,
///   supportedLocales: ShapesLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ShapesLocalizations.supportedLocales
/// property.
abstract class ShapesLocalizations {
  ShapesLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ShapesLocalizations? of(BuildContext context) {
    return Localizations.of<ShapesLocalizations>(context, ShapesLocalizations);
  }

  static const LocalizationsDelegate<ShapesLocalizations> delegate = _ShapesLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('az'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
    Locale('zh')
  ];

  /// l10n: shapeDaire
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get shapeDaire;

  /// l10n: shapeKare
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get shapeKare;

  /// l10n: shapeUcgen
  ///
  /// In en, this message translates to:
  /// **'Triangle'**
  String get shapeUcgen;
}

class _ShapesLocalizationsDelegate extends LocalizationsDelegate<ShapesLocalizations> {
  const _ShapesLocalizationsDelegate();

  @override
  Future<ShapesLocalizations> load(Locale locale) {
    return SynchronousFuture<ShapesLocalizations>(lookupShapesLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'az',
        'bn',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'pt',
        'ru',
        'tr',
        'ur',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_ShapesLocalizationsDelegate old) => false;
}

ShapesLocalizations lookupShapesLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ShapesLocalizationsAr();
    case 'az':
      return ShapesLocalizationsAz();
    case 'bn':
      return ShapesLocalizationsBn();
    case 'de':
      return ShapesLocalizationsDe();
    case 'en':
      return ShapesLocalizationsEn();
    case 'es':
      return ShapesLocalizationsEs();
    case 'fr':
      return ShapesLocalizationsFr();
    case 'hi':
      return ShapesLocalizationsHi();
    case 'pt':
      return ShapesLocalizationsPt();
    case 'ru':
      return ShapesLocalizationsRu();
    case 'tr':
      return ShapesLocalizationsTr();
    case 'ur':
      return ShapesLocalizationsUr();
    case 'zh':
      return ShapesLocalizationsZh();
  }

  throw FlutterError(
      'ShapesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
