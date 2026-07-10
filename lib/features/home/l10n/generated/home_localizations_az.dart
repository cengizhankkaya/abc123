// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class HomeLocalizationsAz extends HomeLocalizations {
  HomeLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get hello => 'Salam';

  @override
  String get slogan => 'Çək, öyrən, əylən!';

  @override
  String get seeTutorial => 'Təlimata bax';

  @override
  String get tutorial => 'Təlimat';

  @override
  String get points => 'Xallar';

  @override
  String get streakDay => 'Gün';

  @override
  String get badgeFirstLoginName => 'İlk Addım';

  @override
  String get badgeFirstLoginDesc => 'Tətbiqə ilk dəfə daxil oldun!';

  @override
  String get badgeFirstDrawName => 'Rəssamlığa Başlanğıc';

  @override
  String get badgeFirstDrawDesc => 'İlk rəsmini tamamladın!';

  @override
  String get badgeStreak3Name => 'Əzmli';

  @override
  String get badgeStreak3Desc => '3 gün ardıcıl gəldin!';

  @override
  String get badgeStreak7Name => 'Həftənin Ulduzu';

  @override
  String get badgeStreak7Desc => '7 gün ərzində çalışdın!';

  @override
  String get badgeMasterArtistName => 'Usta Rəssam';

  @override
  String get badgeMasterArtistDesc => '100 rəsm çəkdin!';

  @override
  String get badgeStreak30Name => 'Aylıq Usta';

  @override
  String get badgeStreak30Desc => '30 gün ərzində müntəzəm gəldin!';

  @override
  String get badgeBronzeArtistName => 'Bürünc Qələm';

  @override
  String get badgeBronzeArtistDesc => '10 rəsm çəkdin!';

  @override
  String get badgeSilverArtistName => 'Gümüş Qələm';

  @override
  String get badgeSilverArtistDesc => '50 rəsm çəkdin!';

  @override
  String get badgeGoldArtistName => 'Qızıl Qələm';

  @override
  String get badgeGoldArtistDesc => '250 rəsm çəkdin!';

  @override
  String get badgeDiamondArtistName => 'Almaz Rəssam';

  @override
  String get badgeDiamondArtistDesc => '500 rəsm çəkdin! İnanılmaz!';

  @override
  String get badgeEarlyBirdName => 'Səhər Quşu';

  @override
  String get badgeEarlyBirdDesc => 'Səhər tezdən işləməyə başladın!';

  @override
  String get badgeNightOwlName => 'Gecə Quşu';

  @override
  String get badgeNightOwlDesc => 'Gecə gec saatlarda belə işləyirsən!';

  @override
  String get badgeWeekendWarriorName => 'Həftəsonu Əyləncəsi';

  @override
  String get badgeWeekendWarriorDesc => 'Həftəsonunu öyrənərək keçirirsən!';

  @override
  String get badgeNumberMasterName => 'Riyaziyyat Dahisi';

  @override
  String get badgeNumberMasterDesc => '50 rəqəm çəkdin!';

  @override
  String get badgeLetterMasterName => 'Əlifba Ustası';

  @override
  String get badgeLetterMasterDesc => '50 hərf çəkdin!';

  @override
  String get badgeShapeMasterName => 'Həndəsə Sehirbazı';

  @override
  String get badgeShapeMasterDesc => '50 forma çəkdin!';

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
  String get shopTitle => 'MAĞAZA';

  @override
  String get shopScreenSubtitle => 'Customize your avatar!';

  @override
  String get tabHat => 'Şapka';

  @override
  String get tabGlasses => 'Eynək';

  @override
  String get tabOutfit => 'Geyim';

  @override
  String get owned => 'Sənin';

  @override
  String get equipped => 'Geyinilib';

  @override
  String get shopSlotNone => 'Çıxar';

  @override
  String itemEquipped(String item) {
    return '$item geyildi!';
  }

  @override
  String itemUnequipped(String slot) {
    return '$slot çıxarıldı';
  }

  @override
  String get slotHat => 'Papaq';

  @override
  String get slotGlasses => 'Eynək';

  @override
  String get slotOutfit => 'Geyim';

  @override
  String get insufficientPoints => 'Kifayət qədər xalın yoxdur! 😢';

  @override
  String get buyTitle => 'Satın al?';

  @override
  String buyDescription(int price) {
    return 'Bu əşyanı $price ulduz qarşılığında almaq istəyirsən?';
  }

  @override
  String get noBtn => 'Xeyr';

  @override
  String get yesBuyBtn => 'Bəli, Al!';

  @override
  String itemBought(String item) {
    return '$item alındı! 🎉';
  }

  @override
  String get freePointsBtn => 'REKLAM İZLƏ XAL QAZAN';

  @override
  String rewardEarned(int amount) {
    return 'Təbriklər! $amount Xal Qazandın! 🎉';
  }

  @override
  String get myQuestsTitle => 'GÖREVLERİM';

  @override
  String get questsScreenSubtitle => 'Complete quests and earn points!';

  @override
  String get questsDailySection => 'Daily Quests';

  @override
  String get questsWeeklySection => 'Weekly Quests';

  @override
  String get loadingQuests => 'Tapşırıqlar yüklənir...';

  @override
  String get dailyQuest => 'GÜNLÜK TAPŞIRIQ';

  @override
  String get weeklyQuest => 'HƏFTƏLİK TAPŞIRIQ';

  @override
  String get hat_blue_cap => 'Mavi Papaq';

  @override
  String get hat_crown => 'Tac';

  @override
  String get hat_wizard => 'Sehirbaz Papağı';

  @override
  String get hat_flower => 'Çiçəkli Tac';

  @override
  String get hat_pirate => 'Dənizçi Papağı';

  @override
  String get hat_chef => 'Aşpaz Papağı';

  @override
  String get glasses_sun => 'Günəş Eynəyi';

  @override
  String get glasses_nerd => 'Ağıllı Eynəyi';

  @override
  String get glasses_heart => 'Ürək Eynək';

  @override
  String get glasses_3d => '3D Eynək';

  @override
  String get glasses_vr => 'VR Eynəyi';

  @override
  String get glasses_ski => 'Xizək Eynəyi';

  @override
  String get glasses_mask => 'Maska';

  @override
  String get glasses_reading => 'Oxu Eynəyi';

  @override
  String get outfit_red => 'Qırmızı Köynək';

  @override
  String get outfit_super => 'Super Qəhrəman';

  @override
  String get outfit_green => 'Yaşıl Hoodie';

  @override
  String get outfit_doctor => 'Həkim Xalatı';

  @override
  String get outfit_space => 'Kosmonavt Kostyumu';

  @override
  String get outfit_sports => 'Forma';

  @override
  String get outfit_police => 'Polis Forması';

  @override
  String get outfit_chef => 'Aşpaz Önlüyü';

  @override
  String get outfit_winter => 'Qış Gödəkcəsi';

  @override
  String get outfit_tuxedo => 'Smokin';

  @override
  String get badgesTitle => 'NİŞANLARIM';

  @override
  String get totalBadges => 'Cəmi:';

  @override
  String get filterAll => 'HAMISI';

  @override
  String get filterEarned => 'QAZANILAN';

  @override
  String get filterLocked => 'KİLİDLİ';

  @override
  String get numbersTitle => 'Rəqəmləri öyrən';

  @override
  String get lettersTitle => 'Hərfləri öyrən';

  @override
  String get shapesTitle => 'Fiqurları öyrən';

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
    return '$name\'s progress this week';
  }

  @override
  String get parentPanelWeeklyProgressNoName => 'Progress this week';

  @override
  String get parentPanelStatDuration => 'TIME';

  @override
  String get parentPanelStatCompleted => 'COMPLETED';

  @override
  String get parentPanelStatAccuracy => 'AVG. ACCURACY';

  @override
  String parentPanelDurationMinutes(int minutes) {
    return '${minutes}min';
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
  String get parentPanelInsightGettingStarted => 'Learning journey is just starting';

  @override
  String get parentPanelToday => 'Today';

  @override
  String get parentPanelYesterday => 'Yesterday';

  @override
  String get settingsParentPanel => 'Parent Panel';

  @override
  String get settingsParentPanelSubtitle => 'Progress & insights';
}
