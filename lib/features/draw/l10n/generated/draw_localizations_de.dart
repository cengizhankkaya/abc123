// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class DrawLocalizationsDe extends DrawLocalizations {
  DrawLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return 'Zeichne die Zahl $number';
  }

  @override
  String get drawAnyNumberInstruction => 'Zeichne eine Zahl';

  @override
  String get watchAdToUnlock =>
      'Sieh dir Werbung an, um Punkte zu sammeln und diesen Bereich freizuschalten';

  @override
  String get drawSequentialMode => 'Sequenzieller Zeichenmodus:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Richtig: $correct / Gesamt: $total';
  }

  @override
  String get drawClear => 'Löschen';

  @override
  String get drawPen => 'Stift';

  @override
  String get drawEraser => 'Radiergummi';

  @override
  String get drawRecognize => 'Erkennen';

  @override
  String get drawPenColor => 'Stiftfarbe';

  @override
  String get drawNumberSectionTitle => 'Zahlen lernen';

  @override
  String get drawLetterSectionTitle => 'Buchstaben lernen';

  @override
  String get drawShapeSectionTitle => 'Formen lernen';

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
