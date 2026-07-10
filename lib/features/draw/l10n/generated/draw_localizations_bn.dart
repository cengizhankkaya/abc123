// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class DrawLocalizationsBn extends DrawLocalizations {
  DrawLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return '$number নম্বরটি আঁকুন';
  }

  @override
  String get drawAnyNumberInstruction => 'একটি নম্বর আঁকুন';

  @override
  String get watchAdToUnlock => 'এই অংশটি আনলক করতে বিজ্ঞাপন দেখুন এবং পয়েন্ট অর্জন করুন';

  @override
  String get drawSequentialMode => 'ক্রমিক আঁকার মোড:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'সঠিক: $correct / মোট: $total';
  }

  @override
  String get drawClear => 'পরিষ্কার করুন';

  @override
  String get drawPen => 'কলম';

  @override
  String get drawEraser => 'রাবার';

  @override
  String get drawRecognize => 'সনাক্ত করুন';

  @override
  String get drawPenColor => 'কলমের রং';

  @override
  String get drawNumberSectionTitle => 'সংখ্যা শিখুন';

  @override
  String get drawLetterSectionTitle => 'অক্ষর শিখুন';

  @override
  String get drawShapeSectionTitle => 'আকৃতি শিখুন';

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
