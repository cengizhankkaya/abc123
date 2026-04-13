import 'dart:ui';

import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.home_rounded, 0),
              _buildNavItem(context, Icons.rocket_launch_rounded, 1),
              _buildNavItem(context, Icons.store_rounded, 2),
              _buildNavItem(context, Icons.emoji_events_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

  String _navLabel(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    return switch (index) {
      0 => l10n.navHome,
      1 => l10n.navQuests,
      2 => l10n.navShop,
      _ => l10n.navBadges,
    };
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index) {
    final isSelected = currentIndex == index;
    return Semantics(
      button: true,
      selected: isSelected,
      label: _navLabel(context, index),
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey.shade400,
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C5CE7),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
