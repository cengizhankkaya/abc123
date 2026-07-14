import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bilinmeyen rota veya hata durumunda gösterilen sayfa (`13_navigation.md`).
class NavigationErrorPage extends StatelessWidget {
  const NavigationErrorPage({required this.state, super.key});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.navErrorPageNotFound(state.uri.toString()),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(l10n.navHome),
            ),
          ],
        ),
      ),
    );
  }
}
