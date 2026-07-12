part of '../../../../../core/navigation/app_router.dart';

final _infoRoutes = [
  GoRoute(
    path: AppRoutes.result,
    builder: (context, state) {
      final extra = state.extra;
      if (extra is! ResultScreenData) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          body: Center(child: Text(l10n.routerInvalidResultData)),
        );
      }
      final d = extra;
      return ResultScreen(
        drawingImage: d.drawingImage,
        recognizedLetter: d.recognizedLetter,
        targetLetter: d.targetLetter,
        isCorrect: d.isCorrect,
        correctCount: d.correctCount,
        totalAttempts: d.totalAttempts,
        onTryAgain: d.onTryAgain,
        onContinue: d.onContinue,
      );
    },
  ),
  GoRoute(
    path: AppRoutes.infoDraw,
    builder: (context, state) {
      final extra = state.extra;
      if (extra is! InfoDrawExtra) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          body: Center(child: Text(l10n.routerInvalidInfoDrawData)),
        );
      }
      return InfoScreen(
        drawingImage: extra.drawingImage,
        recognizedLetter: extra.recognizedLetter,
      );
    },
  ),
];
