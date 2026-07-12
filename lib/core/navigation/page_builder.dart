import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Özel sayfa geçiş animasyonları için builder'lar (`01_project_structure.md`).
///
/// [AppRouter] veya feature rotalarında geçiş türünü belirlemek için kullanılır.
abstract final class PageBuilder {
  /// Yok (anlık geçiş) — oyun ekranları veya modal benzeri akışlar için.
  static Page<T> noTransition<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return NoTransitionPage<T>(key: state.pageKey, child: child);
  }

  /// Yatay kayma — iOS benzeri ileri-geri navigasyon.
  static Page<T> slide<T>(
    BuildContext context,
    GoRouterState state,
    Widget child, {
    bool reverse = false,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = reverse ? const Offset(-1, 0) : const Offset(1, 0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: Curves.easeInOut),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Soluklaşma — alt sekme değişimleri veya splash sonrası ana ekran.
  static Page<T> fade<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Ölçekleme + soluklaşma — oyun başlangıç/bitiş ekranları için.
  static Page<T> scaleAndFade<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
