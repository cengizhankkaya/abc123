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
  String get questsRefreshedMessage => 'আপনার অনুসন্ধান আপডেট হয়েছে।';

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
  String get colorsTitle => 'রং শিখুন';

  @override
  String get badgeColorMasterName => 'রং বিশেষজ্ঞ';

  @override
  String get badgeColorMasterDesc => 'আপনি ৫০টি রঙের রাউন্ড শেষ করেছেন!';

  @override
  String get noBadgesFound => 'No badges found';
}
