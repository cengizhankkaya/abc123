// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class HomeLocalizationsEn extends HomeLocalizations {
  HomeLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get slogan => 'Draw, Learn, Have Fun!';

  @override
  String get seeTutorial => 'See Tutorial';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get points => 'Points';

  @override
  String get streakDay => 'Days';

  @override
  String get badgeFirstLoginName => 'First Step';

  @override
  String get badgeFirstLoginDesc => 'You logged in for the first time!';

  @override
  String get badgeFirstDrawName => 'Beginning Artist';

  @override
  String get badgeFirstDrawDesc => 'You completed your first drawing!';

  @override
  String get badgeStreak3Name => 'Determined';

  @override
  String get badgeStreak3Desc => 'You came 3 days in a row!';

  @override
  String get badgeStreak7Name => 'Weekly Star';

  @override
  String get badgeStreak7Desc => 'You practiced for 7 days!';

  @override
  String get badgeMasterArtistName => 'Master Artist';

  @override
  String get badgeMasterArtistDesc => 'You made 100 drawings!';

  @override
  String get badgeStreak30Name => 'Monthly Master';

  @override
  String get badgeStreak30Desc => 'You came regularly for 30 days!';

  @override
  String get badgeBronzeArtistName => 'Bronze Pencil';

  @override
  String get badgeBronzeArtistDesc => 'You made 10 drawings!';

  @override
  String get badgeSilverArtistName => 'Silver Pencil';

  @override
  String get badgeSilverArtistDesc => 'You made 50 drawings!';

  @override
  String get badgeGoldArtistName => 'Gold Pencil';

  @override
  String get badgeGoldArtistDesc => 'You made 250 drawings!';

  @override
  String get badgeDiamondArtistName => 'Diamond Artist';

  @override
  String get badgeDiamondArtistDesc => 'You made 500 drawings! Incredible!';

  @override
  String get badgeEarlyBirdName => 'Early Bird';

  @override
  String get badgeEarlyBirdDesc => 'You started working early in the morning!';

  @override
  String get badgeNightOwlName => 'Night Owl';

  @override
  String get badgeNightOwlDesc => 'You are working even late at night!';

  @override
  String get badgeWeekendWarriorName => 'Weekend Fun';

  @override
  String get badgeWeekendWarriorDesc => 'You are spending your weekend learning!';

  @override
  String get badgeNumberMasterName => 'Math Genius';

  @override
  String get badgeNumberMasterDesc => 'You drew 50 numbers!';

  @override
  String get badgeLetterMasterName => 'Alphabet Pro';

  @override
  String get badgeLetterMasterDesc => 'You drew 50 letters!';

  @override
  String get badgeShapeMasterName => 'Geometry Wizard';

  @override
  String get badgeShapeMasterDesc => 'You drew 50 shapes!';

  @override
  String get badgeHighScorerName => 'High Scorer';

  @override
  String get badgeHighScorerDesc => 'You reached 1000 points!';

  @override
  String get badgeScoreLegendName => 'Score Legend';

  @override
  String get badgeScoreLegendDesc => 'You reached 5000 points!';

  @override
  String get badgeBadgeCollectorName => 'Badge Collector';

  @override
  String get badgeBadgeCollectorDesc => 'You earned 5 badges!';

  @override
  String get badgeBadgeMasterName => 'Badge Master';

  @override
  String get badgeBadgeMasterDesc => 'You earned 15 badges!';

  @override
  String get shopTitle => 'SHOP';

  @override
  String get tabHat => 'Hat';

  @override
  String get tabGlasses => 'Glasses';

  @override
  String get tabOutfit => 'Outfit';

  @override
  String get owned => 'Owned';

  @override
  String get equipped => 'Equipped';

  @override
  String get insufficientPoints => 'Not enough points! 😢';

  @override
  String get buyTitle => 'Buy Item?';

  @override
  String buyDescription(int price) {
    return 'Do you want to buy this item for $price stars?';
  }

  @override
  String get noBtn => 'No';

  @override
  String get yesBuyBtn => 'Yes, Buy!';

  @override
  String itemBought(String item) {
    return '$item bought! 🎉';
  }

  @override
  String get freePointsBtn => 'WATCH AD EARN POINTS';

  @override
  String rewardEarned(int amount) {
    return 'Congrats! You earned $amount Points! 🎉';
  }

  @override
  String get myQuestsTitle => 'MY QUESTS';

  @override
  String get loadingQuests => 'Loading quests...';

  @override
  String get dailyQuest => 'DAILY QUEST';

  @override
  String get weeklyQuest => 'WEEKLY QUEST';

  @override
  String get hat_blue_cap => 'Blue Cap';

  @override
  String get hat_crown => 'Crown';

  @override
  String get hat_wizard => 'Wizard Hat';

  @override
  String get hat_flower => 'Flower Crown';

  @override
  String get hat_pirate => 'Pirate Hat';

  @override
  String get hat_chef => 'Chef Hat';

  @override
  String get glasses_sun => 'Sunglasses';

  @override
  String get glasses_nerd => 'Nerd Glasses';

  @override
  String get glasses_heart => 'Heart Glasses';

  @override
  String get glasses_3d => '3D Glasses';

  @override
  String get glasses_vr => 'VR Headset';

  @override
  String get glasses_ski => 'Ski Goggles';

  @override
  String get glasses_mask => 'Mask';

  @override
  String get glasses_reading => 'Reading Glasses';

  @override
  String get outfit_red => 'Red Shirt';

  @override
  String get outfit_super => 'Superhero';

  @override
  String get outfit_green => 'Green Hoodie';

  @override
  String get outfit_doctor => 'Doctor Coat';

  @override
  String get outfit_space => 'Space Suit';

  @override
  String get outfit_sports => 'Jersey';

  @override
  String get outfit_police => 'Police Uniform';

  @override
  String get outfit_chef => 'Chef Apron';

  @override
  String get outfit_winter => 'Winter Coat';

  @override
  String get outfit_tuxedo => 'Tuxedo';

  @override
  String get badgesTitle => 'MY BADGES';

  @override
  String get totalBadges => 'Total:';

  @override
  String get filterAll => 'ALL';

  @override
  String get filterEarned => 'EARNED';

  @override
  String get filterLocked => 'LOCKED';

  @override
  String get numbersTitle => 'Learn Numbers';

  @override
  String get lettersTitle => 'Learn Letters';

  @override
  String get shapesTitle => 'Learn Shapes';

  @override
  String get colorsTitle => 'Learn Colors';

  @override
  String get wordsTitle => 'Build Words';

  @override
  String get badgeColorMasterName => 'Color Expert';

  @override
  String get badgeColorMasterDesc => 'You completed 50 color rounds!';

  @override
  String get badgeWordMasterName => 'Word Builder';

  @override
  String get badgeWordMasterDesc => 'You completed 50 words!';

  @override
  String get questsRefreshedMessage => 'Quests have been refreshed.';

  @override
  String get noBadgesFound => 'No badges found';

  @override
  String homeGreetingWithName(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homeSloganToday => 'What shall we learn today?';

  @override
  String homeStreakDays(int count) {
    return '$count-day streak';
  }

  @override
  String get homeLearningModes => 'Learning Modes';

  @override
  String get numbersTitleShort => 'Numbers';

  @override
  String get lettersTitleShort => 'Letters';

  @override
  String get shapesTitleShort => 'Shapes';

  @override
  String get wordsTitleShort => 'Words';

  @override
  String get colorsTitleShort => 'Colors';

  @override
  String get numbersSubtitle => 'Draw 0–9';

  @override
  String get lettersSubtitle => 'Draw A–Z';

  @override
  String get shapesSubtitle => 'New!';

  @override
  String get wordsSubtitle => 'Draw words';

  @override
  String get colorsSubtitle => 'Play & learn';

  @override
  String homeWhereYouLeft(String label) {
    return 'Where you left off: $label';
  }

  @override
  String homeStepsRemaining(int count) {
    return '$count steps left';
  }

  @override
  String homeContinueNumber(String number) {
    return 'Number $number';
  }

  @override
  String homeContinueLetter(String letter) {
    return 'Letter $letter';
  }

  @override
  String homeContinueShape(String number) {
    return 'Shape $number';
  }

  @override
  String get homeContinueWord => 'Words';

  @override
  String get homeContinueColor => 'Colors';

  @override
  String get homeContinueColorVision => 'Color Vision';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsChildName => 'Name';

  @override
  String get settingsChildNameHint => 'Enter your name';

  @override
  String get settingsSaveName => 'Save';

  @override
  String get settingsNameSaved => 'Name saved';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get badgesScreenTitle => 'My Badges';

  @override
  String badgesEarnedOfTotal(int count, int total) {
    return '$count / $total badges earned';
  }

  @override
  String badgesStreakDayCount(int count) {
    return '$count days';
  }

  @override
  String get badgesStreakSubtitle => 'Drawing streak';

  @override
  String get parentPanelTitle => 'Parent Panel';

  @override
  String parentPanelWeeklyProgress(String name) {
    return '$name\'s weekly progress';
  }

  @override
  String get parentPanelWeeklyProgressNoName => 'Weekly progress';

  @override
  String get parentPanelStatDuration => 'TIME';

  @override
  String get parentPanelStatCompleted => 'COMPLETED';

  @override
  String get parentPanelStatAccuracy => 'AVG. ACCURACY';

  @override
  String parentPanelDurationMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String parentPanelAccuracyPercent(int percent) {
    return '$percent%';
  }

  @override
  String get parentPanelChartTitle => 'Daily drawing time';

  @override
  String parentPanelInsightLettersLearned(String range) {
    return 'Letters $range learned';
  }

  @override
  String parentPanelInsightNumberStruggling(int number) {
    return 'Struggling with number $number';
  }

  @override
  String get parentPanelInsightGettingStarted => 'Learning journey is just getting started';

  @override
  String get parentPanelInsightMath => 'Working on advanced math operations!';

  @override
  String get parentPanelMathStrugglingAddition =>
      'Most errors made in Addition. Suggestion: Review Visual & Symbolic Addition.';

  @override
  String get parentPanelMathStrugglingSubtraction =>
      'Most errors made in Subtraction. Suggestion: Review Level A/B Subtraction.';

  @override
  String get parentPanelMathStrugglingTens =>
      'Most errors made in Tens (10-100). Suggestion: Review Tens cards.';

  @override
  String get parentPanelToday => 'Today';

  @override
  String get parentPanelYesterday => 'Yesterday';

  @override
  String get settingsParentPanel => 'Parent Panel';

  @override
  String get settingsParentPanelSubtitle => 'Progress & insights';

  @override
  String get settingsSectionChild => 'My Settings';

  @override
  String get settingsSectionParent => 'Parent Area';

  @override
  String get settingsSectionParentWarning => 'Controls and reports for parents';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsChooseLanguage => 'Choose Language';

  @override
  String get settingsChooseTheme => 'Choose Theme';

  @override
  String get settingsNameSavedShort => 'Saved';

  @override
  String get settingsEmptyNameError => 'Name cannot be empty';

  @override
  String get shopScreenSubtitle => 'Customize your avatar!';

  @override
  String get shopSlotNone => 'Remove';

  @override
  String itemEquipped(String item) {
    return '$item equipped!';
  }

  @override
  String itemUnequipped(String slot) {
    return '$slot removed';
  }

  @override
  String get slotHat => 'Hat';

  @override
  String get slotGlasses => 'Glasses';

  @override
  String get slotOutfit => 'Outfit';

  @override
  String get questsScreenSubtitle => 'Complete quests and earn points!';

  @override
  String get questsDailySection => 'Daily Quests';

  @override
  String get questsWeeklySection => 'Weekly Quests';

  @override
  String get mathAdvancedTitle => 'Advanced Math';

  @override
  String get mathAdvancedSubtitle => 'Practicing complex operations';

  @override
  String get animals3dTitle => '3D Animals';

  @override
  String get animals3dSubtitle => 'AR Animal Experience';

  @override
  String get avatarSavedSuccessfully => 'Avatar saved successfully!';

  @override
  String get avatarAdLoadingWait => '⏳ Ad is loading; please try again in a few seconds.';

  @override
  String get avatarSaveBtn => 'Save';

  @override
  String get avatarItemBought => '🎉 Great! The option was successfully purchased and unlocked!';

  @override
  String avatarBuyConfirmation(int price) {
    return 'Use $price Stars ⭐️ to permanently unlock this great option?\\n';
  }

  @override
  String avatarBuyWithStars(int price) {
    return '$price ⭐️ Buy';
  }

  @override
  String get avatarAutoBought =>
      '✨ Great! Reached enough stars and the option was automatically purchased!';

  @override
  String get avatarDesignTitle => 'Design Your Avatar';

  @override
  String get avatarDesignSubtitle => 'Selected item is applied instantly.';

  @override
  String avatarEarnedStars(String earned, int total) {
    return '🎉 +$earned Stars earned! (Total: $total ⭐️)';
  }
}
