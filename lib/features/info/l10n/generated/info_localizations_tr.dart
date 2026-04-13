// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class InfoLocalizationsTr extends InfoLocalizations {
  InfoLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Çizim Bulunamadı';

  @override
  String get infoDrawnLetter => 'Çizdiğin Harf';

  @override
  String get infoCongrats => 'Tebrikler!';

  @override
  String get infoSuccessMessage => 'Harika iş çıkardın! Bu harfi doğru bir şekilde tanıdım!';

  @override
  String get infoBack => 'Geri Dön';

  @override
  String get resultDrawingNotFound => 'Çizim Bulunamadı';

  @override
  String get resultDrawn => 'Çizdiğin:';

  @override
  String get resultCongrats => 'Tebrikler!';

  @override
  String get resultTryAgain => 'Tekrar Dene!';

  @override
  String get resultTargetLetter => 'Hedef Çizim:';

  @override
  String get resultSuccessMessage => 'Harika iş çıkardın! Çizimini doğru bir şekilde tanıdım!';

  @override
  String get resultFailMessage => 'Tekrar denemelisin! Çizimin farklı bir şeye benziyor.';

  @override
  String resultProgress(int correct, int total) {
    return 'Doğru: $correct / Toplam: $total';
  }

  @override
  String get resultTryAgainBtn => 'Tekrar Dene';

  @override
  String get resultNextLetter => 'Sonrakine Geç';

  @override
  String get resultNextLetterFail => 'Sonrakine Geç';
}
