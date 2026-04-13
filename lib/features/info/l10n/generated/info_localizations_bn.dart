// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class InfoLocalizationsBn extends InfoLocalizations {
  InfoLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get infoDrawingNotFound => 'অঙ্কন পাওয়া যায়নি';

  @override
  String get infoDrawnLetter => 'তোমার অঙ্কন';

  @override
  String get infoCongrats => 'অভিনন্দন!';

  @override
  String get infoSuccessMessage => 'দারুণ কাজ! আমি এই অক্ষরটি সঠিকভাবে চিনতে পেরেছি!';

  @override
  String get infoBack => 'ফিরে যাও';

  @override
  String get resultDrawingNotFound => 'অঙ্কন পাওয়া যায়নি';

  @override
  String get resultDrawn => 'তোমার অঙ্কন:';

  @override
  String get resultCongrats => 'অভিনন্দন!';

  @override
  String get resultTryAgain => 'আবার চেষ্টা করুন!';

  @override
  String get resultTargetLetter => 'লক্ষ্যঃ';

  @override
  String get resultSuccessMessage => 'দারুণ কাজ! আমি তোমার অঙ্কনটি সঠিকভাবে চিনতে পেরেছি!';

  @override
  String get resultFailMessage => 'আবার চেষ্টা করুন! তোমার অঙ্কনটি অন্য কিছুর মতো দেখাচ্ছে।';

  @override
  String resultProgress(int correct, int total) {
    return 'সঠিক: $correct / মোট: $total';
  }

  @override
  String get resultTryAgainBtn => 'আবার চেষ্টা করুন';

  @override
  String get resultNextLetter => 'পরবর্তী';

  @override
  String get resultNextLetterFail => 'পরবর্তীতে যান';
}
