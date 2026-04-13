// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class InfoLocalizationsAz extends InfoLocalizations {
  InfoLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Çizim tapılmadı';

  @override
  String get infoDrawnLetter => 'Sənin çəkdiyin';

  @override
  String get infoCongrats => 'Təbriklər!';

  @override
  String get infoSuccessMessage => 'Əla iş! Bu hərfi düzgün tanıdım!';

  @override
  String get infoBack => 'Geri dön';

  @override
  String get resultDrawingNotFound => 'Çizim tapılmadı';

  @override
  String get resultDrawn => 'Sənin çəkdiyin:';

  @override
  String get resultCongrats => 'Təbriklər!';

  @override
  String get resultTryAgain => 'Yenidən cəhd et!';

  @override
  String get resultTargetLetter => 'Hədəf:';

  @override
  String get resultSuccessMessage => 'Əla iş! Çizimini düzgün tanıdım!';

  @override
  String get resultFailMessage => 'Yenidən cəhd et! Çizimin başqa bir şeyə bənzəyir.';

  @override
  String resultProgress(int correct, int total) {
    return 'Düzgün: $correct / Cəmi: $total';
  }

  @override
  String get resultTryAgainBtn => 'Yenidən cəhd et';

  @override
  String get resultNextLetter => 'Növbəti';

  @override
  String get resultNextLetterFail => 'Növbətiyə keç';
}
