// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DrawLocalizationsEn extends DrawLocalizations {
  DrawLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return 'Draw the number $number';
  }

  @override
  String get drawAnyNumberInstruction => 'Draw a number';

  @override
  String get watchAdToUnlock => 'Watch ads to earn points and unlock this section';

  @override
  String get drawSequentialMode => 'Sequential Drawing Mode:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Correct: $correct / Total: $total';
  }

  @override
  String get drawClear => 'Clear';

  @override
  String get drawPen => 'Pen';

  @override
  String get drawEraser => 'Eraser';

  @override
  String get drawRecognize => 'Recognize';

  @override
  String get drawPenColor => 'Pen Color';

  @override
  String get drawNumberSectionTitle => 'Learn Numbers';

  @override
  String get drawLetterSectionTitle => 'Learn Letters';

  @override
  String get drawShapeSectionTitle => 'Learn Shapes';

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

  @override
  String get drawAdLabel => 'Ad';

  @override
  String get drawPredictionResult => 'Prediction Result:';

  @override
  String get drawRedraw => 'Redraw';

  @override
  String get drawIdentifying => 'Identifying...';

  @override
  String get drawCongratulations => 'Congratulations!';

  @override
  String get drawAllBalloonsPopped => 'You popped all the balloons!';

  @override
  String get drawBalloonsPreparing => 'Balloons preparing...';

  @override
  String get drawNoBalloonsYet => 'No balloons yet. Start drawing!';

  @override
  String get drawStartBalloonGameByDrawing => 'Draw to start!';

  @override
  String get drawScore => 'Score:';

  @override
  String get drawBalloonCount => 'Balloons:';

  @override
  String get drawLevel => 'Level:';

  @override
  String get drawTimeLeft => 'Time Left:';
}
