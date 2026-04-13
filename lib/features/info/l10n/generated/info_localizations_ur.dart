// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class InfoLocalizationsUr extends InfoLocalizations {
  InfoLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get infoDrawingNotFound => 'ڈراؤنگ نہیں ملی';

  @override
  String get infoDrawnLetter => 'آپ کی ڈرائنگ';

  @override
  String get infoCongrats => 'مبارک ہو!';

  @override
  String get infoSuccessMessage => 'زبردست! میں نے اس حرف کو صحیح پہچانا!';

  @override
  String get infoBack => 'واپس جائیں';

  @override
  String get resultDrawingNotFound => 'ڈراؤنگ نہیں ملی';

  @override
  String get resultDrawn => 'آپ کی ڈرائنگ:';

  @override
  String get resultCongrats => 'مبارک ہو!';

  @override
  String get resultTryAgain => 'دوبارہ کوشش کریں!';

  @override
  String get resultTargetLetter => 'ہدف:';

  @override
  String get resultSuccessMessage => 'زبردست! میں نے آپ کی ڈرائنگ کو صحیح پہچانا!';

  @override
  String get resultFailMessage => 'دوبارہ کوشش کریں! آپ کی ڈرائنگ کسی اور چیز جیسی لگتی ہے۔';

  @override
  String resultProgress(int correct, int total) {
    return 'درست: $correct / کل: $total';
  }

  @override
  String get resultTryAgainBtn => 'دوبارہ کوشش کریں';

  @override
  String get resultNextLetter => 'اگلا';

  @override
  String get resultNextLetterFail => 'اگلے پر جائیں';
}
