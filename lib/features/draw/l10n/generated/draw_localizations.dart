import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'draw_localizations_ar.dart';
import 'draw_localizations_az.dart';
import 'draw_localizations_bn.dart';
import 'draw_localizations_de.dart';
import 'draw_localizations_en.dart';
import 'draw_localizations_es.dart';
import 'draw_localizations_fr.dart';
import 'draw_localizations_hi.dart';
import 'draw_localizations_pt.dart';
import 'draw_localizations_ru.dart';
import 'draw_localizations_tr.dart';
import 'draw_localizations_ur.dart';
import 'draw_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of DrawLocalizations
/// returned by `DrawLocalizations.of(context)`.
///
/// Applications need to include `DrawLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/draw_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DrawLocalizations.localizationsDelegates,
///   supportedLocales: DrawLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the DrawLocalizations.supportedLocales
/// property.
abstract class DrawLocalizations {
  DrawLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DrawLocalizations? of(BuildContext context) {
    return Localizations.of<DrawLocalizations>(context, DrawLocalizations);
  }

  static const LocalizationsDelegate<DrawLocalizations> delegate = _DrawLocalizationsDelegate();

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

  /// l10n: drawNumberInstruction
  ///
  /// In en, this message translates to:
  /// **'Draw the number {number}'**
  String drawNumberInstruction(String number);

  /// l10n: drawAnyNumberInstruction
  ///
  /// In en, this message translates to:
  /// **'Draw a number'**
  String get drawAnyNumberInstruction;

  /// l10n: watchAdToUnlock
  ///
  /// In en, this message translates to:
  /// **'Watch ads to earn points and unlock this section'**
  String get watchAdToUnlock;

  /// l10n: drawSequentialMode
  ///
  /// In en, this message translates to:
  /// **'Sequential Drawing Mode:'**
  String get drawSequentialMode;

  /// l10n: drawCorrectTotal
  ///
  /// In en, this message translates to:
  /// **'Correct: {correct} / Total: {total}'**
  String drawCorrectTotal(int correct, int total);

  /// l10n: drawClear
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get drawClear;

  /// l10n: drawPen
  ///
  /// In en, this message translates to:
  /// **'Pen'**
  String get drawPen;

  /// l10n: drawEraser
  ///
  /// In en, this message translates to:
  /// **'Eraser'**
  String get drawEraser;

  /// l10n: drawRecognize
  ///
  /// In en, this message translates to:
  /// **'Recognize'**
  String get drawRecognize;

  /// l10n: drawPenColor
  ///
  /// In en, this message translates to:
  /// **'Pen Color'**
  String get drawPenColor;

  /// l10n: drawNumberSectionTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Numbers'**
  String get drawNumberSectionTitle;

  /// l10n: drawLetterSectionTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Letters'**
  String get drawLetterSectionTitle;

  /// l10n: drawShapeSectionTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Shapes'**
  String get drawShapeSectionTitle;

  /// l10n: drawWordSectionTitle
  ///
  /// In en, this message translates to:
  /// **'Build Words'**
  String get drawWordSectionTitle;

  /// l10n: drawLetterPuzzlePreparing
  ///
  /// In en, this message translates to:
  /// **'Preparing puzzle…'**
  String get drawLetterPuzzlePreparing;

  /// l10n: drawGamePausedTitle
  ///
  /// In en, this message translates to:
  /// **'GAME PAUSED'**
  String get drawGamePausedTitle;

  /// l10n: drawContinue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get drawContinue;

  /// l10n: drawStartGame
  ///
  /// In en, this message translates to:
  /// **'START GAME'**
  String get drawStartGame;

  /// l10n: drawBalloonReady
  ///
  /// In en, this message translates to:
  /// **'Ready to play with {count} balloons?'**
  String drawBalloonReady(int count);

  /// l10n: drawBalloonScoreHint
  ///
  /// In en, this message translates to:
  /// **'Pop balloons to earn points!\nThe smaller the balloon, the more points you get.'**
  String get drawBalloonScoreHint;

  /// l10n: drawSemanticMute
  ///
  /// In en, this message translates to:
  /// **'Mute sounds'**
  String get drawSemanticMute;

  /// l10n: drawSemanticUnmute
  ///
  /// In en, this message translates to:
  /// **'Unmute sounds'**
  String get drawSemanticUnmute;

  /// l10n: drawSemanticDrawingCanvas
  ///
  /// In en, this message translates to:
  /// **'Drawing area. Draw with your finger.'**
  String get drawSemanticDrawingCanvas;

  /// l10n: drawSemanticPauseGame
  ///
  /// In en, this message translates to:
  /// **'Pause game'**
  String get drawSemanticPauseGame;

  /// l10n: drawSemanticResumeGame
  ///
  /// In en, this message translates to:
  /// **'Resume game'**
  String get drawSemanticResumeGame;

  /// l10n: drawSemanticPenColorBlack
  ///
  /// In en, this message translates to:
  /// **'Black pen color'**
  String get drawSemanticPenColorBlack;

  /// l10n: drawSemanticPenColorRed
  ///
  /// In en, this message translates to:
  /// **'Red pen color'**
  String get drawSemanticPenColorRed;

  /// l10n: drawSemanticPenColorBlue
  ///
  /// In en, this message translates to:
  /// **'Blue pen color'**
  String get drawSemanticPenColorBlue;

  /// l10n: drawSemanticPenColorYellow
  ///
  /// In en, this message translates to:
  /// **'Yellow pen color'**
  String get drawSemanticPenColorYellow;

  /// l10n: drawSemanticPenColorGreen
  ///
  /// In en, this message translates to:
  /// **'Green pen color'**
  String get drawSemanticPenColorGreen;

  /// l10n: drawSemanticPenColorPurple
  ///
  /// In en, this message translates to:
  /// **'Purple pen color'**
  String get drawSemanticPenColorPurple;

  /// l10n: drawSemanticPenColorOrange
  ///
  /// In en, this message translates to:
  /// **'Orange pen color'**
  String get drawSemanticPenColorOrange;
}

class _DrawLocalizationsDelegate extends LocalizationsDelegate<DrawLocalizations> {
  const _DrawLocalizationsDelegate();

  @override
  Future<DrawLocalizations> load(Locale locale) {
    return SynchronousFuture<DrawLocalizations>(lookupDrawLocalizations(locale));
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
  bool shouldReload(_DrawLocalizationsDelegate old) => false;
}

DrawLocalizations lookupDrawLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return DrawLocalizationsAr();
    case 'az':
      return DrawLocalizationsAz();
    case 'bn':
      return DrawLocalizationsBn();
    case 'de':
      return DrawLocalizationsDe();
    case 'en':
      return DrawLocalizationsEn();
    case 'es':
      return DrawLocalizationsEs();
    case 'fr':
      return DrawLocalizationsFr();
    case 'hi':
      return DrawLocalizationsHi();
    case 'pt':
      return DrawLocalizationsPt();
    case 'ru':
      return DrawLocalizationsRu();
    case 'tr':
      return DrawLocalizationsTr();
    case 'ur':
      return DrawLocalizationsUr();
    case 'zh':
      return DrawLocalizationsZh();
  }

  throw FlutterError(
      'DrawLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
