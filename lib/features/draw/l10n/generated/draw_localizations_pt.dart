// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class DrawLocalizationsPt extends DrawLocalizations {
  DrawLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return 'Desenhe o número $number';
  }

  @override
  String get drawAnyNumberInstruction => 'Desenhe um número';

  @override
  String get watchAdToUnlock => 'Assista anúncios para ganhar pontos e desbloquear esta seção';

  @override
  String get drawSequentialMode => 'Modo de desenho sequencial:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Correto: $correct / Total: $total';
  }

  @override
  String get drawClear => 'Limpar';

  @override
  String get drawPen => 'Caneta';

  @override
  String get drawEraser => 'Borracha';

  @override
  String get drawRecognize => 'Reconhecer';

  @override
  String get drawPenColor => 'Cor da caneta';

  @override
  String get drawNumberSectionTitle => 'Aprender números';

  @override
  String get drawLetterSectionTitle => 'Aprender letras';

  @override
  String get drawShapeSectionTitle => 'Aprender formas';

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
