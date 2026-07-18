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
  String get colorVisionHomeTitle => '颜色形状';

  @override
  String get colorVisionHomeSubtitle => '有趣的扫描';

  @override
  String get colorVisionIntroDisclaimer => '圆点图片帮助您发现您是如何看待颜色的。这不是医学测试。';

  @override
  String get colorVisionStart => '开始游戏';

  @override
  String get colorVisionQuestion => '你在圆点中看到了什么形状？';

  @override
  String get colorVisionOptionCircle => '圆形';

  @override
  String get colorVisionOptionSquare => '正方形';

  @override
  String get colorVisionOptionTriangle => '三角形';

  @override
  String get colorVisionOptionNothing => '没有形状';

  @override
  String colorVisionProgress(int current, int total) {
    return '图片 $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total 正确';
  }

  @override
  String get colorVisionResultsTitle => '回合结束！';

  @override
  String get colorVisionResultsGood => '你找到了大多数形状 — 太棒了！';

  @override
  String get colorVisionResultsMixed => '有些图片比较难；这在孩子中很常见。';

  @override
  String get colorVisionResultsLow => '许多形状很难看清。这个游戏不能诊断色盲。';

  @override
  String get colorVisionResultsMedicalNote => '仅供学习和好奇。';

  @override
  String get colorVisionPlayAgain => '再玩一次';

  @override
  String get colorVisionIntroTitle => '隐藏的形状';

  @override
  String get colorVisionPlateBadgeRg => '红 · 绿';

  @override
  String get colorVisionPlateBadgeBy => '蓝 · 黄';

  @override
  String get colorVisionOptionDiamond => '菱形';

  @override
  String get colorVisionResultHintTitle => '有趣的小结';

  @override
  String get colorVisionProfileTypical => '你的答案似乎与典型的颜色视觉一致。';

  @override
  String get colorVisionProfileRedGreenAxis => '你错过了更多红绿风格的图片。';

  @override
  String get colorVisionProfileBlueYellowAxis => '你错过了更多蓝黄风格的图片。';

  @override
  String get colorVisionProfileMixed => '两种类型的图片都有点难。请在光线好的地方再试一次。';

  @override
  String get colorVisionProfileInconclusive => '没有明显的规律 — 请重试。';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return '红绿色盲图: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return '蓝黄色盲图: $correct / $total';
  }

  @override
  String get colorFailureLoad => '游戏加载失败。';

  @override
  String get colorFailurePalette => '无法获取颜色调色板。';

  @override
  String get colorFailureUnknown => '发生未知错误。';
}
