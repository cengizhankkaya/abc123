// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ColorsLocalizationsEn extends ColorsLocalizations {
  ColorsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get colorGameTitle => 'Colors';

  @override
  String get colorGameInstruction => 'Read the word, then tap the matching color below.';

  @override
  String get colorNameRed => 'Red';

  @override
  String get colorNameBlue => 'Blue';

  @override
  String get colorNameGreen => 'Green';

  @override
  String get colorNameYellow => 'Yellow';

  @override
  String get colorNameOrange => 'Orange';

  @override
  String get colorNamePurple => 'Purple';

  @override
  String get colorNamePink => 'Pink';

  @override
  String get colorNameCyan => 'Cyan';

  @override
  String get colorNameBrown => 'Brown';

  @override
  String get colorNameLime => 'Lime';

  @override
  String get colorNameTeal => 'Teal';

  @override
  String get colorNameIndigo => 'Indigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Navy';

  @override
  String get colorNameCoral => 'Coral';

  @override
  String get colorNameGold => 'Gold';

  @override
  String get colorNameViolet => 'Violet';

  @override
  String get colorNameSky => 'Sky blue';

  @override
  String get colorChapterTitleBasics => 'Chapter 1 · First colors';

  @override
  String get colorChapterTitleWide => 'Chapter 2 · Bigger palette';

  @override
  String get colorChapterTitleMaster => 'Chapter 3 · Color master';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Chapter $current of $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Level $current of $total';
  }

  @override
  String get colorGameNextChapterTitle => 'New chapter!';

  @override
  String get colorGameNextChapterBody => 'A new set of colors is waiting for you.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Stage $current of $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done of $need correct';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => 'Time\'s up!';

  @override
  String get colorGameNextStageTitle => 'Great job!';

  @override
  String get colorGameNextStageBody => 'Ready for the next level?';

  @override
  String get colorGameContinue => 'Continue';

  @override
  String get colorGameVictoryTitle => 'Amazing!';

  @override
  String get colorGameVictoryBody => 'You finished every chapter!';

  @override
  String get colorGamePlayAgain => 'Play again';

  @override
  String get colorGameBack => 'Back';

  @override
  String get colorFeedbackCorrect => 'Nice!';

  @override
  String get colorFeedbackWrong => 'Try again';

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
