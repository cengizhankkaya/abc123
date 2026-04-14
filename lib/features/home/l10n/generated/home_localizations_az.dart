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
  String get loadingQuests => 'Tapşırıqlar yüklənir...';

  @override
  String get questsRefreshedMessage => 'Tapşırıqlarınız yeniləndi.';

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
  String get colorsTitle => 'Rəngləri öyrən';

  @override
  String get badgeColorMasterName => 'Rəng ustası';

  @override
  String get badgeColorMasterDesc => '50 rəng turunu tamamladın!';

  @override
  String get noBadgesFound => 'No badges found';
}
