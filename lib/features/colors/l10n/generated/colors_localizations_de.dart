// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class ColorsLocalizationsDe extends ColorsLocalizations {
  ColorsLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get colorGameTitle => 'Farben';

  @override
  String get colorGameInstruction => 'Lies das Wort und tippe dann unten auf die passende Farbe.';

  @override
  String get colorNameRed => 'Rot';

  @override
  String get colorNameBlue => 'Blau';

  @override
  String get colorNameGreen => 'Grün';

  @override
  String get colorNameYellow => 'Gelb';

  @override
  String get colorNameOrange => 'Orange';

  @override
  String get colorNamePurple => 'Lila';

  @override
  String get colorNamePink => 'Rosa';

  @override
  String get colorNameCyan => 'Cyan';

  @override
  String get colorNameBrown => 'Braun';

  @override
  String get colorNameLime => 'Limette';

  @override
  String get colorNameTeal => 'Petrol';

  @override
  String get colorNameIndigo => 'Indigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Marineblau';

  @override
  String get colorNameCoral => 'Koralle';

  @override
  String get colorNameGold => 'Goldgelb';

  @override
  String get colorNameViolet => 'Violett';

  @override
  String get colorNameSky => 'Himmelblau';

  @override
  String get colorChapterTitleBasics => 'Kapitel 1 · Erste Farben';

  @override
  String get colorChapterTitleWide => 'Kapitel 2 · Mehr Farben';

  @override
  String get colorChapterTitleMaster => 'Kapitel 3 · Farben-Profi';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Kapitel $current von $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Level $current von $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Neues Kapitel!';

  @override
  String get colorGameNextChapterBody => 'Neue Farben warten auf dich.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Stufe $current von $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done von $need richtig';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => 'Zeit ist um!';

  @override
  String get colorGameNextStageTitle => 'Super!';

  @override
  String get colorGameNextStageBody => 'Bereit für das nächste Level?';

  @override
  String get colorGameContinue => 'Weiter';

  @override
  String get colorGameVictoryTitle => 'Fantastisch!';

  @override
  String get colorGameVictoryBody => 'Du hast alle Kapitel geschafft!';

  @override
  String get colorGamePlayAgain => 'Nochmal spielen';

  @override
  String get colorGameBack => 'Zurück';

  @override
  String get colorFeedbackCorrect => 'Super!';

  @override
  String get colorFeedbackWrong => 'Nochmal';

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
  String get colorFailureLoad =>
      'Spiel konnte nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get colorFailurePalette => 'Farbpalette konnte nicht abgerufen werden.';

  @override
  String get colorFailureUnknown => 'Ein unerwarteter Fehler ist aufgetreten.';
}
