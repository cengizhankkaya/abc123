import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              _buildNavItem(context, Icons.home_rounded, l10n.navHome, 0),
              _buildNavItem(context, Icons.emoji_events_rounded, l10n.navBadges, 1),
              _buildNavItem(context, Icons.rocket_launch_rounded, l10n.navQuests, 2),
              _buildNavItem(context, Icons.store_rounded, l10n.navShop, 3),
              _buildNavItem(context, Icons.settings_rounded, l10n.navSettings, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? HomeDesignTokens.navActive : HomeDesignTokens.navInactive;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          onTap: () => onTap(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? HomeDesignTokens.navActive.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 22, color: color),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: HomeDesignTokens.navLabel(color: color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
