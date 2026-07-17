// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ColorsLocalizationsZh extends ColorsLocalizations {
  ColorsLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get colorGameTitle => '颜色';

  @override
  String get colorGameInstruction => '读一读这个词，然后点下面正确的颜色。';

  @override
  String get colorNameRed => '红色';

  @override
  String get colorNameBlue => '蓝色';

  @override
  String get colorNameGreen => '绿色';

  @override
  String get colorNameYellow => '黄色';

  @override
  String get colorNameOrange => '橙色';

  @override
  String get colorNamePurple => '紫色';

  @override
  String get colorNamePink => '粉色';

  @override
  String get colorNameCyan => '青色';

  @override
  String get colorNameBrown => '棕色';

  @override
  String get colorNameLime => '青柠色';

  @override
  String get colorNameTeal => '鸭绿色';

  @override
  String get colorNameIndigo => '靛蓝色';

  @override
  String get colorNameMagenta => '洋红';

  @override
  String get colorNameNavy => '海军蓝';

  @override
  String get colorNameCoral => '珊瑚色';

  @override
  String get colorNameGold => '金色';

  @override
  String get colorNameViolet => '紫罗兰';

  @override
  String get colorNameSky => '天蓝色';

  @override
  String get colorChapterTitleBasics => '第1章 · 入门颜色';

  @override
  String get colorChapterTitleWide => '第2章 · 更多颜色';

  @override
  String get colorChapterTitleMaster => '第3章 · 颜色大师';

  @override
  String colorGameChapterProgress(int current, int total) {
    return '第 $current / $total 章';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return '第 $current / $total 关';
  }

  @override
  String get colorGameNextChapterTitle => '新章节！';

  @override
  String get colorGameNextChapterBody => '新的颜色在等你。';

  @override
  String colorGameStageProgress(int current, int total) {
    return '阶段 $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '答对 $done / $need';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds 秒';
  }

  @override
  String get colorGameTimeUp => '时间到！';

  @override
  String get colorGameNextStageTitle => '太棒了！';

  @override
  String get colorGameNextStageBody => '准备好下一关了吗？';

  @override
  String get colorGameContinue => '继续';

  @override
  String get colorGameVictoryTitle => '厉害！';

  @override
  String get colorGameVictoryBody => '你通关了所有章节！';

  @override
  String get colorGamePlayAgain => '再玩一次';

  @override
  String get colorGameBack => '返回';

  @override
  String get colorFeedbackCorrect => '真棒！';

  @override
  String get colorFeedbackWrong => '再试一次';

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
  String get colorFailureLoad => '无法加载游戏。请重试。';

  @override
  String get colorFailurePalette => '无法获取调色板。';

  @override
  String get colorFailureUnknown => '发生意外错误。';
}
