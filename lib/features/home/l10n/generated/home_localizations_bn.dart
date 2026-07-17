// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class HomeLocalizationsBn extends HomeLocalizations {
  HomeLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get hello => 'হ্যালো';

  @override
  String get slogan => 'আঁকো, শিখো, মজা করো!';

  @override
  String get seeTutorial => 'টিউটোরিয়াল দেখুন';

  @override
  String get tutorial => 'টিউটোরিয়াল';

  @override
  String get points => 'পয়েন্ট';

  @override
  String get streakDay => 'দিন';

  @override
  String get badgeFirstLoginName => 'প্রথম ধাপ';

  @override
  String get badgeFirstLoginDesc => 'আপনি প্রথমবার লগ ইন করেছেন!';

  @override
  String get badgeFirstDrawName => 'শুরু করা শিল্পী';

  @override
  String get badgeFirstDrawDesc => 'আপনি আপনার প্রথম অঙ্কন সম্পন্ন করেছেন!';

  @override
  String get badgeStreak3Name => 'দৃঢ়সংকল্প';

  @override
  String get badgeStreak3Desc => 'আপনি টানা ৩ দিন এসেছেন!';

  @override
  String get badgeStreak7Name => 'সাপ্তাহিক তারা';

  @override
  String get badgeStreak7Desc => 'আপনি ৭ দিন অনুশীলন করেছেন!';

  @override
  String get badgeMasterArtistName => 'মাস্টার শিল্পী';

  @override
  String get badgeMasterArtistDesc => 'আপনি ১০০টি অঙ্কন করেছেন!';

  @override
  String get badgeStreak30Name => 'মাসিক মাস্টার';

  @override
  String get badgeStreak30Desc => 'আপনি ৩০ দিন নিয়মিত এসেছেন!';

  @override
  String get badgeBronzeArtistName => 'ব্রোঞ্জ পেন্সিল';

  @override
  String get badgeBronzeArtistDesc => 'আপনি ১০টি অঙ্কন করেছেন!';

  @override
  String get badgeSilverArtistName => 'রৌপ্য পেন্সিল';

  @override
  String get badgeSilverArtistDesc => 'আপনি ৫০টি অঙ্কন করেছেন!';

  @override
  String get badgeGoldArtistName => 'সোনার পেন্সিল';

  @override
  String get badgeGoldArtistDesc => 'আপনি ২৫০টি অঙ্কন করেছেন!';

  @override
  String get badgeDiamondArtistName => 'হীরা শিল্পী';

  @override
  String get badgeDiamondArtistDesc => 'আপনি ৫০০টি অঙ্কন করেছেন! অবিশ্বাস্য!';

  @override
  String get badgeEarlyBirdName => 'ভোরের পাখি';

  @override
  String get badgeEarlyBirdDesc => 'আপনি সকালে তাড়াতাড়ি কাজ শুরু করেছেন!';

  @override
  String get badgeNightOwlName => 'রাতের পেঁচা';

  @override
  String get badgeNightOwlDesc => 'আপনি গভীর রাতেও কাজ করছেন!';

  @override
  String get badgeWeekendWarriorName => 'সাপ্তাহিক ছুটির মজা';

  @override
  String get badgeWeekendWarriorDesc => 'আপনি আপনার সপ্তাহান্ত শিখতে ব্যয় করছেন!';

  @override
  String get badgeNumberMasterName => 'গণিত জিনিয়াস';

  @override
  String get badgeNumberMasterDesc => 'আপনি ৫০টি সংখ্যা এঁকেছেন!';

  @override
  String get badgeLetterMasterName => 'বর্ণমালা প্রো';

  @override
  String get badgeLetterMasterDesc => 'আপনি ৫০টি অক্ষর এঁকেছেন!';

  @override
  String get badgeShapeMasterName => 'জ্যামিতি উইজার্ড';

  @override
  String get badgeShapeMasterDesc => 'আপনি ৫০টি আকার এঁকেছেন!';

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
  String get shopTitle => 'দোকান';

  @override
  String get tabHat => 'টুপি';

  @override
  String get tabGlasses => 'চশমা';

  @override
  String get tabOutfit => 'পোশাক';

  @override
  String get owned => 'মালিকানাধীন';

  @override
  String get equipped => 'সজ্জিত';

  @override
  String get insufficientPoints => 'পর্যাপ্ত পয়েন্ট নেই! 😢';

  @override
  String get buyTitle => 'আইটেম কিনবেন?';

  @override
  String buyDescription(int price) {
    return 'আপনি কি $price তারা দিয়ে এই আইটেমটি কিনতে চান?';
  }

  @override
  String get noBtn => 'না';

  @override
  String get yesBuyBtn => 'হ্যাঁ, কিনুন!';

  @override
  String itemBought(String item) {
    return '$item কেনা হয়েছে! 🎉';
  }

  @override
  String get freePointsBtn => 'বিজ্ঞাপন দেখুন পয়েন্ট অর্জন করুন';

  @override
  String rewardEarned(int amount) {
    return 'অভিনন্দন! আপনি $amount পয়েন্ট অর্জন করেছেন! 🎉';
  }

  @override
  String get myQuestsTitle => 'আমার অনুসন্ধান';

  @override
  String get loadingQuests => 'অনুসন্ধান লোড হচ্ছে...';

  @override
  String get dailyQuest => 'দৈনিক অনুসন্ধান';

  @override
  String get weeklyQuest => 'সাপ্তাহিক অনুসন্ধান';

  @override
  String get hat_blue_cap => 'নীল টুপি';

  @override
  String get hat_crown => 'মুকুট';

  @override
  String get hat_wizard => 'জাদুকরের টুপি';

  @override
  String get hat_flower => 'ফুলের মুকুট';

  @override
  String get hat_pirate => 'জলদস্যু টুপি';

  @override
  String get hat_chef => 'শেফ টুপি';

  @override
  String get glasses_sun => 'রোদচশমা';

  @override
  String get glasses_nerd => 'নার্ড গ্লাস';

  @override
  String get glasses_heart => 'হার্ট গ্লাস';

  @override
  String get glasses_3d => '3D গ্লাস';

  @override
  String get glasses_vr => 'VR হেডসেট';

  @override
  String get glasses_ski => 'স্কি গগলস';

  @override
  String get glasses_mask => 'মাস্ক';

  @override
  String get glasses_reading => 'পড়ার চশমা';

  @override
  String get outfit_red => 'লাল শার্ট';

  @override
  String get outfit_super => 'সুপারহিরো';

  @override
  String get outfit_green => 'সবুজ হুডি';

  @override
  String get outfit_doctor => 'ডাক্তারের কোট';

  @override
  String get outfit_space => 'স্পেস স্যুট';

  @override
  String get outfit_sports => 'জার্সি';

  @override
  String get outfit_police => 'পুলিশ ইউনিফর্ম';

  @override
  String get outfit_chef => 'শেফ অ্যাপ্রন';

  @override
  String get outfit_winter => 'শীতের কোট';

  @override
  String get outfit_tuxedo => 'টাক্সিডো';

  @override
  String get badgesTitle => 'আমার ব্যাজ';

  @override
  String get totalBadges => 'মোট:';

  @override
  String get filterAll => 'সব';

  @override
  String get filterEarned => 'অর্জিত';

  @override
  String get filterLocked => 'লক';

  @override
  String get numbersTitle => 'সংখ্যা শিখুন';

  @override
  String get lettersTitle => 'অক্ষর শিখুন';

  @override
  String get shapesTitle => 'আকৃতি শিখুন';

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
