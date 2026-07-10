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
import 'package:abc123/features/home/presentation/pages/parent_panel_screen.dart';
import 'package:abc123/features/parent_panel/presentation/screens/parent_dashboard_screen.dart';
import 'package:abc123/features/parent_panel/presentation/screens/parental_gate_screen.dart';
import 'package:abc123/features/parent_panel/presentation/screens/screen_time_settings_screen.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/screen_time_middleware.dart';
import 'package:abc123/features/home/presentation/pages/settings_screen.dart';
import 'package:abc123/features/home/presentation/tutorial/tutorial_screen.dart';
import 'package:abc123/features/home/presentation/widgets/home_tab.dart';
import 'package:abc123/features/info/presentation/models/info_draw_extra.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/info/presentation/pages/info_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/pages/math_hub_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/pages/multi_digit_draw_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/pages/symbolic_math_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/pages/tens_selection_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/pages/visual_addition_screen.dart';
import 'package:abc123/features/info/presentation/pages/result_screen.dart';
import 'package:abc123/features/letters/presentation/pages/letter_draw_screen.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:provider/provider.dart';
import 'package:abc123/features/shapes/presentation/pages/shapes_draw_screen.dart';
import 'package:abc123/features/words/presentation/pages/word_draw_screen.dart';
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
        return ScreenTimeMiddleware(
          child: MainShellScaffold(navigationShell: navigationShell),
        );
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
      ],
    ),
    GoRoute(
      path: AppRoutes.parentPanel,
      builder: (context, state) => const ParentalGateScreen(),
    ),
    GoRoute(
      path: AppRoutes.parentGate,
      builder: (context, state) => const ParentalGateScreen(),
    ),
    GoRoute(
      path: AppRoutes.parentDashboard,
      builder: (context, state) => const ParentDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.parentScreenTime,
      builder: (context, state) => const ScreenTimeSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.draw,
      builder: (context, state) => const ScreenTimeMiddleware(child: DrawScreen()),
    ),
    GoRoute(
      path: AppRoutes.letters,
      builder: (context, state) => const ScreenTimeMiddleware(child: LetterDrawScreen()),
    ),
    GoRoute(
      path: AppRoutes.shapes,
      builder: (context, state) => const ScreenTimeMiddleware(child: ShapesDrawScreen()),
    ),
    GoRoute(
      path: AppRoutes.words,
      builder: (context, state) => const ScreenTimeMiddleware(child: WordDrawScreen()),
    ),
    GoRoute(
      path: AppRoutes.colorGame,
      builder: (context, state) => const ScreenTimeMiddleware(child: ColorGameScreen()),
    ),
    GoRoute(
      path: AppRoutes.colorVisionGame,
      builder: (context, state) => const ScreenTimeMiddleware(child: ColorVisionGameScreen()),
    ),
    GoRoute(
      path: AppRoutes.tutorial,
      builder: (context, state) => YoutubeVideoScreen(),
    ),
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
      builder: (context, state) => const ScreenTimeMiddleware(child: MultiDigitDrawScreen(isFreePractice: false)),
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
    GoRoute(
      path: AppRoutes.badgesFull,
      builder: (context, state) => const BadgesScreen(),
    ),
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
  ],
);
