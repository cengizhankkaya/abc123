part of '../../../../core/navigation/app_router.dart';

final _lettersRoutes = [
  GoRoute(
    path: AppRoutes.letters,
    builder: (context, state) => const ScreenTimeMiddleware(child: LetterDrawScreen()),
  ),
];
