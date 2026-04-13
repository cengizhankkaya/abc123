// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class InfoLocalizationsHi extends InfoLocalizations {
  InfoLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get infoDrawingNotFound => 'चित्र नहीं मिला';

  @override
  String get infoDrawnLetter => 'आपकी ड्राइंग';

  @override
  String get infoCongrats => 'बधाई हो!';

  @override
  String get infoSuccessMessage => 'शानदार! मैंने इस अक्षर को सही पहचाना!';

  @override
  String get infoBack => 'वापस जाएं';

  @override
  String get resultDrawingNotFound => 'चित्र नहीं मिला';

  @override
  String get resultDrawn => 'आपकी ड्राइंग:';

  @override
  String get resultCongrats => 'बधाई हो!';

  @override
  String get resultTryAgain => 'फिर से प्रयास करें!';

  @override
  String get resultTargetLetter => 'लक्ष्य:';

  @override
  String get resultSuccessMessage => 'शानदार! मैंने आपकी ड्राइंग को सही पहचाना!';

  @override
  String get resultFailMessage => 'फिर से प्रयास करें! आपकी ड्राइंग किसी और चीज़ जैसी लगती है।';

  @override
  String resultProgress(int correct, int total) {
    return 'सही: $correct / कुल: $total';
  }

  @override
  String get resultTryAgainBtn => 'फिर से प्रयास करें';

  @override
  String get resultNextLetter => 'आगे बढ़ें';

  @override
  String get resultNextLetterFail => 'अगले पर जाएं';
}
