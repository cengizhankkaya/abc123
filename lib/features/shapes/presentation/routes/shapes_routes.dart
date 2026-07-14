part of '../../../../core/navigation/app_router.dart';

final _shapesRoutes = [
  GoRoute(
    path: AppRoutes.shapes,
    builder: (context, state) => const ScreenTimeMiddleware(child: ShapesDrawScreen()),
  ),
];
