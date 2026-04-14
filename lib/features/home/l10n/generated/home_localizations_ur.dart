// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class HomeLocalizationsUr extends HomeLocalizations {
  HomeLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get hello => 'سلام';

  @override
  String get slogan => 'ڈرا کریں، سیکھیں، مزہ کریں!';

  @override
  String get seeTutorial => 'سبق دیکھیں';

  @override
  String get tutorial => 'سبق';

  @override
  String get points => 'پوائنٹس';

  @override
  String get streakDay => 'دن';

  @override
  String get badgeFirstLoginName => 'پہلا قدم';

  @override
  String get badgeFirstLoginDesc => 'آپ نے پہلی بار لاگ ان کیا!';

  @override
  String get badgeFirstDrawName => 'ابتدائی آرٹسٹ';

  @override
  String get badgeFirstDrawDesc => 'آپ نے اپنی پہلی ڈرائنگ مکمل کی!';

  @override
  String get badgeStreak3Name => 'پرعزم';

  @override
  String get badgeStreak3Desc => 'آپ مسلسل 3 دن آئے!';

  @override
  String get badgeStreak7Name => 'ہفتہ وار اسٹار';

  @override
  String get badgeStreak7Desc => 'آپ نے 7 دن پریکٹس کی!';

  @override
  String get badgeMasterArtistName => 'ماस्टर آرٹسٹ';

  @override
  String get badgeMasterArtistDesc => 'آپ نے 100 ڈرائنگز کیں!';

  @override
  String get badgeStreak30Name => 'ماہانہ ماسٹر';

  @override
  String get badgeStreak30Desc => 'آپ 30 دن تک باقاعدگی سے آئے!';

  @override
  String get badgeBronzeArtistName => 'کانسی پنسل';

  @override
  String get badgeBronzeArtistDesc => 'آپ نے 10 ڈرائنگز کیں!';

  @override
  String get badgeSilverArtistName => 'چاندی پنسل';

  @override
  String get badgeSilverArtistDesc => 'آپ نے 50 ڈرائنگز کیں!';

  @override
  String get badgeGoldArtistName => 'سونے کی پنسل';

  @override
  String get badgeGoldArtistDesc => 'آپ نے 250 ڈرائنگز کیں!';

  @override
  String get badgeDiamondArtistName => 'ہیرا آرٹسٹ';

  @override
  String get badgeDiamondArtistDesc => 'آپ نے 500 ڈرائنگز کیں! ناقابل یقین!';

  @override
  String get badgeEarlyBirdName => 'صبح کا پرندہ';

  @override
  String get badgeEarlyBirdDesc => 'آپ نے صبح سویرے کام شروع کر دیا!';

  @override
  String get badgeNightOwlName => 'رات کا اللو';

  @override
  String get badgeNightOwlDesc => 'آپ رات گئے بھی کام کر رہے ہیں!';

  @override
  String get badgeWeekendWarriorName => 'ہفتے کے آخر میں تفریح';

  @override
  String get badgeWeekendWarriorDesc => 'آپ اپنا ہفتہ وار چھٹی سیکھنے میں گزار رہے ہیں!';

  @override
  String get badgeNumberMasterName => 'ریاضی باصلاحیت';

  @override
  String get badgeNumberMasterDesc => 'آپ نے 50 نمبر کھینچے!';

  @override
  String get badgeLetterMasterName => 'حروف تہجی پرو';

  @override
  String get badgeLetterMasterDesc => 'آپ نے 50 حروف کھینچے!';

  @override
  String get badgeShapeMasterName => 'جیومیٹری وزرڈ';

  @override
  String get badgeShapeMasterDesc => 'آپ نے 50 شکلیں بنائیں!';

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
  String get shopTitle => 'دکان';

  @override
  String get tabHat => 'ٹوپی';

  @override
  String get tabGlasses => 'عینک';

  @override
  String get tabOutfit => 'لباس';

  @override
  String get owned => 'ملکیت';

  @override
  String get equipped => 'لیس';

  @override
  String get insufficientPoints => 'پوائنٹس ناکافی ہیں! 😢';

  @override
  String get buyTitle => 'آئٹم خریدیں؟';

  @override
  String buyDescription(int price) {
    return 'کیا آپ $price ستاروں کے بدلے یہ آئٹم خریدنا چاہتے ہیں؟';
  }

  @override
  String get noBtn => 'نہیں';

  @override
  String get yesBuyBtn => 'ہاں، خریدیں!';

  @override
  String itemBought(String item) {
    return '$item خریدا گیا! 🎉';
  }

  @override
  String get freePointsBtn => 'اشتہار دیکھیں پوائنٹس حاصل کریں';

  @override
  String rewardEarned(int amount) {
    return 'مبارک ہو! آپ نے $amount پوائنٹس حاصل کیے! 🎉';
  }

  @override
  String get myQuestsTitle => 'میری مہمات';

  @override
  String get loadingQuests => 'مہمات لوڈ ہو رہی ہیں...';

  @override
  String get questsRefreshedMessage => 'آپ کی مہمات اپ ڈیٹ ہو گئیں۔';

  @override
  String get dailyQuest => 'روزانہ کی مہم';

  @override
  String get weeklyQuest => 'ہفتہ وار مہم';

  @override
  String get hat_blue_cap => 'نیلی ٹوپی';

  @override
  String get hat_crown => 'تاج';

  @override
  String get hat_wizard => 'جادوگر کی ٹوپی';

  @override
  String get hat_flower => 'پھولوں کا تاج';

  @override
  String get hat_pirate => 'سمندری ڈاکو کی ٹوپی';

  @override
  String get hat_chef => 'بورچی کی ٹوپی';

  @override
  String get glasses_sun => 'دھوپ کا چشمہ';

  @override
  String get glasses_nerd => 'پڑھاکو عینک';

  @override
  String get glasses_heart => 'دل والی عینک';

  @override
  String get glasses_3d => '3D عینک';

  @override
  String get glasses_vr => 'VR ہیڈسیٹ';

  @override
  String get glasses_ski => 'اسکی چشمہ';

  @override
  String get glasses_mask => 'ماسک';

  @override
  String get glasses_reading => 'پڑھنے کی عینک';

  @override
  String get outfit_red => 'سرخ قمیض';

  @override
  String get outfit_super => 'سپر ہیرو';

  @override
  String get outfit_green => 'سبز ہوڈی';

  @override
  String get outfit_doctor => 'ڈاکٹر کا کوٹ';

  @override
  String get outfit_space => 'خلائی سوٹ';

  @override
  String get outfit_sports => 'جرسی';

  @override
  String get outfit_police => 'پولیس کی وردی';

  @override
  String get outfit_chef => 'بورچی ایپن';

  @override
  String get outfit_winter => 'سرمائی کوٹ';

  @override
  String get outfit_tuxedo => 'ٹکسیڈو';

  @override
  String get badgesTitle => 'میرے بیجز';

  @override
  String get totalBadges => 'کل:';

  @override
  String get filterAll => 'سب';

  @override
  String get filterEarned => 'حاصل شدہ';

  @override
  String get filterLocked => 'مقفل';

  @override
  String get numbersTitle => 'نمبر سیکھیں';

  @override
  String get lettersTitle => 'حروف سیکھیں';

  @override
  String get shapesTitle => 'اشکال سیکھیں';

  @override
  String get colorsTitle => 'رنگ سیکھیں';

  @override
  String get badgeColorMasterName => 'رنگ کا ماہر';

  @override
  String get badgeColorMasterDesc => 'آپ نے 50 رنگ کے راؤنڈ مکمل کیے!';

  @override
  String get noBadgesFound => 'No badges found';
}
