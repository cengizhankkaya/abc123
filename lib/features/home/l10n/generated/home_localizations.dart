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

  static HomeLocalizations? of(BuildContext context) {
    return Localizations.of<HomeLocalizations>(context, HomeLocalizations);
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

  /// l10n: wordsTitle
  ///
  /// In en, this message translates to:
  /// **'Build Words'**
  String get wordsTitle;

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

  /// l10n: badgeWordMasterName
  ///
  /// In en, this message translates to:
  /// **'Word Builder'**
  String get badgeWordMasterName;

  /// l10n: badgeWordMasterDesc
  ///
  /// In en, this message translates to:
  /// **'You completed 50 words!'**
  String get badgeWordMasterDesc;

  /// l10n: questsRefreshedMessage
  ///
  /// In en, this message translates to:
  /// **'Quests have been refreshed.'**
  String get questsRefreshedMessage;

  /// l10n: noBadgesFound
  ///
  /// In en, this message translates to:
  /// **'No badges found'**
  String get noBadgesFound;

  /// l10n: homeGreetingWithName
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String homeGreetingWithName(String name);

  /// l10n: homeSloganToday
  ///
  /// In en, this message translates to:
  /// **'What shall we learn today?'**
  String get homeSloganToday;

  /// l10n: homeStreakDays
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String homeStreakDays(int count);

  /// l10n: homeLearningModes
  ///
  /// In en, this message translates to:
  /// **'Learning Modes'**
  String get homeLearningModes;

  /// l10n: numbersTitleShort
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbersTitleShort;

  /// l10n: lettersTitleShort
  ///
  /// In en, this message translates to:
  /// **'Letters'**
  String get lettersTitleShort;

  /// l10n: shapesTitleShort
  ///
  /// In en, this message translates to:
  /// **'Shapes'**
  String get shapesTitleShort;

  /// l10n: wordsTitleShort
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get wordsTitleShort;

  /// l10n: colorsTitleShort
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colorsTitleShort;

  /// l10n: numbersSubtitle
  ///
  /// In en, this message translates to:
  /// **'Draw 0–9'**
  String get numbersSubtitle;

  /// l10n: lettersSubtitle
  ///
  /// In en, this message translates to:
  /// **'Draw A–Z'**
  String get lettersSubtitle;

  /// l10n: shapesSubtitle
  ///
  /// In en, this message translates to:
  /// **'New!'**
  String get shapesSubtitle;

  /// l10n: wordsSubtitle
  ///
  /// In en, this message translates to:
  /// **'Draw words'**
  String get wordsSubtitle;

  /// l10n: colorsSubtitle
  ///
  /// In en, this message translates to:
  /// **'Play & learn'**
  String get colorsSubtitle;

  /// l10n: homeWhereYouLeft
  ///
  /// In en, this message translates to:
  /// **'Where you left off: {label}'**
  String homeWhereYouLeft(String label);

  /// l10n: homeStepsRemaining
  ///
  /// In en, this message translates to:
  /// **'{count} steps left'**
  String homeStepsRemaining(int count);

  /// l10n: homeContinueNumber
  ///
  /// In en, this message translates to:
  /// **'Number {number}'**
  String homeContinueNumber(String number);

  /// l10n: homeContinueLetter
  ///
  /// In en, this message translates to:
  /// **'Letter {letter}'**
  String homeContinueLetter(String letter);

  /// l10n: homeContinueShape
  ///
  /// In en, this message translates to:
  /// **'Shape {number}'**
  String homeContinueShape(String number);

  /// l10n: homeContinueWord
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get homeContinueWord;

  /// l10n: homeContinueColor
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get homeContinueColor;

  /// l10n: homeContinueColorVision
  ///
  /// In en, this message translates to:
  /// **'Color Vision'**
  String get homeContinueColorVision;

  /// l10n: settingsTitle
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// l10n: settingsChildName
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settingsChildName;

  /// l10n: settingsChildNameHint
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get settingsChildNameHint;

  /// l10n: settingsSaveName
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSaveName;

  /// l10n: settingsNameSaved
  ///
  /// In en, this message translates to:
  /// **'Name saved'**
  String get settingsNameSaved;

  /// l10n: settingsAppearance
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// l10n: settingsLanguage
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// l10n: badgesScreenTitle
  ///
  /// In en, this message translates to:
  /// **'My Badges'**
  String get badgesScreenTitle;

  /// l10n: badgesEarnedOfTotal
  ///
  /// In en, this message translates to:
  /// **'{count} / {total} badges earned'**
  String badgesEarnedOfTotal(int count, int total);

  /// l10n: badgesStreakDayCount
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String badgesStreakDayCount(int count);

  /// l10n: badgesStreakSubtitle
  ///
  /// In en, this message translates to:
  /// **'Drawing streak'**
  String get badgesStreakSubtitle;

  /// l10n: parentPanelTitle
  ///
  /// In en, this message translates to:
  /// **'Parent Panel'**
  String get parentPanelTitle;

  /// l10n: parentPanelWeeklyProgress
  ///
  /// In en, this message translates to:
  /// **'{name}\'s weekly progress'**
  String parentPanelWeeklyProgress(String name);

  /// l10n: parentPanelWeeklyProgressNoName
  ///
  /// In en, this message translates to:
  /// **'Weekly progress'**
  String get parentPanelWeeklyProgressNoName;

  /// l10n: parentPanelStatDuration
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get parentPanelStatDuration;

  /// l10n: parentPanelStatCompleted
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get parentPanelStatCompleted;

  /// l10n: parentPanelStatAccuracy
  ///
  /// In en, this message translates to:
  /// **'AVG. ACCURACY'**
  String get parentPanelStatAccuracy;

  /// l10n: parentPanelDurationMinutes
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String parentPanelDurationMinutes(int minutes);

  /// l10n: parentPanelAccuracyPercent
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String parentPanelAccuracyPercent(int percent);

  /// l10n: parentPanelChartTitle
  ///
  /// In en, this message translates to:
  /// **'Daily drawing time'**
  String get parentPanelChartTitle;

  /// l10n: parentPanelInsightLettersLearned
  ///
  /// In en, this message translates to:
  /// **'Letters {range} learned'**
  String parentPanelInsightLettersLearned(String range);

  /// l10n: parentPanelInsightNumberStruggling
  ///
  /// In en, this message translates to:
  /// **'Struggling with number {number}'**
  String parentPanelInsightNumberStruggling(int number);

  /// l10n: parentPanelInsightGettingStarted
  ///
  /// In en, this message translates to:
  /// **'Learning journey is just getting started'**
  String get parentPanelInsightGettingStarted;

  /// l10n: parentPanelInsightMath
  ///
  /// In en, this message translates to:
  /// **'Working on advanced math operations!'**
  String get parentPanelInsightMath;

  /// l10n: parentPanelMathStrugglingAddition
  ///
  /// In en, this message translates to:
  /// **'Most errors made in Addition. Suggestion: Review Visual & Symbolic Addition.'**
  String get parentPanelMathStrugglingAddition;

  /// l10n: parentPanelMathStrugglingSubtraction
  ///
  /// In en, this message translates to:
  /// **'Most errors made in Subtraction. Suggestion: Review Level A/B Subtraction.'**
  String get parentPanelMathStrugglingSubtraction;

  /// l10n: parentPanelMathStrugglingTens
  ///
  /// In en, this message translates to:
  /// **'Most errors made in Tens (10-100). Suggestion: Review Tens cards.'**
  String get parentPanelMathStrugglingTens;

  /// l10n: parentPanelToday
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get parentPanelToday;

  /// l10n: parentPanelYesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get parentPanelYesterday;

  /// l10n: settingsParentPanel
  ///
  /// In en, this message translates to:
  /// **'Parent Panel'**
  String get settingsParentPanel;

  /// l10n: settingsParentPanelSubtitle
  ///
  /// In en, this message translates to:
  /// **'Progress & insights'**
  String get settingsParentPanelSubtitle;

  /// l10n: settingsSectionChild
  ///
  /// In en, this message translates to:
  /// **'My Settings'**
  String get settingsSectionChild;

  /// l10n: settingsSectionParent
  ///
  /// In en, this message translates to:
  /// **'Parent Area'**
  String get settingsSectionParent;

  /// l10n: settingsSectionParentWarning
  ///
  /// In en, this message translates to:
  /// **'Controls and reports for parents'**
  String get settingsSectionParentWarning;

  /// l10n: settingsThemeLight
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// l10n: settingsThemeDark
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// l10n: settingsThemeSystem
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// l10n: settingsChooseLanguage
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get settingsChooseLanguage;

  /// l10n: settingsChooseTheme
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get settingsChooseTheme;

  /// l10n: settingsNameSavedShort
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get settingsNameSavedShort;

  /// l10n: settingsEmptyNameError
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get settingsEmptyNameError;

  /// l10n: shopScreenSubtitle
  ///
  /// In en, this message translates to:
  /// **'Customize your avatar!'**
  String get shopScreenSubtitle;

  /// l10n: shopSlotNone
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get shopSlotNone;

  /// l10n: itemEquipped
  ///
  /// In en, this message translates to:
  /// **'{item} equipped!'**
  String itemEquipped(String item);

  /// l10n: itemUnequipped
  ///
  /// In en, this message translates to:
  /// **'{slot} removed'**
  String itemUnequipped(String slot);

  /// l10n: slotHat
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get slotHat;

  /// l10n: slotGlasses
  ///
  /// In en, this message translates to:
  /// **'Glasses'**
  String get slotGlasses;

  /// l10n: slotOutfit
  ///
  /// In en, this message translates to:
  /// **'Outfit'**
  String get slotOutfit;

  /// l10n: questsScreenSubtitle
  ///
  /// In en, this message translates to:
  /// **'Complete quests and earn points!'**
  String get questsScreenSubtitle;

  /// l10n: questsDailySection
  ///
  /// In en, this message translates to:
  /// **'Daily Quests'**
  String get questsDailySection;

  /// l10n: questsWeeklySection
  ///
  /// In en, this message translates to:
  /// **'Weekly Quests'**
  String get questsWeeklySection;

  /// l10n: mathAdvancedTitle
  ///
  /// In en, this message translates to:
  /// **'Advanced Math'**
  String get mathAdvancedTitle;

  /// l10n: mathAdvancedSubtitle
  ///
  /// In en, this message translates to:
  /// **'Practicing complex operations'**
  String get mathAdvancedSubtitle;

  /// l10n: animals3dTitle
  ///
  /// In en, this message translates to:
  /// **'3D Animals'**
  String get animals3dTitle;

  /// l10n: animals3dSubtitle
  ///
  /// In en, this message translates to:
  /// **'AR Animal Experience'**
  String get animals3dSubtitle;

  /// l10n: avatarSavedSuccessfully
  ///
  /// In en, this message translates to:
  /// **'Avatar saved successfully!'**
  String get avatarSavedSuccessfully;

  /// l10n: avatarAdLoadingWait
  ///
  /// In en, this message translates to:
  /// **'⏳ Ad is loading; please try again in a few seconds.'**
  String get avatarAdLoadingWait;

  /// l10n: avatarSaveBtn
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get avatarSaveBtn;

  /// l10n: avatarItemBought
  ///
  /// In en, this message translates to:
  /// **'🎉 Great! The option was successfully purchased and unlocked!'**
  String get avatarItemBought;

  /// l10n: avatarBuyConfirmation
  ///
  /// In en, this message translates to:
  /// **'Use {price} Stars ⭐️ to permanently unlock this great option?\\n'**
  String avatarBuyConfirmation(int price);

  /// l10n: avatarBuyWithStars
  ///
  /// In en, this message translates to:
  /// **'{price} ⭐️ Buy'**
  String avatarBuyWithStars(int price);

  /// l10n: avatarAutoBought
  ///
  /// In en, this message translates to:
  /// **'✨ Great! Reached enough stars and the option was automatically purchased!'**
  String get avatarAutoBought;

  /// l10n: avatarDesignTitle
  ///
  /// In en, this message translates to:
  /// **'Design Your Avatar'**
  String get avatarDesignTitle;

  /// l10n: avatarDesignSubtitle
  ///
  /// In en, this message translates to:
  /// **'Selected item is applied instantly.'**
  String get avatarDesignSubtitle;

  /// l10n: avatarEarnedStars
  ///
  /// In en, this message translates to:
  /// **'🎉 +{earned} Stars earned! (Total: {total} ⭐️)'**
  String avatarEarnedStars(String earned, int total);
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
