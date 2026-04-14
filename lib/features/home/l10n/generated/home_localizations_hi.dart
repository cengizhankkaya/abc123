// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class HomeLocalizationsHi extends HomeLocalizations {
  HomeLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get hello => 'नमस्ते';

  @override
  String get slogan => 'ड्रॉ करें, सीखें, मज़े करें!';

  @override
  String get seeTutorial => 'ट्यूटोरियल देखें';

  @override
  String get tutorial => 'ट्यूटोरियल';

  @override
  String get points => 'अंक';

  @override
  String get streakDay => 'दिन';

  @override
  String get badgeFirstLoginName => 'पहला कदम';

  @override
  String get badgeFirstLoginDesc => 'आपने पहली बार लॉग इन किया!';

  @override
  String get badgeFirstDrawName => 'शुरुआती कलाकार';

  @override
  String get badgeFirstDrawDesc => 'आपने अपना पहला चित्र पूरा किया!';

  @override
  String get badgeStreak3Name => 'दृढ़';

  @override
  String get badgeStreak3Desc => 'आप लगातार 3 दिन आए!';

  @override
  String get badgeStreak7Name => 'साप्ताहिक सितारा';

  @override
  String get badgeStreak7Desc => 'आपने 7 दिनों तक अभ्यास किया!';

  @override
  String get badgeMasterArtistName => 'मास्टर कलाकार';

  @override
  String get badgeMasterArtistDesc => 'आपने 100 चित्र बनाए!';

  @override
  String get badgeStreak30Name => 'मासिक गुरु';

  @override
  String get badgeStreak30Desc => 'आप 30 दिनों तक नियमित रूप से आए!';

  @override
  String get badgeBronzeArtistName => 'कांस्य पेंसिल';

  @override
  String get badgeBronzeArtistDesc => 'आपने 10 चित्र बनाए!';

  @override
  String get badgeSilverArtistName => 'चांदी की पेंसिल';

  @override
  String get badgeSilverArtistDesc => 'आपने 50 चित्र बनाए!';

  @override
  String get badgeGoldArtistName => 'सोने की पेंसिल';

  @override
  String get badgeGoldArtistDesc => 'आपने 250 चित्र बनाए!';

  @override
  String get badgeDiamondArtistName => 'हीरा कलाकार';

  @override
  String get badgeDiamondArtistDesc => 'आपने 500 चित्र बनाए! अविश्वसनीय!';

  @override
  String get badgeEarlyBirdName => 'जल्दी उठने वाला';

  @override
  String get badgeEarlyBirdDesc => 'आपने सुबह जल्दी काम शुरू कर दिया!';

  @override
  String get badgeNightOwlName => 'रात का उल्लू';

  @override
  String get badgeNightOwlDesc => 'आप देर रात भी काम कर रहे हैं!';

  @override
  String get badgeWeekendWarriorName => 'सप्ताहांत मज़ा';

  @override
  String get badgeWeekendWarriorDesc => 'आप अपना सप्ताहांत सीखने में बिता रहे हैं!';

  @override
  String get badgeNumberMasterName => 'गणित प्रतिभा';

  @override
  String get badgeNumberMasterDesc => 'आपने 50 नंबर बनाए!';

  @override
  String get badgeLetterMasterName => 'वर्णमाला समर्थक';

  @override
  String get badgeLetterMasterDesc => 'आपने 50 अक्षर बनाए!';

  @override
  String get badgeShapeMasterName => 'ज्यामिति जादूगर';

  @override
  String get badgeShapeMasterDesc => 'आपने 50 आकार बनाए!';

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
  String get shopTitle => 'दुकान';

  @override
  String get tabHat => 'टोपी';

  @override
  String get tabGlasses => 'चश्मा';

  @override
  String get tabOutfit => 'पोशाक';

  @override
  String get owned => 'स्वामित्व';

  @override
  String get equipped => 'सुसज्जित';

  @override
  String get insufficientPoints => 'अपर्याप्त अंक! 😢';

  @override
  String get buyTitle => 'वस्तु खरीदें?';

  @override
  String buyDescription(int price) {
    return 'क्या आप $price सितारों के लिए इस वस्तु को खरीदना चाहते हैं?';
  }

  @override
  String get noBtn => 'नहीं';

  @override
  String get yesBuyBtn => 'हाँ, खरीदें!';

  @override
  String itemBought(String item) {
    return '$item खरीदा गया! 🎉';
  }

  @override
  String get freePointsBtn => 'विज्ञापन देखें अंक कमाएं';

  @override
  String rewardEarned(int amount) {
    return 'बधाई हो! आपने $amount अंक अर्जित किए! 🎉';
  }

  @override
  String get myQuestsTitle => 'मेरी खोज';

  @override
  String get loadingQuests => 'खोज लोड हो रही हैं...';

  @override
  String get questsRefreshedMessage => 'आपकी खोज अपडेट हो गईं।';

  @override
  String get dailyQuest => 'दैनिक खोज';

  @override
  String get weeklyQuest => 'साप्ताहिक खोज';

  @override
  String get hat_blue_cap => 'नीली टोपी';

  @override
  String get hat_crown => 'ताज';

  @override
  String get hat_wizard => 'जादूगर टोपी';

  @override
  String get hat_flower => 'फूलों का ताज';

  @override
  String get hat_pirate => 'समुद्री डाकू टोपी';

  @override
  String get hat_chef => 'बावर्ची टोपी';

  @override
  String get glasses_sun => 'धूप का चश्मा';

  @override
  String get glasses_nerd => 'पढ़ाकू चश्मा';

  @override
  String get glasses_heart => 'दिल चश्मा';

  @override
  String get glasses_3d => '3D चश्मा';

  @override
  String get glasses_vr => 'VR हेडसेट';

  @override
  String get glasses_ski => 'स्की चश्मा';

  @override
  String get glasses_mask => 'मुखौटा';

  @override
  String get glasses_reading => 'पढ़ने का चश्मा';

  @override
  String get outfit_red => 'लाल कमीज';

  @override
  String get outfit_super => 'सुपरहीरो';

  @override
  String get outfit_green => 'हरी हुडी';

  @override
  String get outfit_doctor => 'डॉक्टर कोट';

  @override
  String get outfit_space => 'अंतरिक्ष सूट';

  @override
  String get outfit_sports => 'जर्सी';

  @override
  String get outfit_police => 'पुलिस वर्दी';

  @override
  String get outfit_chef => 'बावर्ची एप्रन';

  @override
  String get outfit_winter => 'सर्दी का कोट';

  @override
  String get outfit_tuxedo => 'टक्सीडो';

  @override
  String get badgesTitle => 'मेरे बैज';

  @override
  String get totalBadges => 'कुल:';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterEarned => 'अर्जित';

  @override
  String get filterLocked => 'बंद';

  @override
  String get numbersTitle => 'संख्या सीखें';

  @override
  String get lettersTitle => 'अक्षर सीखें';

  @override
  String get shapesTitle => 'आकृतियाँ सीखें';

  @override
  String get colorsTitle => 'रंग सीखें';

  @override
  String get badgeColorMasterName => 'रंग विशेषज्ञ';

  @override
  String get badgeColorMasterDesc => 'आपने 50 रंग राउंड पूरे किए!';

  @override
  String get noBadgesFound => 'No badges found';
}
