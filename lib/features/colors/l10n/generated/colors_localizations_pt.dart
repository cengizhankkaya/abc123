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
  String get colorVisionHomeTitle => 'Formas de cor';

  @override
  String get colorVisionHomeSubtitle => 'Scan divertido';

  @override
  String get colorVisionIntroDisclaimer =>
      'As imagens de pontos ajudam a descobrir como você vê as cores. Este não é um teste médico.';

  @override
  String get colorVisionStart => 'Vamos jogar';

  @override
  String get colorVisionQuestion => 'Qual forma você vê entre os pontos?';

  @override
  String get colorVisionOptionCircle => 'Círculo';

  @override
  String get colorVisionOptionSquare => 'Quadrado';

  @override
  String get colorVisionOptionTriangle => 'Triângulo';

  @override
  String get colorVisionOptionNothing => 'Nenhuma forma';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Placa $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total corretas';
  }

  @override
  String get colorVisionResultsTitle => 'Rodada terminada!';

  @override
  String get colorVisionResultsGood => 'Você encontrou a maioria das formas — ótimo!';

  @override
  String get colorVisionResultsMixed => 'Algumas placas foram difíceis; isso é comum.';

  @override
  String get colorVisionResultsLow =>
      'Muitas formas foram difíceis de ver. Este jogo não diagnostica daltonismo.';

  @override
  String get colorVisionResultsMedicalNote => 'Apenas para aprendizado e curiosidade.';

  @override
  String get colorVisionPlayAgain => 'Jogar novamente';

  @override
  String get colorVisionIntroTitle => 'Formas ocultas';

  @override
  String get colorVisionPlateBadgeRg => 'Vermelho · Verde';

  @override
  String get colorVisionPlateBadgeBy => 'Azul · Amarelo';

  @override
  String get colorVisionOptionDiamond => 'Diamante';

  @override
  String get colorVisionResultHintTitle => 'Resumo divertido';

  @override
  String get colorVisionProfileTypical => 'Suas respostas parecem se alinhar com a visão típica.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'Você errou mais as placas de estilo vermelho-verde.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'Você errou mais as placas de estilo azul-amarelo.';

  @override
  String get colorVisionProfileMixed =>
      'Ambos os tipos foram difíceis. Tente novamente com boa luz.';

  @override
  String get colorVisionProfileInconclusive => 'Nenhum padrão claro.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Vermelho-verde: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Azul-amarelo: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Falha ao carregar o jogo.';

  @override
  String get colorFailurePalette => 'Não foi possível obter a paleta.';

  @override
  String get colorFailureUnknown => 'Ocorreu um erro.';
}
