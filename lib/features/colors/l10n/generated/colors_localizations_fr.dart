// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class ColorsLocalizationsFr extends ColorsLocalizations {
  ColorsLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get colorGameTitle => 'Couleurs';

  @override
  String get colorGameInstruction => 'Lis le mot, puis touche la bonne couleur en dessous.';

  @override
  String get colorNameRed => 'Rouge';

  @override
  String get colorNameBlue => 'Bleu';

  @override
  String get colorNameGreen => 'Vert';

  @override
  String get colorNameYellow => 'Jaune';

  @override
  String get colorNameOrange => 'Orange';

  @override
  String get colorNamePurple => 'Violet';

  @override
  String get colorNamePink => 'Rose';

  @override
  String get colorNameCyan => 'Cyan';

  @override
  String get colorNameBrown => 'Marron';

  @override
  String get colorNameLime => 'Citron vert';

  @override
  String get colorNameTeal => 'Sarcelle';

  @override
  String get colorNameIndigo => 'Indigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Bleu marine';

  @override
  String get colorNameCoral => 'Corail';

  @override
  String get colorNameGold => 'Or';

  @override
  String get colorNameViolet => 'Lilas';

  @override
  String get colorNameSky => 'Bleu ciel';

  @override
  String get colorChapterTitleBasics => 'Chapitre 1 · Premières couleurs';

  @override
  String get colorChapterTitleWide => 'Chapitre 2 · Plus de couleurs';

  @override
  String get colorChapterTitleMaster => 'Chapitre 3 · Maître des couleurs';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Chapitre $current sur $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Niveau $current sur $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Nouveau chapitre !';

  @override
  String get colorGameNextChapterBody => 'De nouvelles couleurs t\'attendent.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Niveau $current sur $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done sur $need corrects';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => 'Temps écoulé !';

  @override
  String get colorGameNextStageTitle => 'Bravo !';

  @override
  String get colorGameNextStageBody => 'Prêt pour le niveau suivant ?';

  @override
  String get colorGameContinue => 'Continuer';

  @override
  String get colorGameVictoryTitle => 'Incroyable !';

  @override
  String get colorGameVictoryBody => 'Tu as terminé tous les chapitres !';

  @override
  String get colorGamePlayAgain => 'Rejouer';

  @override
  String get colorGameBack => 'Retour';

  @override
  String get colorFeedbackCorrect => 'Bravo !';

  @override
  String get colorFeedbackWrong => 'Réessaie';

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
  String get colorVisionResultsMixed =>
      'Some plates were tricky. That happens to many kids.';

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
