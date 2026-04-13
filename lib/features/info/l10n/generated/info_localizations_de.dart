// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class InfoLocalizationsDe extends InfoLocalizations {
  InfoLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Zeichnung nicht gefunden';

  @override
  String get infoDrawnLetter => 'Dein gezeichneter Buchstabe';

  @override
  String get infoCongrats => 'Glückwunsch!';

  @override
  String get infoSuccessMessage => 'Großartige Arbeit! Ich habe diesen Buchstaben richtig erkannt!';

  @override
  String get infoBack => 'Zurück';

  @override
  String get resultDrawingNotFound => 'Zeichnung nicht gefunden';

  @override
  String get resultDrawn => 'Deine Zeichnung:';

  @override
  String get resultCongrats => 'Glückwunsch!';

  @override
  String get resultTryAgain => 'Nochmal versuchen!';

  @override
  String get resultTargetLetter => 'Ziel:';

  @override
  String get resultSuccessMessage => 'Großartige Arbeit! Ich habe deine Zeichnung richtig erkannt!';

  @override
  String get resultFailMessage =>
      'Versuche es erneut! Deine Zeichnung sieht nach etwas anderem aus.';

  @override
  String resultProgress(int correct, int total) {
    return 'Richtig: $correct / Gesamt: $total';
  }

  @override
  String get resultTryAgainBtn => 'Nochmal versuchen';

  @override
  String get resultNextLetter => 'Weiter';

  @override
  String get resultNextLetterFail => 'Zum nächsten';
}
