import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'info_localizations_ar.dart';
import 'info_localizations_az.dart';
import 'info_localizations_bn.dart';
import 'info_localizations_de.dart';
import 'info_localizations_en.dart';
import 'info_localizations_es.dart';
import 'info_localizations_fr.dart';
import 'info_localizations_hi.dart';
import 'info_localizations_pt.dart';
import 'info_localizations_ru.dart';
import 'info_localizations_tr.dart';
import 'info_localizations_ur.dart';
import 'info_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of InfoLocalizations
/// returned by `InfoLocalizations.of(context)`.
///
/// Applications need to include `InfoLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/info_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: InfoLocalizations.localizationsDelegates,
///   supportedLocales: InfoLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the InfoLocalizations.supportedLocales
/// property.
abstract class InfoLocalizations {
  InfoLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static InfoLocalizations? of(BuildContext context) {
    return Localizations.of<InfoLocalizations>(context, InfoLocalizations);
  }

  static const LocalizationsDelegate<InfoLocalizations> delegate = _InfoLocalizationsDelegate();

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

  /// l10n: infoDrawingNotFound
  ///
  /// In en, this message translates to:
  /// **'Drawing Not Found'**
  String get infoDrawingNotFound;

  /// l10n: infoDrawnLetter
  ///
  /// In en, this message translates to:
  /// **'Your Drawing'**
  String get infoDrawnLetter;

  /// l10n: infoCongrats
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get infoCongrats;

  /// l10n: infoSuccessMessage
  ///
  /// In en, this message translates to:
  /// **'Great job! I recognized this letter correctly!'**
  String get infoSuccessMessage;

  /// l10n: infoBack
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get infoBack;

  /// l10n: resultDrawingNotFound
  ///
  /// In en, this message translates to:
  /// **'Drawing Not Found'**
  String get resultDrawingNotFound;

  /// l10n: resultDrawn
  ///
  /// In en, this message translates to:
  /// **'Your Drawing:'**
  String get resultDrawn;

  /// l10n: resultCongrats
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get resultCongrats;

  /// l10n: resultTryAgain
  ///
  /// In en, this message translates to:
  /// **'Try Again!'**
  String get resultTryAgain;

  /// l10n: resultTargetLetter
  ///
  /// In en, this message translates to:
  /// **'Target:'**
  String get resultTargetLetter;

  /// l10n: resultSuccessMessage
  ///
  /// In en, this message translates to:
  /// **'Great job! I recognized your drawing correctly!'**
  String get resultSuccessMessage;

  /// l10n: resultFailMessage
  ///
  /// In en, this message translates to:
  /// **'Try again! Your drawing looks like something else.'**
  String get resultFailMessage;

  /// l10n: resultProgress
  ///
  /// In en, this message translates to:
  /// **'Correct: {correct} / Total: {total}'**
  String resultProgress(int correct, int total);

  /// l10n: resultTryAgainBtn
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get resultTryAgainBtn;

  /// l10n: resultNextLetter
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get resultNextLetter;

  /// l10n: resultNextLetterFail
  ///
  /// In en, this message translates to:
  /// **'Go to Next'**
  String get resultNextLetterFail;
}

class _InfoLocalizationsDelegate extends LocalizationsDelegate<InfoLocalizations> {
  const _InfoLocalizationsDelegate();

  @override
  Future<InfoLocalizations> load(Locale locale) {
    return SynchronousFuture<InfoLocalizations>(lookupInfoLocalizations(locale));
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
  bool shouldReload(_InfoLocalizationsDelegate old) => false;
}

InfoLocalizations lookupInfoLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return InfoLocalizationsAr();
    case 'az':
      return InfoLocalizationsAz();
    case 'bn':
      return InfoLocalizationsBn();
    case 'de':
      return InfoLocalizationsDe();
    case 'en':
      return InfoLocalizationsEn();
    case 'es':
      return InfoLocalizationsEs();
    case 'fr':
      return InfoLocalizationsFr();
    case 'hi':
      return InfoLocalizationsHi();
    case 'pt':
      return InfoLocalizationsPt();
    case 'ru':
      return InfoLocalizationsRu();
    case 'tr':
      return InfoLocalizationsTr();
    case 'ur':
      return InfoLocalizationsUr();
    case 'zh':
      return InfoLocalizationsZh();
  }

  throw FlutterError(
      'InfoLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
