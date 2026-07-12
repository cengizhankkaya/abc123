import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/presentation/widgets/animated_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

/// Projenin mevcut API'sini koruyarak yeni [AnimatedBottomNavBar]'ı sarmalayan
/// köprü widget. [MainShellScaffold] bu sınıfı import eder.
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AnimatedBottomNavBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        NavItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home_rounded,
          label: l10n.navHome,
        ),
        NavItem(
          icon: Icons.emoji_events_outlined,
          activeIcon: Icons.emoji_events_rounded,
          label: l10n.navBadges,
        ),
        NavItem(
          icon: Icons.rocket_launch_outlined,
          activeIcon: Icons.rocket_launch_rounded,
          label: l10n.navQuests,
        ),
        NavItem(
          icon: Icons.store_outlined,
          activeIcon: Icons.store_rounded,
          label: l10n.navShop,
        ),
        NavItem(
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings_rounded,
          label: l10n.navSettings,
        ),
      ],
    );
  }
}
