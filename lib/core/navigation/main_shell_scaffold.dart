import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/presentation/responsive/adaptive_layout_builder.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:abc123/core/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [StatefulShellRoute.indexedStack] kabuğu; [ScreenSize]’a göre gezinme deseni (`14_adaptive_ui_strategy.md`).
class MainShellScaffold extends StatefulWidget {
  const MainShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShellScaffold> createState() => _MainShellScaffoldState();
}

class _MainShellScaffoldState extends State<MainShellScaffold> {
  final GlobalKey<ScaffoldState> _expandedScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutBuilder(
      builder: (context, screenSize) {
        final shell = widget.navigationShell;
        return switch (screenSize) {
          ScreenSize.compact => _CompactShell(navigationShell: shell),
          ScreenSize.medium => _MediumShell(navigationShell: shell),
          ScreenSize.expanded => _ExpandedShell(
              navigationShell: shell,
              scaffoldKey: _expandedScaffoldKey,
            ),
          ScreenSize.large => _LargeShell(navigationShell: shell),
          ScreenSize.extraLarge => _LargeShell(navigationShell: shell),
        };
      },
    );
  }
}

class _CompactShell extends StatelessWidget {
  const _CompactShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // İçerik alanı: floating nav bar'ın üstünde kalması için alt padding
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 104,
            child: navigationShell,
          ),
          // Floating animated bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
            ),
          ),
        ],
      ),
    );
  }
}

class _MediumShell extends StatelessWidget {
  const _MediumShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            labelType: NavigationRailLabelType.all,
            destinations: _shellRailDestinations(context),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _ExpandedShell extends StatelessWidget {
  const _ExpandedShell({
    required this.navigationShell,
    required this.scaffoldKey,
  });

  final StatefulNavigationShell navigationShell;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: _AppNavigationDrawer(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (i) {
          navigationShell.goBranch(i);
          scaffoldKey.currentState?.closeDrawer();
        },
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          navigationShell,
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                tooltip: AppLocalizations.of(context)!.navMenuTooltip,
                icon: const Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LargeShell extends StatelessWidget {
  const _LargeShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 256,
            child: _AppNavigationDrawer(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

List<NavigationRailDestination> _shellRailDestinations(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    NavigationRailDestination(
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home_rounded),
      label: Text(l10n.navHome),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.emoji_events_outlined),
      selectedIcon: const Icon(Icons.emoji_events_rounded),
      label: Text(l10n.navBadges),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.rocket_launch_outlined),
      selectedIcon: const Icon(Icons.rocket_launch_rounded),
      label: Text(l10n.navQuests),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.store_outlined),
      selectedIcon: const Icon(Icons.store_rounded),
      label: Text(l10n.navShop),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.settings_outlined),
      selectedIcon: const Icon(Icons.settings_rounded),
      label: Text(l10n.navSettings),
    ),
  ];
}

class _AppNavigationDrawer extends StatelessWidget {
  const _AppNavigationDrawer({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      children: [
        NavigationDrawerDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home_rounded),
          label: Text(l10n.navHome),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.emoji_events_outlined),
          selectedIcon: const Icon(Icons.emoji_events_rounded),
          label: Text(l10n.navBadges),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.rocket_launch_outlined),
          selectedIcon: const Icon(Icons.rocket_launch_rounded),
          label: Text(l10n.navQuests),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.store_outlined),
          selectedIcon: const Icon(Icons.store_rounded),
          label: Text(l10n.navShop),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings_rounded),
          label: Text(l10n.navSettings),
        ),
      ],
    );
  }
}
