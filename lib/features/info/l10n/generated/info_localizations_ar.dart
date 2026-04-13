// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class InfoLocalizationsAr extends InfoLocalizations {
  InfoLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get infoDrawingNotFound => 'لم يتم العثور على الرسم';

  @override
  String get infoDrawnLetter => 'رسمك';

  @override
  String get infoCongrats => 'تهانينا!';

  @override
  String get infoSuccessMessage => 'عمل رائع! لقد تعرفت على هذا الحرف بشكل صحيح!';

  @override
  String get infoBack => 'عودة';

  @override
  String get resultDrawingNotFound => 'لم يتم العثور على الرسم';

  @override
  String get resultDrawn => 'رسمك:';

  @override
  String get resultCongrats => 'تهانينا!';

  @override
  String get resultTryAgain => 'حاول مرة أخرى!';

  @override
  String get resultTargetLetter => 'الهدف:';

  @override
  String get resultSuccessMessage => 'عمل رائع! لقد تعرفت على رسمك بشكل صحيح!';

  @override
  String get resultFailMessage => 'حاول مرة أخرى! يبدو أن رسمك يشبه شيئًا آخر.';

  @override
  String resultProgress(int correct, int total) {
    return 'صحيح: $correct / الإجمالي: $total';
  }

  @override
  String get resultTryAgainBtn => 'حاول مرة أخرى';

  @override
  String get resultNextLetter => 'التالي';

  @override
  String get resultNextLetterFail => 'انتقل إلى التالي';
}
