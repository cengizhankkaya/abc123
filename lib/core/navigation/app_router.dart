import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/navigation/app_router_observer.dart';
import 'package:abc123/core/navigation/main_shell_scaffold.dart';
import 'package:abc123/core/navigation/navigation_error_page.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/colors/presentation/pages/color_game_screen.dart';
import 'package:abc123/features/colors/presentation/pages/color_vision_game_screen.dart';
import 'package:abc123/features/draw/presentation/pages/draw_screen.dart';
import 'package:abc123/features/home/presentation/pages/avatar_shop_screen.dart';
import 'package:abc123/features/home/presentation/pages/badges_screen.dart';
import 'package:abc123/features/home/presentation/pages/daily_quest_screen.dart';
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

part '../../features/home/presentation/routes/home_routes.dart';
part '../../features/colors/presentation/routes/colors_routes.dart';
part '../../features/draw/presentation/routes/draw_routes.dart';
part '../../features/info/presentation/routes/info_routes.dart';
part '../../features/letters/presentation/routes/letters_routes.dart';
part '../../features/numbers_advanced/presentation/routes/numbers_advanced_routes.dart';
part '../../features/parent_panel/presentation/routes/parent_panel_routes.dart';
part '../../features/shapes/presentation/routes/shapes_routes.dart';
part '../../features/words/presentation/routes/words_routes.dart';

/// Tam ekran rotalar için kök [Navigator] anahtarı (`13_navigation.md`).
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Merkezi [GoRouter] yapılandırması.
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: kDebugMode,
  observers: [AppRouterObserver()],
  errorBuilder: (context, state) => NavigationErrorPage(state: state),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScreenTimeMiddleware(
          child: MainShellScaffold(navigationShell: navigationShell),
        );
      },
      branches: _homeShellBranches,
    ),
    ..._homeRoutes,
    ..._parentPanelRoutes,
    ..._drawRoutes,
    ..._lettersRoutes,
    ..._shapesRoutes,
    ..._wordsRoutes,
    ..._colorsRoutes,
    ..._numbersAdvancedRoutes,
    ..._infoRoutes,
  ],
);
