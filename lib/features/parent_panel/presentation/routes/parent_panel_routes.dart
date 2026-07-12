part of '../../../../../core/navigation/app_router.dart';

final _parentPanelRoutes = [
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
];
