part of '../../../../../core/navigation/app_router.dart';

final _homeRoutes = [
  GoRoute(
    path: AppRoutes.tutorial,
    builder: (context, state) => YoutubeVideoScreen(),
  ),
  GoRoute(
    path: AppRoutes.badgesFull,
    builder: (context, state) => const BadgesScreen(),
  ),
];

final _homeShellBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeTab(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.badgesTab,
        builder: (context, state) => const BadgesScreen(isTab: true),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.quests,
        builder: (context, state) => const DailyQuestScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.shop,
        builder: (context, state) => const AvatarShopScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  ),
];
