// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class InfoLocalizationsFr extends InfoLocalizations {
  InfoLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Dessin non trouvé';

  @override
  String get infoDrawnLetter => 'Votre dessin';

  @override
  String get infoCongrats => 'Félicitations !';

  @override
  String get infoSuccessMessage => 'Bravo ! J\'ai reconnu cette lettre correctement !';

  @override
  String get infoBack => 'Retour';

  @override
  String get resultDrawingNotFound => 'Dessin non trouvé';

  @override
  String get resultDrawn => 'Votre dessin :';

  @override
  String get resultCongrats => 'Félicitations !';

  @override
  String get resultTryAgain => 'Réessayez !';

  @override
  String get resultTargetLetter => 'Cible :';

  @override
  String get resultSuccessMessage => 'Bravo ! J\'ai correctement reconnu votre dessin !';

  @override
  String get resultFailMessage => 'Réessayez ! Votre dessin ressemble à autre chose.';

  @override
  String resultProgress(int correct, int total) {
    return 'Correct : $correct / Total : $total';
  }

  @override
  String get resultTryAgainBtn => 'Réessayer';

  @override
  String get resultNextLetter => 'Suivant';

  @override
  String get resultNextLetterFail => 'Passer au suivant';
}
