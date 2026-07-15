part of '../../../../core/navigation/app_router.dart';

final _numbersAdvancedRoutes = [
  GoRoute(
    path: AppRoutes.mathAdvanced,
    builder: (context, state) => const ScreenTimeMiddleware(child: MathHubScreen()),
  ),
  GoRoute(
    path: AppRoutes.mathTens,
    builder: (context, state) => const ScreenTimeMiddleware(child: TensSelectionScreen()),
  ),
  GoRoute(
    path: AppRoutes.mathFree,
    builder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MathProgressProvider>().startFreePractice();
      });
      return const ScreenTimeMiddleware(child: MultiDigitDrawScreen(isFreePractice: true));
    },
  ),
  GoRoute(
    path: AppRoutes.mathDrawMultiDigit,
    builder: (context, state) =>
        const ScreenTimeMiddleware(child: MultiDigitDrawScreen(isFreePractice: false)),
  ),
  GoRoute(
    path: AppRoutes.mathVisual,
    builder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MathProgressProvider>().startVisualAddition();
      });
      return const ScreenTimeMiddleware(child: VisualAdditionScreen());
    },
  ),
  GoRoute(
    path: AppRoutes.mathSymbolic,
    builder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MathProgressProvider>().startSymbolicOperation(isAddition: true);
      });
      return const ScreenTimeMiddleware(child: SymbolicMathScreen());
    },
  ),
];
