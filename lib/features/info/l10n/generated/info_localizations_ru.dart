// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class InfoLocalizationsRu extends InfoLocalizations {
  InfoLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Рисунок не найден';

  @override
  String get infoDrawnLetter => 'Ваш рисунок';

  @override
  String get infoCongrats => 'Поздравляем!';

  @override
  String get infoSuccessMessage => 'Отличная работа! Я правильно распознал эту букву!';

  @override
  String get infoBack => 'Назад';

  @override
  String get resultDrawingNotFound => 'Рисунок не найден';

  @override
  String get resultDrawn => 'Ваш рисунок:';

  @override
  String get resultCongrats => 'Поздравляем!';

  @override
  String get resultTryAgain => 'Попробуйте еще раз!';

  @override
  String get resultTargetLetter => 'Цель:';

  @override
  String get resultSuccessMessage => 'Отличная работа! Я правильно распознал ваш рисунок!';

  @override
  String get resultFailMessage => 'Попробуйте еще раз! Ваш рисунок похож на что‑то другое.';

  @override
  String resultProgress(int correct, int total) {
    return 'Правильно: $correct / Всего: $total';
  }

  @override
  String get resultTryAgainBtn => 'Попробовать снова';

  @override
  String get resultNextLetter => 'Далее';

  @override
  String get resultNextLetterFail => 'Перейти далее';
}
