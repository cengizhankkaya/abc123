// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class DrawLocalizationsEs extends DrawLocalizations {
  DrawLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return 'Dibuja el número $number';
  }

  @override
  String get drawAnyNumberInstruction => 'Dibuja un número';

  @override
  String get watchAdToUnlock => 'Mira anuncios para ganar puntos y desbloquear esta sección';

  @override
  String get drawSequentialMode => 'Modo de dibujo secuencial:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Correcto: $correct / Total: $total';
  }

  @override
  String get drawClear => 'Limpiar';

  @override
  String get drawPen => 'Bolígrafo';

  @override
  String get drawEraser => 'Borrador';

  @override
  String get drawRecognize => 'Reconocer';

  @override
  String get drawPenColor => 'Color del bolígrafo';

  @override
  String get drawNumberSectionTitle => 'Aprender números';

  @override
  String get drawLetterSectionTitle => 'Aprender letras';

  @override
  String get drawShapeSectionTitle => 'Aprender figuras';

  @override
  String get drawWordSectionTitle => 'Build Words';

  @override
  String get drawLetterPuzzlePreparing => 'Preparing puzzle…';

  @override
  String get drawGamePausedTitle => 'GAME PAUSED';

  @override
  String get drawContinue => 'Continue';

  @override
  String get drawStartGame => 'START GAME';

  @override
  String drawBalloonReady(int count) {
    return 'Ready to play with $count balloons?';
  }

  @override
  String get drawBalloonScoreHint =>
      'Pop balloons to earn points!\nThe smaller the balloon, the more points you get.';

  @override
  String get drawSemanticMute => 'Mute sounds';

  @override
  String get drawSemanticUnmute => 'Unmute sounds';

  @override
  String get drawSemanticDrawingCanvas => 'Drawing area. Draw with your finger.';

  @override
  String get drawSemanticPauseGame => 'Pause game';

  @override
  String get drawSemanticResumeGame => 'Resume game';

  @override
  String get drawSemanticPenColorBlack => 'Black pen color';

  @override
  String get drawSemanticPenColorRed => 'Red pen color';

  @override
  String get drawSemanticPenColorBlue => 'Blue pen color';

  @override
  String get drawSemanticPenColorYellow => 'Yellow pen color';

  @override
  String get drawSemanticPenColorGreen => 'Green pen color';

  @override
  String get drawSemanticPenColorPurple => 'Purple pen color';

  @override
  String get drawSemanticPenColorOrange => 'Orange pen color';
}
