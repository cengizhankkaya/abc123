import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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

  /// Application title shown in the task switcher and stores
  ///
  /// In en, this message translates to:
  /// **'Number Learning App'**
  String get appTitle;

  /// Main shell navigation: home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Main shell navigation: daily quests tab
  ///
  /// In en, this message translates to:
  /// **'Quests'**
  String get navQuests;

  /// Main shell navigation: avatar shop tab
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// Main shell navigation: badges tab
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get navBadges;

  /// App bar title on the YouTube tutorial redirect screen
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorialScreenTitle;

  /// Body text while redirecting to the tutorial video
  ///
  /// In en, this message translates to:
  /// **'Opening YouTube…'**
  String get tutorialRedirectMessage;

  /// Accessibility tooltip for the navigation menu button
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenuTooltip;

  /// SnackBar when external URL is not allowed
  ///
  /// In en, this message translates to:
  /// **'Only secure (HTTPS) links can be opened.'**
  String get tutorialHttpsOnlyMessage;

  /// SnackBar when YouTube URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open the video. Please try again.'**
  String get tutorialOpenFailedMessage;

  /// 404-style message with attempted path
  ///
  /// In en, this message translates to:
  /// **'Page not found:\n{uri}'**
  String navErrorPageNotFound(String uri);

  /// Fallback when GoRouter extra is not ResultScreenData
  ///
  /// In en, this message translates to:
  /// **'Invalid result data'**
  String get routerInvalidResultData;

  /// Fallback when GoRouter extra is not InfoDrawExtra
  ///
  /// In en, this message translates to:
  /// **'Invalid info screen data'**
  String get routerInvalidInfoDrawData;

  /// SnackBar after rewarded ad grants a point
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You earned 1 point.'**
  String get adRewardPointEarned;

  /// SnackBar when rewarded ad is not ready
  ///
  /// In en, this message translates to:
  /// **'Ad could not be loaded. Please try again.'**
  String get adLoadFailedRetry;

  /// Tooltip for theme mode (light/dark/system) menu button
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeModeTooltip;

  /// Theme option: light mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// Theme option: dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// Theme option: follow system setting
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeModeSystem;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
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
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
