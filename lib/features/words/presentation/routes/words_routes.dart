part of '../../../../../core/navigation/app_router.dart';

final _wordsRoutes = [
  GoRoute(
    path: AppRoutes.words,
    builder: (context, state) => const ScreenTimeMiddleware(child: WordDrawScreen()),
  ),
];
