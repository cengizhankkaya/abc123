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
  String get colorVisionHomeTitle => 'Formes de couleurs';

  @override
  String get colorVisionHomeSubtitle => 'Scan amusant';

  @override
  String get colorVisionIntroDisclaimer =>
      'Les images à points aident à découvrir comment vous voyez les couleurs. Ce n\'est pas un test médical.';

  @override
  String get colorVisionStart => 'Allons jouer';

  @override
  String get colorVisionQuestion => 'Quelle forme vois-tu parmi les points ?';

  @override
  String get colorVisionOptionCircle => 'Cercle';

  @override
  String get colorVisionOptionSquare => 'Carré';

  @override
  String get colorVisionOptionTriangle => 'Triangle';

  @override
  String get colorVisionOptionNothing => 'Aucune';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Plaque $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total corrects';
  }

  @override
  String get colorVisionResultsTitle => 'Manche terminée !';

  @override
  String get colorVisionResultsGood => 'Tu as trouvé la plupart des formes — super !';

  @override
  String get colorVisionResultsMixed => 'Certaines plaques étaient difficiles; c\'est très commun.';

  @override
  String get colorVisionResultsLow =>
      'Beaucoup de formes étaient difficiles à voir. Ce jeu ne diagnostique pas le daltonisme.';

  @override
  String get colorVisionResultsMedicalNote => 'Uniquement pour l\'apprentissage et la curiosité.';

  @override
  String get colorVisionPlayAgain => 'Rejouer';

  @override
  String get colorVisionIntroTitle => 'Formes cachées';

  @override
  String get colorVisionPlateBadgeRg => 'Rouge · Vert';

  @override
  String get colorVisionPlateBadgeBy => 'Bleu · Jaune';

  @override
  String get colorVisionOptionDiamond => 'Diamant';

  @override
  String get colorVisionResultHintTitle => 'Résumé amusant';

  @override
  String get colorVisionProfileTypical =>
      'Tes réponses semblent alignées avec une vision des couleurs typique.';

  @override
  String get colorVisionProfileRedGreenAxis => 'Tu as manqué plus de plaques de style rouge-vert.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'Tu as manqué plus de plaques de style bleu-jaune.';

  @override
  String get colorVisionProfileMixed =>
      'Les deux types étaient difficiles. Réessaie avec une bonne lumière.';

  @override
  String get colorVisionProfileInconclusive => 'Pas de motif clair — réessaie.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Rouge-vert: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Bleu-jaune: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Impossible de charger le jeu.';

  @override
  String get colorFailurePalette => 'Impossible d\'obtenir la palette.';

  @override
  String get colorFailureUnknown => 'Une erreur s\'est produite.';
}
