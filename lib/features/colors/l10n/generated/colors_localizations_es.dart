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
  String get colorFailureLoad => 'El juego no se pudo cargar. Por favor, inténtalo de nuevo.';

  @override
  String get colorFailurePalette => 'No se pudo obtener la paleta de colores.';

  @override
  String get colorFailureUnknown => 'Ocurrió un error inesperado.';
}
