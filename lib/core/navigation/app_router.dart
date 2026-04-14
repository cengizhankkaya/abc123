import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/navigation/main_shell_scaffold.dart';
import 'package:abc123/core/navigation/navigation_error_page.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/colors/presentation/pages/color_game_screen.dart';
import 'package:abc123/features/colors/presentation/pages/color_vision_game_screen.dart';
import 'package:abc123/features/draw/presentation/pages/draw_screen.dart';
import 'package:abc123/features/home/presentation/pages/avatar_shop_screen.dart';
import 'package:abc123/features/home/presentation/pages/badges_screen.dart';
import 'package:abc123/features/home/presentation/pages/daily_quest_screen.dart';
import 'package:abc123/features/home/presentation/tutorial/tutorial_screen.dart';
import 'package:abc123/features/home/presentation/widgets/home_tab.dart';
import 'package:abc123/features/info/presentation/models/info_draw_extra.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/info/presentation/pages/info_screen.dart';
import 'package:abc123/features/info/presentation/pages/result_screen.dart';
import 'package:abc123/features/letters/presentation/pages/letter_draw_screen.dart';
import 'package:abc123/features/shapes/presentation/pages/shapes_draw_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Tam ekran rotalar için kök [Navigator] anahtarı (`13_navigation.md`).
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Merkezi [GoRouter] yapılandırması.
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (context, state) => NavigationErrorPage(state: state),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScaffold(navigationShell: navigationShell);
      },
      branches: [
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
              path: AppRoutes.badgesTab,
              builder: (context, state) => const BadgesScreen(isTab: true),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.draw,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const DrawScreen(),
    ),
    GoRoute(
      path: AppRoutes.letters,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const LetterDrawScreen(),
    ),
    GoRoute(
      path: AppRoutes.shapes,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ShapesDrawScreen(),
    ),
    GoRoute(
      path: AppRoutes.colorGame,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ColorGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.colorVisionGame,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ColorVisionGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.tutorial,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => YoutubeVideoScreen(),
    ),
    GoRoute(
      path: AppRoutes.badgesFull,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const BadgesScreen(),
    ),
    GoRoute(
      path: AppRoutes.result,
      parentNavigatorKey: rootNavigatorKey,
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
      parentNavigatorKey: rootNavigatorKey,
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
  ],
);
