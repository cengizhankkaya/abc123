part of '../../../../core/navigation/app_router.dart';

final _parentPanelRoutes = [
  GoRoute(
    path: AppRoutes.parentPanel,
    builder: (context, state) => const ParentalGateScreen(),
  ),
  GoRoute(
    path: AppRoutes.parentGate,
    builder: (context, state) {
      // `13_navigation.md`: extra ile parametre aktarımı (screen_time_middleware'den).
      final extra = state.extra;
      if (extra is Map<String, dynamic>) {
        return ParentalGateScreen(
          isForScreenTimeExtension: extra['isForScreenTimeExtension'] as bool? ?? false,
          onSuccess: extra['onSuccess'] as VoidCallback?,
        );
      }
      return const ParentalGateScreen();
    },
  ),
  GoRoute(
    path: AppRoutes.parentDashboard,
    builder: (context, state) => const ParentDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.parentScreenTime,
    builder: (context, state) => const ScreenTimeSettingsScreen(),
  ),
];
