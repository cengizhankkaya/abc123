// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class ColorsLocalizationsEs extends ColorsLocalizations {
  ColorsLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get colorGameTitle => 'Colores';

  @override
  String get colorGameInstruction => 'Lee la palabra y toca el color correcto abajo.';

  @override
  String get colorNameRed => 'Rojo';

  @override
  String get colorNameBlue => 'Azul';

  @override
  String get colorNameGreen => 'Verde';

  @override
  String get colorNameYellow => 'Amarillo';

  @override
  String get colorNameOrange => 'Naranja';

  @override
  String get colorNamePurple => 'Morado';

  @override
  String get colorNamePink => 'Rosa';

  @override
  String get colorNameCyan => 'Cian';

  @override
  String get colorNameBrown => 'Marrón';

  @override
  String get colorNameLime => 'Lima';

  @override
  String get colorNameTeal => 'Verde azulado';

  @override
  String get colorNameIndigo => 'Índigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Azul marino';

  @override
  String get colorNameCoral => 'Coral';

  @override
  String get colorNameGold => 'Dorado';

  @override
  String get colorNameViolet => 'Violeta';

  @override
  String get colorNameSky => 'Celeste';

  @override
  String get colorChapterTitleBasics => 'Capítulo 1 · Primeros colores';

  @override
  String get colorChapterTitleWide => 'Capítulo 2 · Más colores';

  @override
  String get colorChapterTitleMaster => 'Capítulo 3 · Maestro del color';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Capítulo $current de $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Nivel $current de $total';
  }

  @override
  String get colorGameNextChapterTitle => '¡Nuevo capítulo!';

  @override
  String get colorGameNextChapterBody => 'Te esperan colores nuevos.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Etapa $current de $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done de $need correctos';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => '¡Se acabó el tiempo!';

  @override
  String get colorGameNextStageTitle => '¡Genial!';

  @override
  String get colorGameNextStageBody => '¿Listo para el siguiente nivel?';

  @override
  String get colorGameContinue => 'Continuar';

  @override
  String get colorGameVictoryTitle => '¡Increíble!';

  @override
  String get colorGameVictoryBody => '¡Completaste todos los capítulos!';

  @override
  String get colorGamePlayAgain => 'Jugar otra vez';

  @override
  String get colorGameBack => 'Volver';

  @override
  String get colorFeedbackCorrect => '¡Genial!';

  @override
  String get colorFeedbackWrong => 'Inténtalo otra vez';

  @override
  String get colorVisionHomeTitle => 'Formas de color';

  @override
  String get colorVisionHomeSubtitle => 'Escaneo divertido';

  @override
  String get colorVisionIntroDisclaimer =>
      'Las imágenes de puntos ayudan a descubrir cómo ves los colores. Esto no es una prueba médica.';

  @override
  String get colorVisionStart => 'Vamos a jugar';

  @override
  String get colorVisionQuestion => '¿Qué forma ves entre los puntos?';

  @override
  String get colorVisionOptionCircle => 'Círculo';

  @override
  String get colorVisionOptionSquare => 'Cuadrado';

  @override
  String get colorVisionOptionTriangle => 'Triángulo';

  @override
  String get colorVisionOptionNothing => 'Ninguna';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Placa $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total correctas';
  }

  @override
  String get colorVisionResultsTitle => '¡Ronda terminada!';

  @override
  String get colorVisionResultsGood => 'Encontraste la mayoría de las formas — ¡genial!';

  @override
  String get colorVisionResultsMixed => 'Algunas placas fueron difíciles; esto es común en niños.';

  @override
  String get colorVisionResultsLow =>
      'Muchas formas fueron difíciles de ver. Este juego no diagnostica daltonismo.';

  @override
  String get colorVisionResultsMedicalNote => 'Solo para aprendizaje y curiosidad.';

  @override
  String get colorVisionPlayAgain => 'Jugar de nuevo';

  @override
  String get colorVisionIntroTitle => 'Formas ocultas';

  @override
  String get colorVisionPlateBadgeRg => 'Rojo · Verde';

  @override
  String get colorVisionPlateBadgeBy => 'Azul · Amarillo';

  @override
  String get colorVisionOptionDiamond => 'Diamante';

  @override
  String get colorVisionResultHintTitle => 'Resumen';

  @override
  String get colorVisionProfileTypical =>
      'Tus respuestas parecen alinearse con la visión típica de colores.';

  @override
  String get colorVisionProfileRedGreenAxis => 'Fallaste más en las placas de estilo rojo-verde.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'Fallaste más en las placas de estilo azul-amarillo.';

  @override
  String get colorVisionProfileMixed =>
      'Ambos tipos de placas fueron difíciles. Inténtalo de nuevo con buena luz.';

  @override
  String get colorVisionProfileInconclusive => 'No hay un patrón claro. Inténtalo de nuevo.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Rojo-verde: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Azul-amarillo: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'No se pudo cargar el juego.';

  @override
  String get colorFailurePalette => 'No se pudo obtener la paleta.';

  @override
  String get colorFailureUnknown => 'Ocurrió un error inesperado.';
}
