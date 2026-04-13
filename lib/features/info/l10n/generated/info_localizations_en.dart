// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class InfoLocalizationsEn extends InfoLocalizations {
  InfoLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Drawing Not Found';

  @override
  String get infoDrawnLetter => 'Your Drawing';

  @override
  String get infoCongrats => 'Congratulations!';

  @override
  String get infoSuccessMessage => 'Great job! I recognized this letter correctly!';

  @override
  String get infoBack => 'Go Back';

  @override
  String get resultDrawingNotFound => 'Drawing Not Found';

  @override
  String get resultDrawn => 'Your Drawing:';

  @override
  String get resultCongrats => 'Congratulations!';

  @override
  String get resultTryAgain => 'Try Again!';

  @override
  String get resultTargetLetter => 'Target:';

  @override
  String get resultSuccessMessage => 'Great job! I recognized your drawing correctly!';

  @override
  String get resultFailMessage => 'Try again! Your drawing looks like something else.';

  @override
  String resultProgress(int correct, int total) {
    return 'Correct: $correct / Total: $total';
  }

  @override
  String get resultTryAgainBtn => 'Try Again';

  @override
  String get resultNextLetter => 'Next';

  @override
  String get resultNextLetterFail => 'Go to Next';
}
