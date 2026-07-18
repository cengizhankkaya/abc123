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
  String get colorVisionHomeTitle => 'Цветовые фигуры';

  @override
  String get colorVisionHomeSubtitle => 'Веселое сканирование';

  @override
  String get colorVisionIntroDisclaimer =>
      'Точечные картинки помогут узнать, как вы видите цвета. Это не медицинский тест.';

  @override
  String get colorVisionStart => 'Давай играть';

  @override
  String get colorVisionQuestion => 'Какую фигуру ты видишь среди точек?';

  @override
  String get colorVisionOptionCircle => 'Круг';

  @override
  String get colorVisionOptionSquare => 'Квадрат';

  @override
  String get colorVisionOptionTriangle => 'Треугольник';

  @override
  String get colorVisionOptionNothing => 'Никакой';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Картинка $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total правильных';
  }

  @override
  String get colorVisionResultsTitle => 'Раунд завершен!';

  @override
  String get colorVisionResultsGood => 'Ты нашел большинство фигур — отлично!';

  @override
  String get colorVisionResultsMixed =>
      'Некоторые картинки были сложными; это часто бывает у детей.';

  @override
  String get colorVisionResultsLow =>
      'Многие фигуры было трудно разглядеть. Эта игра не ставит диагноз.';

  @override
  String get colorVisionResultsMedicalNote => 'Только для обучения и любопытства.';

  @override
  String get colorVisionPlayAgain => 'Играть снова';

  @override
  String get colorVisionIntroTitle => 'Скрытые фигуры';

  @override
  String get colorVisionPlateBadgeRg => 'Красный · Зеленый';

  @override
  String get colorVisionPlateBadgeBy => 'Синий · Желтый';

  @override
  String get colorVisionOptionDiamond => 'Ромб';

  @override
  String get colorVisionResultHintTitle => 'Веселое резюме';

  @override
  String get colorVisionProfileTypical => 'Твои ответы совпадают с типичным цветовым зрением.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'Ты пропустил больше картинок красно-зеленого стиля.';

  @override
  String get colorVisionProfileBlueYellowAxis => 'Ты пропустил больше картинок сине-желтого стиля.';

  @override
  String get colorVisionProfileMixed =>
      'Оба типа картинок были сложными. Попробуй еще раз при хорошем освещении.';

  @override
  String get colorVisionProfileInconclusive => 'Нет четкой картины — попробуй еще раз.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Красно-зеленый: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Сине-желтый: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Не удалось загрузить игру.';

  @override
  String get colorFailurePalette => 'Не удалось получить палитру.';

  @override
  String get colorFailureUnknown => 'Произошла ошибка.';
}
