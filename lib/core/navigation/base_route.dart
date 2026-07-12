import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Özel geçiş animasyonları için temel rota sınıfı (`01_project_structure.md`).
///
/// Her feature kendi rotasını bu sınıftan türetir:
///
/// ```dart
/// class HomeRoute extends BaseRoute {
///   const HomeRoute();
///
///   @override
///   Widget build(BuildContext context, GoRouterState state) {
///     return const HomePage();
///   }
/// }
/// ```
abstract class BaseRoute extends GoRouteData {
  const BaseRoute();

  /// Varsayılan sayfa geçişi: platforma özgü (iOS slide, Android fade-through).
  ///
  /// Override ederek özel animasyon tanımlayabilirsiniz.
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }

  /// Alt sınıflar bu metodu override etmelidir.
  @override
  Widget build(BuildContext context, GoRouterState state);
}
