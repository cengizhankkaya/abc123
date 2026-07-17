import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ar_localizations_ar.dart';
import 'ar_localizations_az.dart';
import 'ar_localizations_bn.dart';
import 'ar_localizations_de.dart';
import 'ar_localizations_en.dart';
import 'ar_localizations_es.dart';
import 'ar_localizations_fr.dart';
import 'ar_localizations_hi.dart';
import 'ar_localizations_pt.dart';
import 'ar_localizations_ru.dart';
import 'ar_localizations_tr.dart';
import 'ar_localizations_ur.dart';
import 'ar_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ArLocalizations
/// returned by `ArLocalizations.of(context)`.
///
/// Applications need to include `ArLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/ar_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ArLocalizations.localizationsDelegates,
///   supportedLocales: ArLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ArLocalizations.supportedLocales
/// property.
abstract class ArLocalizations {
  ArLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ArLocalizations? of(BuildContext context) {
    return Localizations.of<ArLocalizations>(context, ArLocalizations);
  }

  static const LocalizationsDelegate<ArLocalizations> delegate = _ArLocalizationsDelegate();

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

  /// No description provided for @arAnimalsExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore Animals'**
  String get arAnimalsExplore;

  /// No description provided for @arAnimalsQuizMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Quiz Mode'**
  String get arAnimalsQuizMode;

  /// No description provided for @arAnimals3dDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore animals in 3D\nand play a fun quiz!'**
  String get arAnimals3dDesc;

  /// No description provided for @arAnimalsView3d.
  ///
  /// In en, this message translates to:
  /// **'View 3D →'**
  String get arAnimalsView3d;

  /// No description provided for @arAnimalsInstruction.
  ///
  /// In en, this message translates to:
  /// **'👆 Drag to rotate  •  📦 Tap bottom right button for AR'**
  String get arAnimalsInstruction;

  /// No description provided for @arViewerDragInstruction.
  ///
  /// In en, this message translates to:
  /// **'👆 Drag to rotate!\n📦 Tap the bottom right button to view in your room.'**
  String get arViewerDragInstruction;

  /// No description provided for @arViewerNoModelTitle.
  ///
  /// In en, this message translates to:
  /// **'No 3D model yet\nfor the letter \"{letter}\"'**
  String arViewerNoModelTitle(String letter);

  /// No description provided for @arViewerComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon! 🎉'**
  String get arViewerComingSoon;

  /// No description provided for @arModelNameAt.
  ///
  /// In en, this message translates to:
  /// **'Horse'**
  String get arModelNameAt;

  /// No description provided for @arModelNameBalik.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get arModelNameBalik;

  /// No description provided for @arModelNameCivciv.
  ///
  /// In en, this message translates to:
  /// **'Chick'**
  String get arModelNameCivciv;

  /// No description provided for @arModelNameCicek.
  ///
  /// In en, this message translates to:
  /// **'Flower'**
  String get arModelNameCicek;

  /// No description provided for @arModelNameDomuz.
  ///
  /// In en, this message translates to:
  /// **'Pig'**
  String get arModelNameDomuz;

  /// No description provided for @arModelNameElma.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get arModelNameElma;

  /// No description provided for @arModelNameFil.
  ///
  /// In en, this message translates to:
  /// **'Elephant'**
  String get arModelNameFil;

  /// No description provided for @arModelNameGemi.
  ///
  /// In en, this message translates to:
  /// **'Ship'**
  String get arModelNameGemi;

  /// No description provided for @arModelNameGunes.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get arModelNameGunes;

  /// No description provided for @arModelNameHoroz.
  ///
  /// In en, this message translates to:
  /// **'Rooster'**
  String get arModelNameHoroz;

  /// No description provided for @arModelNameIrgatci.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get arModelNameIrgatci;

  /// No description provided for @arModelNameInek.
  ///
  /// In en, this message translates to:
  /// **'Cow'**
  String get arModelNameInek;

  /// No description provided for @arModelNameJaguar.
  ///
  /// In en, this message translates to:
  /// **'Jaguar'**
  String get arModelNameJaguar;

  /// No description provided for @arModelNameKedi.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get arModelNameKedi;

  /// No description provided for @arModelNameLimon.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get arModelNameLimon;

  /// No description provided for @arModelNameMuz.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get arModelNameMuz;

  /// No description provided for @arModelNameNar.
  ///
  /// In en, this message translates to:
  /// **'Pomegranate'**
  String get arModelNameNar;

  /// No description provided for @arModelNameOrdek.
  ///
  /// In en, this message translates to:
  /// **'Duck'**
  String get arModelNameOrdek;

  /// No description provided for @arModelNamePanda.
  ///
  /// In en, this message translates to:
  /// **'Panda'**
  String get arModelNamePanda;

  /// No description provided for @arModelNameRobot.
  ///
  /// In en, this message translates to:
  /// **'Robot'**
  String get arModelNameRobot;

  /// No description provided for @arModelNameSincap.
  ///
  /// In en, this message translates to:
  /// **'Squirrel'**
  String get arModelNameSincap;

  /// No description provided for @arModelNameSampinyon.
  ///
  /// In en, this message translates to:
  /// **'Mushroom'**
  String get arModelNameSampinyon;

  /// No description provided for @arModelNameTavuk.
  ///
  /// In en, this message translates to:
  /// **'Chicken'**
  String get arModelNameTavuk;

  /// No description provided for @arModelNameUzayli.
  ///
  /// In en, this message translates to:
  /// **'Alien'**
  String get arModelNameUzayli;

  /// No description provided for @arModelNameUzum.
  ///
  /// In en, this message translates to:
  /// **'Grapes'**
  String get arModelNameUzum;

  /// No description provided for @arModelNameVagon.
  ///
  /// In en, this message translates to:
  /// **'Wagon'**
  String get arModelNameVagon;

  /// No description provided for @arModelNameYildiz.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get arModelNameYildiz;

  /// No description provided for @arModelNameZurafa.
  ///
  /// In en, this message translates to:
  /// **'Giraffe'**
  String get arModelNameZurafa;

  /// No description provided for @arFactAt.
  ///
  /// In en, this message translates to:
  /// **'Horses can run up to 70 km/h!'**
  String get arFactAt;

  /// No description provided for @arFactBalik.
  ///
  /// In en, this message translates to:
  /// **'Fish can breathe underwater!'**
  String get arFactBalik;

  /// No description provided for @arFactCivciv.
  ///
  /// In en, this message translates to:
  /// **'Chicks can walk immediately after hatching!'**
  String get arFactCivciv;

  /// No description provided for @arFactDomuz.
  ///
  /// In en, this message translates to:
  /// **'Pigs are very intelligent animals!'**
  String get arFactDomuz;

  /// No description provided for @arFactKedi.
  ///
  /// In en, this message translates to:
  /// **'Cats can sleep for 16 hours a day!'**
  String get arFactKedi;

  /// No description provided for @arFactElma.
  ///
  /// In en, this message translates to:
  /// **'Apple trees can live for 100 years!'**
  String get arFactElma;
}

class _ArLocalizationsDelegate extends LocalizationsDelegate<ArLocalizations> {
  const _ArLocalizationsDelegate();

  @override
  Future<ArLocalizations> load(Locale locale) {
    return SynchronousFuture<ArLocalizations>(lookupArLocalizations(locale));
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
  bool shouldReload(_ArLocalizationsDelegate old) => false;
}

ArLocalizations lookupArLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ArLocalizationsAr();
    case 'az':
      return ArLocalizationsAz();
    case 'bn':
      return ArLocalizationsBn();
    case 'de':
      return ArLocalizationsDe();
    case 'en':
      return ArLocalizationsEn();
    case 'es':
      return ArLocalizationsEs();
    case 'fr':
      return ArLocalizationsFr();
    case 'hi':
      return ArLocalizationsHi();
    case 'pt':
      return ArLocalizationsPt();
    case 'ru':
      return ArLocalizationsRu();
    case 'tr':
      return ArLocalizationsTr();
    case 'ur':
      return ArLocalizationsUr();
    case 'zh':
      return ArLocalizationsZh();
  }

  throw FlutterError(
      'ArLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
