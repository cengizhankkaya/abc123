part of '../../../../core/navigation/app_router.dart';

final _drawRoutes = [
  GoRoute(
    path: AppRoutes.draw,
    builder: (context, state) => const ScreenTimeMiddleware(child: DrawScreen()),
  ),
];
