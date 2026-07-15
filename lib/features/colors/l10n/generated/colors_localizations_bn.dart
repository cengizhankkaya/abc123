// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class ColorsLocalizationsBn extends ColorsLocalizations {
  ColorsLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get colorGameTitle => 'রং';

  @override
  String get colorGameInstruction => 'শব্দটি পড়ো, তারপর নিচে মিলিয়ে ঠিক রঙে ট্যাপ করো।';

  @override
  String get colorNameRed => 'লাল';

  @override
  String get colorNameBlue => 'নীল';

  @override
  String get colorNameGreen => 'সবুজ';

  @override
  String get colorNameYellow => 'হলুদ';

  @override
  String get colorNameOrange => 'কমলা';

  @override
  String get colorNamePurple => 'বেগুনি';

  @override
  String get colorNamePink => 'গোলাপি';

  @override
  String get colorNameCyan => 'সায়ান';

  @override
  String get colorNameBrown => 'বাদামি';

  @override
  String get colorNameLime => 'লেবু সবুজ';

  @override
  String get colorNameTeal => 'টিল';

  @override
  String get colorNameIndigo => 'ইন্ডিগো';

  @override
  String get colorNameMagenta => 'ম্যাজেন্টা';

  @override
  String get colorNameNavy => 'নেভি';

  @override
  String get colorNameCoral => 'কোরাল';

  @override
  String get colorNameGold => 'সোনালি';

  @override
  String get colorNameViolet => 'ভায়োলেট';

  @override
  String get colorNameSky => 'আকাশি নীল';

  @override
  String get colorChapterTitleBasics => 'অধ্যায় ১ · প্রথম রং';

  @override
  String get colorChapterTitleWide => 'অধ্যায় ২ · আরও রং';

  @override
  String get colorChapterTitleMaster => 'অধ্যায় ৩ · রঙের মাস্টার';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'অধ্যায় $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'লেভেল $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'নতুন অধ্যায়!';

  @override
  String get colorGameNextChapterBody => 'নতুন রং অপেক্ষায়।';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'ধাপ $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need সঠিক';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds সে';
  }

  @override
  String get colorGameTimeUp => 'সময় শেষ!';

  @override
  String get colorGameNextStageTitle => 'দারুণ!';

  @override
  String get colorGameNextStageBody => 'পরের লেভেলের জন্য প্রস্তুত?';

  @override
  String get colorGameContinue => 'চালিয়ে যাও';

  @override
  String get colorGameVictoryTitle => 'চমৎকার!';

  @override
  String get colorGameVictoryBody => 'সব অধ্যায় শেষ!';

  @override
  String get colorGamePlayAgain => 'আবার খেলো';

  @override
  String get colorGameBack => 'ফিরে যাও';

  @override
  String get colorFeedbackCorrect => 'দারুণ!';

  @override
  String get colorFeedbackWrong => 'আবার চেষ্টা করো';

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
