// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class DrawLocalizationsRu extends DrawLocalizations {
  DrawLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return 'Нарисуйте цифру $number';
  }

  @override
  String get drawAnyNumberInstruction => 'Нарисуйте любую цифру';

  @override
  String get watchAdToUnlock => 'Смотрите рекламу, чтобы заработать очки и открыть этот раздел';

  @override
  String get drawSequentialMode => 'Режим последовательного рисования:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Правильно: $correct / Всего: $total';
  }

  @override
  String get drawClear => 'Очистить';

  @override
  String get drawPen => 'Ручка';

  @override
  String get drawEraser => 'Ластик';

  @override
  String get drawRecognize => 'Распознать';

  @override
  String get drawPenColor => 'Цвет ручки';

  @override
  String get drawNumberSectionTitle => 'Изучать числа';

  @override
  String get drawLetterSectionTitle => 'Изучать буквы';

  @override
  String get drawShapeSectionTitle => 'Изучать фигуры';

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
