// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class InfoLocalizationsZh extends InfoLocalizations {
  InfoLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get infoDrawingNotFound => '未找到绘图';

  @override
  String get infoDrawnLetter => '你的绘图';

  @override
  String get infoCongrats => '恭喜！';

  @override
  String get infoSuccessMessage => '干得好！我正确识别了这个字母！';

  @override
  String get infoBack => '返回';

  @override
  String get resultDrawingNotFound => '未找到绘图';

  @override
  String get resultDrawn => '你画的是：';

  @override
  String get resultCongrats => '恭喜！';

  @override
  String get resultTryAgain => '请再试一次！';

  @override
  String get resultTargetLetter => '目标：';

  @override
  String get resultSuccessMessage => '干得好！我正确识别了你的绘画！';

  @override
  String get resultFailMessage => '请再试一次！你的绘画看起来像别的东西。';

  @override
  String resultProgress(int correct, int total) {
    return '正确: $correct / 总数: $total';
  }

  @override
  String get resultTryAgainBtn => '再试一次';

  @override
  String get resultNextLetter => '下一个';

  @override
  String get resultNextLetterFail => '跳到下一个';
}
