import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'home_localizations_ar.dart';
import 'home_localizations_az.dart';
import 'home_localizations_bn.dart';
import 'home_localizations_de.dart';
import 'home_localizations_en.dart';
import 'home_localizations_es.dart';
import 'home_localizations_fr.dart';
import 'home_localizations_hi.dart';
import 'home_localizations_pt.dart';
import 'home_localizations_ru.dart';
import 'home_localizations_tr.dart';
import 'home_localizations_ur.dart';
import 'home_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of HomeLocalizations
/// returned by `HomeLocalizations.of(context)`.
///
/// Applications need to include `HomeLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/home_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: HomeLocalizations.localizationsDelegates,
///   supportedLocales: HomeLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the HomeLocalizations.supportedLocales
/// property.
abstract class HomeLocalizations {
  HomeLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static HomeLocalizations of(BuildContext context) {
    return Localizations.of<HomeLocalizations>(context, HomeLocalizations)!;
  }

  static const LocalizationsDelegate<HomeLocalizations> delegate = _HomeLocalizationsDelegate();

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

  /// l10n: hello
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// l10n: slogan
  ///
  /// In en, this message translates to:
  /// **'Draw, Learn, Have Fun!'**
  String get slogan;

  /// l10n: seeTutorial
  ///
  /// In en, this message translates to:
  /// **'See Tutorial'**
  String get seeTutorial;

  /// l10n: tutorial
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// l10n: points
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// l10n: streakDay
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get streakDay;

  /// l10n: badgeFirstLoginName
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get badgeFirstLoginName;

  /// l10n: badgeFirstLoginDesc
  ///
  /// In en, this message translates to:
  /// **'You logged in for the first time!'**
  String get badgeFirstLoginDesc;

  /// l10n: badgeFirstDrawName
  ///
  /// In en, this message translates to:
  /// **'Beginning Artist'**
  String get badgeFirstDrawName;

  /// l10n: badgeFirstDrawDesc
  ///
  /// In en, this message translates to:
  /// **'You completed your first drawing!'**
  String get badgeFirstDrawDesc;

  /// l10n: badgeStreak3Name
  ///
  /// In en, this message translates to:
  /// **'Determined'**
  String get badgeStreak3Name;

  /// l10n: badgeStreak3Desc
  ///
  /// In en, this message translates to:
  /// **'You came 3 days in a row!'**
  String get badgeStreak3Desc;

  /// l10n: badgeStreak7Name
  ///
  /// In en, this message translates to:
  /// **'Weekly Star'**
  String get badgeStreak7Name;

  /// l10n: badgeStreak7Desc
  ///
  /// In en, this message translates to:
  /// **'You practiced for 7 days!'**
  String get badgeStreak7Desc;

  /// l10n: badgeMasterArtistName
  ///
  /// In en, this message translates to:
  /// **'Master Artist'**
  String get badgeMasterArtistName;

  /// l10n: badgeMasterArtistDesc
  ///
  /// In en, this message translates to:
  /// **'You made 100 drawings!'**
  String get badgeMasterArtistDesc;

  /// l10n: badgeStreak30Name
  ///
  /// In en, this message translates to:
  /// **'Monthly Master'**
  String get badgeStreak30Name;

  /// l10n: badgeStreak30Desc
  ///
  /// In en, this message translates to:
  /// **'You came regularly for 30 days!'**
  String get badgeStreak30Desc;

  /// l10n: badgeBronzeArtistName
  ///
  /// In en, this message translates to:
  /// **'Bronze Pencil'**
  String get badgeBronzeArtistName;

  /// l10n: badgeBronzeArtistDesc
  ///
  /// In en, this message translates to:
  /// **'You made 10 drawings!'**
  String get badgeBronzeArtistDesc;

  /// l10n: badgeSilverArtistName
  ///
  /// In en, this message translates to:
  /// **'Silver Pencil'**
  String get badgeSilverArtistName;

  /// l10n: badgeSilverArtistDesc
  ///
  /// In en, this message translates to:
  /// **'You made 50 drawings!'**
  String get badgeSilverArtistDesc;

  /// l10n: badgeGoldArtistName
  ///
  /// In en, this message translates to:
  /// **'Gold Pencil'**
  String get badgeGoldArtistName;

  /// l10n: badgeGoldArtistDesc
  ///
  /// In en, this message translates to:
  /// **'You made 250 drawings!'**
  String get badgeGoldArtistDesc;

  /// l10n: badgeDiamondArtistName
  ///
  /// In en, this message translates to:
  /// **'Diamond Artist'**
  String get badgeDiamondArtistName;

  /// l10n: badgeDiamondArtistDesc
  ///
  /// In en, this message translates to:
  /// **'You made 500 drawings! Incredible!'**
  String get badgeDiamondArtistDesc;

  /// l10n: badgeEarlyBirdName
  ///
  /// In en, this message translates to:
  /// **'Early Bird'**
  String get badgeEarlyBirdName;

  /// l10n: badgeEarlyBirdDesc
  ///
  /// In en, this message translates to:
  /// **'You started working early in the morning!'**
  String get badgeEarlyBirdDesc;

  /// l10n: badgeNightOwlName
  ///
  /// In en, this message translates to:
  /// **'Night Owl'**
  String get badgeNightOwlName;

  /// l10n: badgeNightOwlDesc
  ///
  /// In en, this message translates to:
  /// **'You are working even late at night!'**
  String get badgeNightOwlDesc;

  /// l10n: badgeWeekendWarriorName
  ///
  /// In en, this message translates to:
  /// **'Weekend Fun'**
  String get badgeWeekendWarriorName;

  /// l10n: badgeWeekendWarriorDesc
  ///
  /// In en, this message translates to:
  /// **'You are spending your weekend learning!'**
  String get badgeWeekendWarriorDesc;

  /// l10n: badgeNumberMasterName
  ///
  /// In en, this message translates to:
  /// **'Math Genius'**
  String get badgeNumberMasterName;

  /// l10n: badgeNumberMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You drew 50 numbers!'**
  String get badgeNumberMasterDesc;

  /// l10n: badgeLetterMasterName
  ///
  /// In en, this message translates to:
  /// **'Alphabet Pro'**
  String get badgeLetterMasterName;

  /// l10n: badgeLetterMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You drew 50 letters!'**
  String get badgeLetterMasterDesc;

  /// l10n: badgeShapeMasterName
  ///
  /// In en, this message translates to:
  /// **'Geometry Wizard'**
  String get badgeShapeMasterName;

  /// l10n: badgeShapeMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You drew 50 shapes!'**
  String get badgeShapeMasterDesc;

  /// l10n: badgeHighScorerName
  ///
  /// In en, this message translates to:
  /// **'High Scorer'**
  String get badgeHighScorerName;

  /// l10n: badgeHighScorerDesc
  ///
  /// In en, this message translates to:
  /// **'You reached 1000 points!'**
  String get badgeHighScorerDesc;

  /// l10n: badgeScoreLegendName
  ///
  /// In en, this message translates to:
  /// **'Score Legend'**
  String get badgeScoreLegendName;

  /// l10n: badgeScoreLegendDesc
  ///
  /// In en, this message translates to:
  /// **'You reached 5000 points!'**
  String get badgeScoreLegendDesc;

  /// l10n: badgeBadgeCollectorName
  ///
  /// In en, this message translates to:
  /// **'Badge Collector'**
  String get badgeBadgeCollectorName;

  /// l10n: badgeBadgeCollectorDesc
  ///
  /// In en, this message translates to:
  /// **'You earned 5 badges!'**
  String get badgeBadgeCollectorDesc;

  /// l10n: badgeBadgeMasterName
  ///
  /// In en, this message translates to:
  /// **'Badge Master'**
  String get badgeBadgeMasterName;

  /// l10n: badgeBadgeMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You earned 15 badges!'**
  String get badgeBadgeMasterDesc;

  /// l10n: shopTitle
  ///
  /// In en, this message translates to:
  /// **'SHOP'**
  String get shopTitle;

  /// l10n: tabHat
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get tabHat;

  /// l10n: tabGlasses
  ///
  /// In en, this message translates to:
  /// **'Glasses'**
  String get tabGlasses;

  /// l10n: tabOutfit
  ///
  /// In en, this message translates to:
  /// **'Outfit'**
  String get tabOutfit;

  /// l10n: owned
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get owned;

  /// l10n: equipped
  ///
  /// In en, this message translates to:
  /// **'Equipped'**
  String get equipped;

  /// l10n: insufficientPoints
  ///
  /// In en, this message translates to:
  /// **'Not enough points! 😢'**
  String get insufficientPoints;

  /// l10n: buyTitle
  ///
  /// In en, this message translates to:
  /// **'Buy Item?'**
  String get buyTitle;

  /// l10n: buyDescription
  ///
  /// In en, this message translates to:
  /// **'Do you want to buy this item for {price} stars?'**
  String buyDescription(int price);

  /// l10n: noBtn
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noBtn;

  /// l10n: yesBuyBtn
  ///
  /// In en, this message translates to:
  /// **'Yes, Buy!'**
  String get yesBuyBtn;

  /// l10n: itemBought
  ///
  /// In en, this message translates to:
  /// **'{item} bought! 🎉'**
  String itemBought(String item);

  /// l10n: freePointsBtn
  ///
  /// In en, this message translates to:
  /// **'WATCH AD EARN POINTS'**
  String get freePointsBtn;

  /// l10n: rewardEarned
  ///
  /// In en, this message translates to:
  /// **'Congrats! You earned {amount} Points! 🎉'**
  String rewardEarned(int amount);

  /// l10n: myQuestsTitle
  ///
  /// In en, this message translates to:
  /// **'MY QUESTS'**
  String get myQuestsTitle;

  /// l10n: loadingQuests
  ///
  /// In en, this message translates to:
  /// **'Loading quests...'**
  String get loadingQuests;

  /// l10n: questsRefreshedMessage
  ///
  /// In en, this message translates to:
  /// **'Your quests were updated.'**
  String get questsRefreshedMessage;

  /// l10n: dailyQuest
  ///
  /// In en, this message translates to:
  /// **'DAILY QUEST'**
  String get dailyQuest;

  /// l10n: weeklyQuest
  ///
  /// In en, this message translates to:
  /// **'WEEKLY QUEST'**
  String get weeklyQuest;

  /// l10n: hat_blue_cap
  ///
  /// In en, this message translates to:
  /// **'Blue Cap'**
  String get hat_blue_cap;

  /// l10n: hat_crown
  ///
  /// In en, this message translates to:
  /// **'Crown'**
  String get hat_crown;

  /// l10n: hat_wizard
  ///
  /// In en, this message translates to:
  /// **'Wizard Hat'**
  String get hat_wizard;

  /// l10n: hat_flower
  ///
  /// In en, this message translates to:
  /// **'Flower Crown'**
  String get hat_flower;

  /// l10n: hat_pirate
  ///
  /// In en, this message translates to:
  /// **'Pirate Hat'**
  String get hat_pirate;

  /// l10n: hat_chef
  ///
  /// In en, this message translates to:
  /// **'Chef Hat'**
  String get hat_chef;

  /// l10n: glasses_sun
  ///
  /// In en, this message translates to:
  /// **'Sunglasses'**
  String get glasses_sun;

  /// l10n: glasses_nerd
  ///
  /// In en, this message translates to:
  /// **'Nerd Glasses'**
  String get glasses_nerd;

  /// l10n: glasses_heart
  ///
  /// In en, this message translates to:
  /// **'Heart Glasses'**
  String get glasses_heart;

  /// l10n: glasses_3d
  ///
  /// In en, this message translates to:
  /// **'3D Glasses'**
  String get glasses_3d;

  /// l10n: glasses_vr
  ///
  /// In en, this message translates to:
  /// **'VR Headset'**
  String get glasses_vr;

  /// l10n: glasses_ski
  ///
  /// In en, this message translates to:
  /// **'Ski Goggles'**
  String get glasses_ski;

  /// l10n: glasses_mask
  ///
  /// In en, this message translates to:
  /// **'Mask'**
  String get glasses_mask;

  /// l10n: glasses_reading
  ///
  /// In en, this message translates to:
  /// **'Reading Glasses'**
  String get glasses_reading;

  /// l10n: outfit_red
  ///
  /// In en, this message translates to:
  /// **'Red Shirt'**
  String get outfit_red;

  /// l10n: outfit_super
  ///
  /// In en, this message translates to:
  /// **'Superhero'**
  String get outfit_super;

  /// l10n: outfit_green
  ///
  /// In en, this message translates to:
  /// **'Green Hoodie'**
  String get outfit_green;

  /// l10n: outfit_doctor
  ///
  /// In en, this message translates to:
  /// **'Doctor Coat'**
  String get outfit_doctor;

  /// l10n: outfit_space
  ///
  /// In en, this message translates to:
  /// **'Space Suit'**
  String get outfit_space;

  /// l10n: outfit_sports
  ///
  /// In en, this message translates to:
  /// **'Jersey'**
  String get outfit_sports;

  /// l10n: outfit_police
  ///
  /// In en, this message translates to:
  /// **'Police Uniform'**
  String get outfit_police;

  /// l10n: outfit_chef
  ///
  /// In en, this message translates to:
  /// **'Chef Apron'**
  String get outfit_chef;

  /// l10n: outfit_winter
  ///
  /// In en, this message translates to:
  /// **'Winter Coat'**
  String get outfit_winter;

  /// l10n: outfit_tuxedo
  ///
  /// In en, this message translates to:
  /// **'Tuxedo'**
  String get outfit_tuxedo;

  /// l10n: badgesTitle
  ///
  /// In en, this message translates to:
  /// **'MY BADGES'**
  String get badgesTitle;

  /// l10n: totalBadges
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get totalBadges;

  /// l10n: filterAll
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get filterAll;

  /// l10n: filterEarned
  ///
  /// In en, this message translates to:
  /// **'EARNED'**
  String get filterEarned;

  /// l10n: filterLocked
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get filterLocked;

  /// l10n: numbersTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Numbers'**
  String get numbersTitle;

  /// l10n: lettersTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Letters'**
  String get lettersTitle;

  /// l10n: shapesTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Shapes'**
  String get shapesTitle;

  /// l10n: colorsTitle
  ///
  /// In en, this message translates to:
  /// **'Learn Colors'**
  String get colorsTitle;

  /// l10n: badgeColorMasterName
  ///
  /// In en, this message translates to:
  /// **'Color Expert'**
  String get badgeColorMasterName;

  /// l10n: badgeColorMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You completed 50 color rounds!'**
  String get badgeColorMasterDesc;

  /// l10n: noBadgesFound
  ///
  /// In en, this message translates to:
  /// **'No badges found'**
  String get noBadgesFound;
}

class _HomeLocalizationsDelegate extends LocalizationsDelegate<HomeLocalizations> {
  const _HomeLocalizationsDelegate();

  @override
  Future<HomeLocalizations> load(Locale locale) {
    return SynchronousFuture<HomeLocalizations>(lookupHomeLocalizations(locale));
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
  bool shouldReload(_HomeLocalizationsDelegate old) => false;
}

HomeLocalizations lookupHomeLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return HomeLocalizationsAr();
    case 'az':
      return HomeLocalizationsAz();
    case 'bn':
      return HomeLocalizationsBn();
    case 'de':
      return HomeLocalizationsDe();
    case 'en':
      return HomeLocalizationsEn();
    case 'es':
      return HomeLocalizationsEs();
    case 'fr':
      return HomeLocalizationsFr();
    case 'hi':
      return HomeLocalizationsHi();
    case 'pt':
      return HomeLocalizationsPt();
    case 'ru':
      return HomeLocalizationsRu();
    case 'tr':
      return HomeLocalizationsTr();
    case 'ur':
      return HomeLocalizationsUr();
    case 'zh':
      return HomeLocalizationsZh();
  }

  throw FlutterError(
      'HomeLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
