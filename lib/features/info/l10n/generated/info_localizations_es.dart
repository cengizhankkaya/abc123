// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class InfoLocalizationsEs extends InfoLocalizations {
  InfoLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Dibujo no encontrado';

  @override
  String get infoDrawnLetter => 'Tu dibujo';

  @override
  String get infoCongrats => '¡Felicidades!';

  @override
  String get infoSuccessMessage => '¡Buen trabajo! ¡He reconocido esta letra correctamente!';

  @override
  String get infoBack => 'Volver';

  @override
  String get resultDrawingNotFound => 'Dibujo no encontrado';

  @override
  String get resultDrawn => 'Tu dibujo:';

  @override
  String get resultCongrats => '¡Felicidades!';

  @override
  String get resultTryAgain => '¡Inténtalo de nuevo!';

  @override
  String get resultTargetLetter => 'Objetivo:';

  @override
  String get resultSuccessMessage => '¡Buen trabajo! ¡He reconocido correctamente tu dibujo!';

  @override
  String get resultFailMessage => '¡Inténtalo de nuevo! Tu dibujo parece otra cosa.';

  @override
  String resultProgress(int correct, int total) {
    return 'Correcto: $correct / Total: $total';
  }

  @override
  String get resultTryAgainBtn => 'Intentar de nuevo';

  @override
  String get resultNextLetter => 'Siguiente';

  @override
  String get resultNextLetterFail => 'Ir al siguiente';
}
