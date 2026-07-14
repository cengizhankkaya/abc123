part of '../../../../core/navigation/app_router.dart';

final _colorsRoutes = [
  GoRoute(
    path: AppRoutes.colorGame,
    builder: (context, state) => const ScreenTimeMiddleware(child: ColorGameScreen()),
  ),
  GoRoute(
    path: AppRoutes.colorVisionGame,
    builder: (context, state) => const ScreenTimeMiddleware(child: ColorVisionGameScreen()),
  ),
];
