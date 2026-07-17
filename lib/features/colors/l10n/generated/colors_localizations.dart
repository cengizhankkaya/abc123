import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'colors_localizations_ar.dart';
import 'colors_localizations_az.dart';
import 'colors_localizations_bn.dart';
import 'colors_localizations_de.dart';
import 'colors_localizations_en.dart';
import 'colors_localizations_es.dart';
import 'colors_localizations_fr.dart';
import 'colors_localizations_hi.dart';
import 'colors_localizations_pt.dart';
import 'colors_localizations_ru.dart';
import 'colors_localizations_tr.dart';
import 'colors_localizations_ur.dart';
import 'colors_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ColorsLocalizations
/// returned by `ColorsLocalizations.of(context)`.
///
/// Applications need to include `ColorsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/colors_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ColorsLocalizations.localizationsDelegates,
///   supportedLocales: ColorsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ColorsLocalizations.supportedLocales
/// property.
abstract class ColorsLocalizations {
  ColorsLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ColorsLocalizations? of(BuildContext context) {
    return Localizations.of<ColorsLocalizations>(context, ColorsLocalizations);
  }

  static const LocalizationsDelegate<ColorsLocalizations> delegate = _ColorsLocalizationsDelegate();

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

  /// l10n: colorGameTitle
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colorGameTitle;

  /// l10n: colorGameInstruction
  ///
  /// In en, this message translates to:
  /// **'Read the word, then tap the matching color below.'**
  String get colorGameInstruction;

  /// l10n: colorNameRed
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get colorNameRed;

  /// l10n: colorNameBlue
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get colorNameBlue;

  /// l10n: colorNameGreen
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get colorNameGreen;

  /// l10n: colorNameYellow
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get colorNameYellow;

  /// l10n: colorNameOrange
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get colorNameOrange;

  /// l10n: colorNamePurple
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get colorNamePurple;

  /// l10n: colorNamePink
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get colorNamePink;

  /// l10n: colorNameCyan
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get colorNameCyan;

  /// l10n: colorNameBrown
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get colorNameBrown;

  /// l10n: colorNameLime
  ///
  /// In en, this message translates to:
  /// **'Lime'**
  String get colorNameLime;

  /// l10n: colorNameTeal
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get colorNameTeal;

  /// l10n: colorNameIndigo
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get colorNameIndigo;

  /// l10n: colorNameMagenta
  ///
  /// In en, this message translates to:
  /// **'Magenta'**
  String get colorNameMagenta;

  /// l10n: colorNameNavy
  ///
  /// In en, this message translates to:
  /// **'Navy'**
  String get colorNameNavy;

  /// l10n: colorNameCoral
  ///
  /// In en, this message translates to:
  /// **'Coral'**
  String get colorNameCoral;

  /// l10n: colorNameGold
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get colorNameGold;

  /// l10n: colorNameViolet
  ///
  /// In en, this message translates to:
  /// **'Violet'**
  String get colorNameViolet;

  /// l10n: colorNameSky
  ///
  /// In en, this message translates to:
  /// **'Sky blue'**
  String get colorNameSky;

  /// l10n: colorChapterTitleBasics
  ///
  /// In en, this message translates to:
  /// **'Chapter 1 · First colors'**
  String get colorChapterTitleBasics;

  /// l10n: colorChapterTitleWide
  ///
  /// In en, this message translates to:
  /// **'Chapter 2 · Bigger palette'**
  String get colorChapterTitleWide;

  /// l10n: colorChapterTitleMaster
  ///
  /// In en, this message translates to:
  /// **'Chapter 3 · Color master'**
  String get colorChapterTitleMaster;

  /// l10n: colorGameChapterProgress
  ///
  /// In en, this message translates to:
  /// **'Chapter {current} of {total}'**
  String colorGameChapterProgress(int current, int total);

  /// l10n: colorGameLevelProgress
  ///
  /// In en, this message translates to:
  /// **'Level {current} of {total}'**
  String colorGameLevelProgress(int current, int total);

  /// l10n: colorGameNextChapterTitle
  ///
  /// In en, this message translates to:
  /// **'New chapter!'**
  String get colorGameNextChapterTitle;

  /// l10n: colorGameNextChapterBody
  ///
  /// In en, this message translates to:
  /// **'A new set of colors is waiting for you.'**
  String get colorGameNextChapterBody;

  /// l10n: colorGameStageProgress
  ///
  /// In en, this message translates to:
  /// **'Stage {current} of {total}'**
  String colorGameStageProgress(int current, int total);

  /// l10n: colorGameRoundProgress
  ///
  /// In en, this message translates to:
  /// **'{done} of {need} correct'**
  String colorGameRoundProgress(int done, int need);

  /// l10n: colorGameTimeLeft
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String colorGameTimeLeft(int seconds);

  /// l10n: colorGameTimeUp
  ///
  /// In en, this message translates to:
  /// **'Time\'s up!'**
  String get colorGameTimeUp;

  /// l10n: colorGameNextStageTitle
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get colorGameNextStageTitle;

  /// l10n: colorGameNextStageBody
  ///
  /// In en, this message translates to:
  /// **'Ready for the next level?'**
  String get colorGameNextStageBody;

  /// l10n: colorGameContinue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get colorGameContinue;

  /// l10n: colorGameVictoryTitle
  ///
  /// In en, this message translates to:
  /// **'Amazing!'**
  String get colorGameVictoryTitle;

  /// l10n: colorGameVictoryBody
  ///
  /// In en, this message translates to:
  /// **'You finished every chapter!'**
  String get colorGameVictoryBody;

  /// l10n: colorGamePlayAgain
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get colorGamePlayAgain;

  /// l10n: colorGameBack
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get colorGameBack;

  /// l10n: colorFeedbackCorrect
  ///
  /// In en, this message translates to:
  /// **'Nice!'**
  String get colorFeedbackCorrect;

  /// l10n: colorFeedbackWrong
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get colorFeedbackWrong;

  /// l10n: colorVisionHomeTitle
  ///
  /// In en, this message translates to:
  /// **'Color shapes'**
  String get colorVisionHomeTitle;

  /// l10n: colorVisionHomeSubtitle
  ///
  /// In en, this message translates to:
  /// **'Playful screening'**
  String get colorVisionHomeSubtitle;

  /// l10n: colorVisionIntroDisclaimer
  ///
  /// In en, this message translates to:
  /// **'Dotted pictures like gentle puzzles help explore how you see colors. This is not a medical test. Ask an eye doctor if you have concerns.'**
  String get colorVisionIntroDisclaimer;

  /// l10n: colorVisionStart
  ///
  /// In en, this message translates to:
  /// **'Let\'s play'**
  String get colorVisionStart;

  /// l10n: colorVisionQuestion
  ///
  /// In en, this message translates to:
  /// **'Which shape do you see in the dots?'**
  String get colorVisionQuestion;

  /// l10n: colorVisionOptionCircle
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get colorVisionOptionCircle;

  /// l10n: colorVisionOptionSquare
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get colorVisionOptionSquare;

  /// l10n: colorVisionOptionTriangle
  ///
  /// In en, this message translates to:
  /// **'Triangle'**
  String get colorVisionOptionTriangle;

  /// l10n: colorVisionOptionNothing
  ///
  /// In en, this message translates to:
  /// **'No shape'**
  String get colorVisionOptionNothing;

  /// l10n: colorVisionProgress
  ///
  /// In en, this message translates to:
  /// **'Plate {current} of {total}'**
  String colorVisionProgress(int current, int total);

  /// l10n: colorVisionScoreLine
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} matched'**
  String colorVisionScoreLine(int correct, int total);

  /// l10n: colorVisionResultsTitle
  ///
  /// In en, this message translates to:
  /// **'Round complete!'**
  String get colorVisionResultsTitle;

  /// l10n: colorVisionResultsGood
  ///
  /// In en, this message translates to:
  /// **'You spotted most shapes — nice!'**
  String get colorVisionResultsGood;

  /// l10n: colorVisionResultsMixed
  ///
  /// In en, this message translates to:
  /// **'Some plates were tricky. That happens to many kids.'**
  String get colorVisionResultsMixed;

  /// l10n: colorVisionResultsLow
  ///
  /// In en, this message translates to:
  /// **'Many shapes were hard to see. This game cannot diagnose color vision. A specialist can help if you are worried.'**
  String get colorVisionResultsLow;

  /// l10n: colorVisionResultsMedicalNote
  ///
  /// In en, this message translates to:
  /// **'For learning and curiosity only. It does not replace professional eye care.'**
  String get colorVisionResultsMedicalNote;

  /// l10n: colorVisionPlayAgain
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get colorVisionPlayAgain;

  /// l10n: colorVisionIntroTitle
  ///
  /// In en, this message translates to:
  /// **'Hidden shapes'**
  String get colorVisionIntroTitle;

  /// l10n: colorVisionPlateBadgeRg
  ///
  /// In en, this message translates to:
  /// **'Red · green mix'**
  String get colorVisionPlateBadgeRg;

  /// l10n: colorVisionPlateBadgeBy
  ///
  /// In en, this message translates to:
  /// **'Blue · yellow mix'**
  String get colorVisionPlateBadgeBy;

  /// l10n: colorVisionOptionDiamond
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get colorVisionOptionDiamond;

  /// l10n: colorVisionResultHintTitle
  ///
  /// In en, this message translates to:
  /// **'Playful summary'**
  String get colorVisionResultHintTitle;

  /// l10n: colorVisionProfileTypical
  ///
  /// In en, this message translates to:
  /// **'On these plates your answers look similar to typical color vision for kids.'**
  String get colorVisionProfileTypical;

  /// l10n: colorVisionProfileRedGreenAxis
  ///
  /// In en, this message translates to:
  /// **'You missed more red–green style plates. That pattern is often discussed with red–green color blindness (protanopia or deuteranopia family). This app cannot separate those types.'**
  String get colorVisionProfileRedGreenAxis;

  /// l10n: colorVisionProfileBlueYellowAxis
  ///
  /// In en, this message translates to:
  /// **'You missed more blue–yellow style plates. That can sometimes relate to blue–yellow (tritan-type) difficulty — only an eye specialist can say for sure.'**
  String get colorVisionProfileBlueYellowAxis;

  /// l10n: colorVisionProfileMixed
  ///
  /// In en, this message translates to:
  /// **'Both plate styles were difficult. Screen brightness, night mode, or tired eyes can change scores. Try again in good light.'**
  String get colorVisionProfileMixed;

  /// l10n: colorVisionProfileInconclusive
  ///
  /// In en, this message translates to:
  /// **'No clear pattern — try again on a bright screen at arm’s length.'**
  String get colorVisionProfileInconclusive;

  /// l10n: colorVisionScoreRgLine
  ///
  /// In en, this message translates to:
  /// **'Red–green style: {correct} / {total}'**
  String colorVisionScoreRgLine(int correct, int total);

  /// l10n: colorVisionScoreByLine
  ///
  /// In en, this message translates to:
  /// **'Blue–yellow style: {correct} / {total}'**
  String colorVisionScoreByLine(int correct, int total);

  /// No description provided for @colorFailureLoad.
  ///
  /// In en, this message translates to:
  /// **'Game could not be loaded. Please try again.'**
  String get colorFailureLoad;

  /// No description provided for @colorFailurePalette.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch color palette.'**
  String get colorFailurePalette;

  /// No description provided for @colorFailureUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get colorFailureUnknown;
}

class _ColorsLocalizationsDelegate extends LocalizationsDelegate<ColorsLocalizations> {
  const _ColorsLocalizationsDelegate();

  @override
  Future<ColorsLocalizations> load(Locale locale) {
    return SynchronousFuture<ColorsLocalizations>(lookupColorsLocalizations(locale));
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
  bool shouldReload(_ColorsLocalizationsDelegate old) => false;
}

ColorsLocalizations lookupColorsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ColorsLocalizationsAr();
    case 'az':
      return ColorsLocalizationsAz();
    case 'bn':
      return ColorsLocalizationsBn();
    case 'de':
      return ColorsLocalizationsDe();
    case 'en':
      return ColorsLocalizationsEn();
    case 'es':
      return ColorsLocalizationsEs();
    case 'fr':
      return ColorsLocalizationsFr();
    case 'hi':
      return ColorsLocalizationsHi();
    case 'pt':
      return ColorsLocalizationsPt();
    case 'ru':
      return ColorsLocalizationsRu();
    case 'tr':
      return ColorsLocalizationsTr();
    case 'ur':
      return ColorsLocalizationsUr();
    case 'zh':
      return ColorsLocalizationsZh();
  }

  throw FlutterError(
      'ColorsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
