// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'info_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class InfoLocalizationsPt extends InfoLocalizations {
  InfoLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get infoDrawingNotFound => 'Desenho não encontrado';

  @override
  String get infoDrawnLetter => 'Seu desenho';

  @override
  String get infoCongrats => 'Parabéns!';

  @override
  String get infoSuccessMessage => 'Ótimo trabalho! Reconheci esta letra corretamente!';

  @override
  String get infoBack => 'Voltar';

  @override
  String get resultDrawingNotFound => 'Desenho não encontrado';

  @override
  String get resultDrawn => 'Seu desenho:';

  @override
  String get resultCongrats => 'Parabéns!';

  @override
  String get resultTryAgain => 'Tente novamente!';

  @override
  String get resultTargetLetter => 'Alvo:';

  @override
  String get resultSuccessMessage => 'Ótimo trabalho! Reconheci corretamente o seu desenho!';

  @override
  String get resultFailMessage => 'Tente novamente! Seu desenho parece outra coisa.';

  @override
  String resultProgress(int correct, int total) {
    return 'Correto: $correct / Total: $total';
  }

  @override
  String get resultTryAgainBtn => 'Tentar novamente';

  @override
  String get resultNextLetter => 'Próximo';

  @override
  String get resultNextLetterFail => 'Ir para o próximo';
}
