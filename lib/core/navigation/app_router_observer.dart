import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;

/// Navigasyon olaylarını izleyen ve debug logları üreten observer
/// (`01_project_structure.md` — Navigation Organization).
///
/// [GoRouter] yapılandırmasında `observers` listesine eklenir:
///
/// ```dart
/// final GoRouter appRouter = GoRouter(
///   observers: [AppRouterObserver()],
///   ...
/// );
/// ```
class AppRouterObserver extends NavigatorObserver {
  AppRouterObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('POP', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute == null) return;
    _log('REPLACE', newRoute, oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('REMOVE', route, previousRoute);
  }

  static void _log(
    String action,
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    if (!kDebugMode) return;
    final name = route.settings.name ?? route.runtimeType.toString();
    final prev = previousRoute?.settings.name ??
        previousRoute?.runtimeType.toString() ??
        'none';
    debugPrint('[Router] $action  $prev → $name');
  }
}
