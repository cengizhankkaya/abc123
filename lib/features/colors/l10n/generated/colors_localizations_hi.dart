// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class ColorsLocalizationsHi extends ColorsLocalizations {
  ColorsLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get colorGameTitle => 'रंग';

  @override
  String get colorGameInstruction => 'शब्द पढ़ो, फिर नीचे सही रंग पर टैप करो।';

  @override
  String get colorNameRed => 'लाल';

  @override
  String get colorNameBlue => 'नीला';

  @override
  String get colorNameGreen => 'हरा';

  @override
  String get colorNameYellow => 'पीला';

  @override
  String get colorNameOrange => 'नारंगी';

  @override
  String get colorNamePurple => 'बैंगनी';

  @override
  String get colorNamePink => 'गुलाबी';

  @override
  String get colorNameCyan => 'सियान';

  @override
  String get colorNameBrown => 'भूरा';

  @override
  String get colorNameLime => 'नींबू हरा';

  @override
  String get colorNameTeal => 'टील';

  @override
  String get colorNameIndigo => 'इंडिगो';

  @override
  String get colorNameMagenta => 'मैजेंटा';

  @override
  String get colorNameNavy => 'नेवी';

  @override
  String get colorNameCoral => 'कोरल';

  @override
  String get colorNameGold => 'सुनहरा';

  @override
  String get colorNameViolet => 'वायलेट';

  @override
  String get colorNameSky => 'आसमानी';

  @override
  String get colorChapterTitleBasics => 'अध्याय 1 · पहले रंग';

  @override
  String get colorChapterTitleWide => 'अध्याय 2 · और रंग';

  @override
  String get colorChapterTitleMaster => 'अध्याय 3 · रंग मास्टर';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'अध्याय $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'स्तर $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'नया अध्याय!';

  @override
  String get colorGameNextChapterBody => 'नए रंग इंतज़ार में हैं।';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'चरण $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need सही';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds से';
  }

  @override
  String get colorGameTimeUp => 'समय खत्म!';

  @override
  String get colorGameNextStageTitle => 'शाबाश!';

  @override
  String get colorGameNextStageBody => 'अगले स्तर के लिए तैयार?';

  @override
  String get colorGameContinue => 'आगे';

  @override
  String get colorGameVictoryTitle => 'कमाल!';

  @override
  String get colorGameVictoryBody => 'सभी अध्याय पूरे!';

  @override
  String get colorGamePlayAgain => 'फिर खेलें';

  @override
  String get colorGameBack => 'वापस';

  @override
  String get colorFeedbackCorrect => 'शाबाश!';

  @override
  String get colorFeedbackWrong => 'फिर कोशिश करो';

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

  @override
  String get colorFailureLoad => 'खेल लोड नहीं किया जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get colorFailurePalette => 'रंग पैलेट प्राप्त नहीं किया जा सका।';

  @override
  String get colorFailureUnknown => 'एक अप्रत्याशित त्रुटि हुई।';
}
