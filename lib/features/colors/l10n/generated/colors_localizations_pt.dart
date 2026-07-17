// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class ColorsLocalizationsPt extends ColorsLocalizations {
  ColorsLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get colorGameTitle => 'Cores';

  @override
  String get colorGameInstruction => 'Lê a palavra e toca na cor certa em baixo.';

  @override
  String get colorNameRed => 'Vermelho';

  @override
  String get colorNameBlue => 'Azul';

  @override
  String get colorNameGreen => 'Verde';

  @override
  String get colorNameYellow => 'Amarelo';

  @override
  String get colorNameOrange => 'Laranja';

  @override
  String get colorNamePurple => 'Roxo';

  @override
  String get colorNamePink => 'Rosa';

  @override
  String get colorNameCyan => 'Ciano';

  @override
  String get colorNameBrown => 'Marrom';

  @override
  String get colorNameLime => 'Lima';

  @override
  String get colorNameTeal => 'Verde-azulado';

  @override
  String get colorNameIndigo => 'Índigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Azul-marinho';

  @override
  String get colorNameCoral => 'Coral';

  @override
  String get colorNameGold => 'Dourado';

  @override
  String get colorNameViolet => 'Violeta';

  @override
  String get colorNameSky => 'Azul céu';

  @override
  String get colorChapterTitleBasics => 'Capítulo 1 · Primeiras cores';

  @override
  String get colorChapterTitleWide => 'Capítulo 2 · Mais cores';

  @override
  String get colorChapterTitleMaster => 'Capítulo 3 · Mestre das cores';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Capítulo $current de $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Nível $current de $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Novo capítulo!';

  @override
  String get colorGameNextChapterBody => 'Novas cores te esperam.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Fase $current de $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done de $need corretos';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => 'Acabou o tempo!';

  @override
  String get colorGameNextStageTitle => 'Muito bem!';

  @override
  String get colorGameNextStageBody => 'Pronto para o próximo nível?';

  @override
  String get colorGameContinue => 'Continuar';

  @override
  String get colorGameVictoryTitle => 'Incrível!';

  @override
  String get colorGameVictoryBody => 'Completaste todos os capítulos!';

  @override
  String get colorGamePlayAgain => 'Jogar de novo';

  @override
  String get colorGameBack => 'Voltar';

  @override
  String get colorFeedbackCorrect => 'Muito bem!';

  @override
  String get colorFeedbackWrong => 'Tenta outra vez';

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
  String get colorFailureLoad => 'O jogo não pôde ser carregado. Por favor, tente novamente.';

  @override
  String get colorFailurePalette => 'Não foi possível obter a paleta de cores.';

  @override
  String get colorFailureUnknown => 'Ocorreu um erro inesperado.';
}
