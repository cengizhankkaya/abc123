import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'numbers_advanced_localizations_en.dart';
import 'numbers_advanced_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of NumbersAdvancedLocalizations
/// returned by `NumbersAdvancedLocalizations.of(context)`.
///
/// Applications need to include `NumbersAdvancedLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/numbers_advanced_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: NumbersAdvancedLocalizations.localizationsDelegates,
///   supportedLocales: NumbersAdvancedLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the NumbersAdvancedLocalizations.supportedLocales
/// property.
abstract class NumbersAdvancedLocalizations {
  NumbersAdvancedLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static NumbersAdvancedLocalizations of(BuildContext context) {
    return Localizations.of<NumbersAdvancedLocalizations>(context, NumbersAdvancedLocalizations)!;
  }

  static const LocalizationsDelegate<NumbersAdvancedLocalizations> delegate =
      _NumbersAdvancedLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('tr')];

  /// l10n: mathHubTitle
  ///
  /// In en, this message translates to:
  /// **'Math Adventure'**
  String get mathHubTitle;

  /// l10n: mathHubSubtitle
  ///
  /// In en, this message translates to:
  /// **'Choose a topic to practice'**
  String get mathHubSubtitle;

  /// l10n: mathHubTensTitle
  ///
  /// In en, this message translates to:
  /// **'Tens Numbers'**
  String get mathHubTensTitle;

  /// l10n: mathHubTensSubtitle
  ///
  /// In en, this message translates to:
  /// **'10, 20, 30 … 100'**
  String get mathHubTensSubtitle;

  /// l10n: mathHubFreeTitle
  ///
  /// In en, this message translates to:
  /// **'Free Practice'**
  String get mathHubFreeTitle;

  /// l10n: mathHubFreeSubtitle
  ///
  /// In en, this message translates to:
  /// **'2-digit numbers'**
  String get mathHubFreeSubtitle;

  /// l10n: mathHubVisualTitle
  ///
  /// In en, this message translates to:
  /// **'Visual Addition'**
  String get mathHubVisualTitle;

  /// l10n: mathHubVisualSubtitle
  ///
  /// In en, this message translates to:
  /// **'Count & write'**
  String get mathHubVisualSubtitle;

  /// l10n: mathHubSymbolicTitle
  ///
  /// In en, this message translates to:
  /// **'Addition & Subtraction'**
  String get mathHubSymbolicTitle;

  /// l10n: mathHubSymbolicSubtitle
  ///
  /// In en, this message translates to:
  /// **'A, B, C levels'**
  String get mathHubSymbolicSubtitle;

  /// l10n: mathSelectTensTitle
  ///
  /// In en, this message translates to:
  /// **'Pick a Tens Number'**
  String get mathSelectTensTitle;

  /// l10n: mathDrawTensInstruction
  ///
  /// In en, this message translates to:
  /// **'Draw {number} in the boxes'**
  String mathDrawTensInstruction(int number);

  /// l10n: mathFreePracticeInstruction
  ///
  /// In en, this message translates to:
  /// **'Draw the number {number}'**
  String mathFreePracticeInstruction(int number);

  /// l10n: mathVisualInstruction
  ///
  /// In en, this message translates to:
  /// **'Count the objects and write the total'**
  String get mathVisualInstruction;

  /// l10n: mathSymbolicInstruction
  ///
  /// In en, this message translates to:
  /// **'Solve and write the answer'**
  String get mathSymbolicInstruction;

  /// l10n: mathTensBox
  ///
  /// In en, this message translates to:
  /// **'Tens'**
  String get mathTensBox;

  /// l10n: mathUnitsBox
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get mathUnitsBox;

  /// l10n: mathCheckButton
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get mathCheckButton;

  /// l10n: mathNextButton
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get mathNextButton;

  /// l10n: mathCorrect
  ///
  /// In en, this message translates to:
  /// **'Correct! 🎉'**
  String get mathCorrect;

  /// l10n: mathWrong
  ///
  /// In en, this message translates to:
  /// **'Try again!'**
  String get mathWrong;

  /// l10n: mathHintVisible
  ///
  /// In en, this message translates to:
  /// **'Hint mode ON'**
  String get mathHintVisible;

  /// l10n: mathHintHidden
  ///
  /// In en, this message translates to:
  /// **'Hint mode OFF'**
  String get mathHintHidden;

  /// l10n: mathLevelLocked
  ///
  /// In en, this message translates to:
  /// **'Complete previous level at 80%'**
  String get mathLevelLocked;

  /// l10n: mathLevelProgress
  ///
  /// In en, this message translates to:
  /// **'{correct}/{total} correct ({percent}%)'**
  String mathLevelProgress(int correct, int total, int percent);

  /// l10n: mathLevelA
  ///
  /// In en, this message translates to:
  /// **'Level A'**
  String get mathLevelA;

  /// l10n: mathLevelB
  ///
  /// In en, this message translates to:
  /// **'Level B'**
  String get mathLevelB;

  /// l10n: mathLevelC
  ///
  /// In en, this message translates to:
  /// **'Level C'**
  String get mathLevelC;

  /// l10n: mathLevelADesc
  ///
  /// In en, this message translates to:
  /// **'Result ≤ 10'**
  String get mathLevelADesc;

  /// l10n: mathLevelBDesc
  ///
  /// In en, this message translates to:
  /// **'Result ≤ 20'**
  String get mathLevelBDesc;

  /// l10n: mathLevelCDesc
  ///
  /// In en, this message translates to:
  /// **'Two-digit, no carry'**
  String get mathLevelCDesc;

  /// l10n: mathClearButton
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get mathClearButton;

  /// l10n: mathEmptyDrawingWarning
  ///
  /// In en, this message translates to:
  /// **'Please draw in the box first'**
  String get mathEmptyDrawingWarning;

  /// l10n: mathParentSectionTitle
  ///
  /// In en, this message translates to:
  /// **'Math Progress'**
  String get mathParentSectionTitle;

  /// l10n: mathParentAdditions
  ///
  /// In en, this message translates to:
  /// **'Additions solved'**
  String get mathParentAdditions;

  /// l10n: mathParentSubtractions
  ///
  /// In en, this message translates to:
  /// **'Subtractions solved'**
  String get mathParentSubtractions;

  /// l10n: mathParentTens
  ///
  /// In en, this message translates to:
  /// **'Tens practiced'**
  String get mathParentTens;

  /// l10n: mathParentSuggest
  ///
  /// In en, this message translates to:
  /// **'Keep practicing subtraction!'**
  String get mathParentSuggest;

  /// l10n: badgeMathFirstAdditionName
  ///
  /// In en, this message translates to:
  /// **'First Addition!'**
  String get badgeMathFirstAdditionName;

  /// l10n: badgeMathFirstAdditionDesc
  ///
  /// In en, this message translates to:
  /// **'You solved your first addition!'**
  String get badgeMathFirstAdditionDesc;

  /// l10n: badgeTensHeroName
  ///
  /// In en, this message translates to:
  /// **'Tens Hero'**
  String get badgeTensHeroName;

  /// l10n: badgeTensHeroDesc
  ///
  /// In en, this message translates to:
  /// **'You practiced all tens numbers!'**
  String get badgeTensHeroDesc;

  /// l10n: badgeSubtractionMasterName
  ///
  /// In en, this message translates to:
  /// **'Subtraction Master'**
  String get badgeSubtractionMasterName;

  /// l10n: badgeSubtractionMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You solved 20 subtractions!'**
  String get badgeSubtractionMasterDesc;

  /// l10n: mathAdvancedHomeTitle
  ///
  /// In en, this message translates to:
  /// **'Addition & Subtraction'**
  String get mathAdvancedHomeTitle;

  /// l10n: mathAdvancedHomeSubtitle
  ///
  /// In en, this message translates to:
  /// **'Math adventure'**
  String get mathAdvancedHomeSubtitle;
}

class _NumbersAdvancedLocalizationsDelegate
    extends LocalizationsDelegate<NumbersAdvancedLocalizations> {
  const _NumbersAdvancedLocalizationsDelegate();

  @override
  Future<NumbersAdvancedLocalizations> load(Locale locale) {
    return SynchronousFuture<NumbersAdvancedLocalizations>(
        lookupNumbersAdvancedLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_NumbersAdvancedLocalizationsDelegate old) => false;
}

NumbersAdvancedLocalizations lookupNumbersAdvancedLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return NumbersAdvancedLocalizationsEn();
    case 'tr':
      return NumbersAdvancedLocalizationsTr();
  }

  throw FlutterError(
      'NumbersAdvancedLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
