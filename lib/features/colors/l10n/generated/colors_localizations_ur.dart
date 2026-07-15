// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class ColorsLocalizationsUr extends ColorsLocalizations {
  ColorsLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get colorGameTitle => 'رنگ';

  @override
  String get colorGameInstruction => 'لفظ پڑھو، پھر نیچے صحیح رنگ پر تھپتھپاؤ۔';

  @override
  String get colorNameRed => 'سرخ';

  @override
  String get colorNameBlue => 'نیلا';

  @override
  String get colorNameGreen => 'سبز';

  @override
  String get colorNameYellow => 'پیلا';

  @override
  String get colorNameOrange => 'نارنجی';

  @override
  String get colorNamePurple => 'جامنی';

  @override
  String get colorNamePink => 'گلابی';

  @override
  String get colorNameCyan => 'فیروزی';

  @override
  String get colorNameBrown => 'بھورا';

  @override
  String get colorNameLime => 'لیموں';

  @override
  String get colorNameTeal => 'سمندری';

  @override
  String get colorNameIndigo => 'انڈگو';

  @override
  String get colorNameMagenta => 'میجنٹا';

  @override
  String get colorNameNavy => 'نیوی';

  @override
  String get colorNameCoral => 'مرجان';

  @override
  String get colorNameGold => 'سنہرا';

  @override
  String get colorNameViolet => 'بنفشی';

  @override
  String get colorNameSky => 'آسمانی';

  @override
  String get colorChapterTitleBasics => 'باب 1 · پہلے رنگ';

  @override
  String get colorChapterTitleWide => 'باب 2 · مزید رنگ';

  @override
  String get colorChapterTitleMaster => 'باب 3 · رنگ کا استاد';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'باب $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'مرحلہ $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'نیا باب!';

  @override
  String get colorGameNextChapterBody => 'نئے رنگ منتظر ہیں۔';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'مرحلہ $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need درست';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds س';
  }

  @override
  String get colorGameTimeUp => 'وقت ختم!';

  @override
  String get colorGameNextStageTitle => 'بہترین!';

  @override
  String get colorGameNextStageBody => 'اگلے مرحلے کے لیے تیار؟';

  @override
  String get colorGameContinue => 'جاری رکھیں';

  @override
  String get colorGameVictoryTitle => 'زبردست!';

  @override
  String get colorGameVictoryBody => 'تمام باب مکمل!';

  @override
  String get colorGamePlayAgain => 'دوبارہ کھیلیں';

  @override
  String get colorGameBack => 'واپس';

  @override
  String get colorFeedbackCorrect => 'بہترین!';

  @override
  String get colorFeedbackWrong => 'دوبارہ کوشش کرو';

  @override
  String get colorVisionHomeTitle => 'Color shapes';

  @override
  String get colorVisionHomeSubtitle => 'Playful screening';

  @override
  String get colorVisionIntroDisclaimer =>
      'Dotted pictures like gentle puzzles help explore how you see colors. This is not a medical test. Ask an eye doctor if you have concerns.';

  @override
  String get colorVisionStart => 'Let\'s play';

  @override
  String get colorVisionQuestion => 'Which shape do you see in the dots?';

  @override
  String get colorVisionOptionCircle => 'Circle';

  @override
  String get colorVisionOptionSquare => 'Square';

  @override
  String get colorVisionOptionTriangle => 'Triangle';

  @override
  String get colorVisionOptionNothing => 'No shape';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Plate $current of $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct of $total matched';
  }

  @override
  String get colorVisionResultsTitle => 'Round complete!';

  @override
  String get colorVisionResultsGood => 'You spotted most shapes — nice!';

  @override
  String get colorVisionResultsMixed => 'Some plates were tricky. That happens to many kids.';

  @override
  String get colorVisionResultsLow =>
      'Many shapes were hard to see. This game cannot diagnose color vision. A specialist can help if you are worried.';

  @override
  String get colorVisionResultsMedicalNote =>
      'For learning and curiosity only. It does not replace professional eye care.';

  @override
  String get colorVisionPlayAgain => 'Play again';

  @override
  String get colorVisionIntroTitle => 'Hidden shapes';

  @override
  String get colorVisionPlateBadgeRg => 'Red · green mix';

  @override
  String get colorVisionPlateBadgeBy => 'Blue · yellow mix';

  @override
  String get colorVisionOptionDiamond => 'Diamond';

  @override
  String get colorVisionResultHintTitle => 'Playful summary';

  @override
  String get colorVisionProfileTypical =>
      'On these plates your answers look similar to typical color vision for kids.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'You missed more red–green style plates. That pattern is often discussed with red–green color blindness (protanopia or deuteranopia family). This app cannot separate those types.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'You missed more blue–yellow style plates. That can sometimes relate to blue–yellow (tritan-type) difficulty — only an eye specialist can say for sure.';

  @override
  String get colorVisionProfileMixed =>
      'Both plate styles were difficult. Screen brightness, night mode, or tired eyes can change scores. Try again in good light.';

  @override
  String get colorVisionProfileInconclusive =>
      'No clear pattern — try again on a bright screen at arm’s length.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Red–green style: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Blue–yellow style: $correct / $total';
  }
}
