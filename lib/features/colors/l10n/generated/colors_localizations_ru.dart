// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class ColorsLocalizationsRu extends ColorsLocalizations {
  ColorsLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get colorGameTitle => 'Цвета';

  @override
  String get colorGameInstruction => 'Прочитай слово и нажми подходящий цвет снизу.';

  @override
  String get colorNameRed => 'Красный';

  @override
  String get colorNameBlue => 'Синий';

  @override
  String get colorNameGreen => 'Зелёный';

  @override
  String get colorNameYellow => 'Жёлтый';

  @override
  String get colorNameOrange => 'Оранжевый';

  @override
  String get colorNamePurple => 'Фиолетовый';

  @override
  String get colorNamePink => 'Розовый';

  @override
  String get colorNameCyan => 'Бирюзовый';

  @override
  String get colorNameBrown => 'Коричневый';

  @override
  String get colorNameLime => 'Лайм';

  @override
  String get colorNameTeal => 'Морской';

  @override
  String get colorNameIndigo => 'Индиго';

  @override
  String get colorNameMagenta => 'Пурпурный';

  @override
  String get colorNameNavy => 'Тёмно-синий';

  @override
  String get colorNameCoral => 'Коралловый';

  @override
  String get colorNameGold => 'Золотой';

  @override
  String get colorNameViolet => 'Фиалковый';

  @override
  String get colorNameSky => 'Небесно-голубой';

  @override
  String get colorChapterTitleBasics => 'Глава 1 · Первые цвета';

  @override
  String get colorChapterTitleWide => 'Глава 2 · Больше цветов';

  @override
  String get colorChapterTitleMaster => 'Глава 3 · Мастер цвета';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Глава $current из $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Уровень $current из $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Новая глава!';

  @override
  String get colorGameNextChapterBody => 'Тебя ждут новые цвета.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Этап $current из $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done из $need верно';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds с';
  }

  @override
  String get colorGameTimeUp => 'Время вышло!';

  @override
  String get colorGameNextStageTitle => 'Отлично!';

  @override
  String get colorGameNextStageBody => 'Готов к следующему уровню?';

  @override
  String get colorGameContinue => 'Дальше';

  @override
  String get colorGameVictoryTitle => 'Супер!';

  @override
  String get colorGameVictoryBody => 'Ты прошёл все главы!';

  @override
  String get colorGamePlayAgain => 'Играть снова';

  @override
  String get colorGameBack => 'Назад';

  @override
  String get colorFeedbackCorrect => 'Отлично!';

  @override
  String get colorFeedbackWrong => 'Ещё раз';

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
  String get colorFailureLoad => 'Не удалось загрузить игру. Пожалуйста, попробуйте еще раз.';

  @override
  String get colorFailurePalette => 'Не удалось получить цветовую палитру.';

  @override
  String get colorFailureUnknown => 'Произошла непредвиденная ошибка.';
}
