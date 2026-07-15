// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ColorsLocalizationsAr extends ColorsLocalizations {
  ColorsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get colorGameTitle => 'الألوان';

  @override
  String get colorGameInstruction => 'اقرأ الكلمة ثم المس اللون الصحيح في الأسفل.';

  @override
  String get colorNameRed => 'أحمر';

  @override
  String get colorNameBlue => 'أزرق';

  @override
  String get colorNameGreen => 'أخضر';

  @override
  String get colorNameYellow => 'أصفر';

  @override
  String get colorNameOrange => 'برتقالي';

  @override
  String get colorNamePurple => 'بنفسجي';

  @override
  String get colorNamePink => 'وردي';

  @override
  String get colorNameCyan => 'سماوي';

  @override
  String get colorNameBrown => 'بني';

  @override
  String get colorNameLime => 'ليموني';

  @override
  String get colorNameTeal => 'تركوازي';

  @override
  String get colorNameIndigo => 'نيلي';

  @override
  String get colorNameMagenta => 'أرجواني';

  @override
  String get colorNameNavy => 'كحلي';

  @override
  String get colorNameCoral => 'مرجاني';

  @override
  String get colorNameGold => 'ذهبي';

  @override
  String get colorNameViolet => 'بنفسجي فاتح';

  @override
  String get colorNameSky => 'أزرق سماوي';

  @override
  String get colorChapterTitleBasics => 'الفصل 1 · الألوان الأولى';

  @override
  String get colorChapterTitleWide => 'الفصل 2 · المزيد من الألوان';

  @override
  String get colorChapterTitleMaster => 'الفصل 3 · سيد الألوان';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'الفصل $current من $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'المستوى $current من $total';
  }

  @override
  String get colorGameNextChapterTitle => 'فصل جديد!';

  @override
  String get colorGameNextChapterBody => 'ألوان جديدة في انتظارك.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'المرحلة $current من $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done من $need صحيح';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds ث';
  }

  @override
  String get colorGameTimeUp => 'انتهى الوقت!';

  @override
  String get colorGameNextStageTitle => 'رائع!';

  @override
  String get colorGameNextStageBody => 'هل أنت مستعد للمستوى التالي؟';

  @override
  String get colorGameContinue => 'متابعة';

  @override
  String get colorGameVictoryTitle => 'مذهل!';

  @override
  String get colorGameVictoryBody => 'أكملت كل الفصول!';

  @override
  String get colorGamePlayAgain => 'العب مجددًا';

  @override
  String get colorGameBack => 'رجوع';

  @override
  String get colorFeedbackCorrect => 'رائع!';

  @override
  String get colorFeedbackWrong => 'حاول مرة أخرى';

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
