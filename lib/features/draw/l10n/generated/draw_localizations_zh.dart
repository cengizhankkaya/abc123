// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class DrawLocalizationsZh extends DrawLocalizations {
  DrawLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return '$number 数字を描いてください';
  }

  @override
  String get drawAnyNumberInstruction => '任意数字を描いてください';

  @override
  String get watchAdToUnlock => '观看广告赚取积分以解锁此部分';

  @override
  String get drawSequentialMode => '顺序绘画模式：';

  @override
  String drawCorrectTotal(int correct, int total) {
    return '正确: $correct / 总数: $total';
  }

  @override
  String get drawClear => '清除';

  @override
  String get drawPen => '笔';

  @override
  String get drawEraser => '橡皮擦';

  @override
  String get drawRecognize => '识别';

  @override
  String get drawPenColor => '笔的颜色';

  @override
  String get drawNumberSectionTitle => '学习数字';

  @override
  String get drawLetterSectionTitle => '学习字母';

  @override
  String get drawShapeSectionTitle => '学习形状';

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
