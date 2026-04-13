import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

enum BadgeFilter { all, earned, locked }

class BadgeFilterWidget extends StatelessWidget {
  final BadgeFilter selectedFilter;
  final void Function(BadgeFilter) onFilterChanged;

  const BadgeFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab(context, h.filterAll, BadgeFilter.all),
          _buildTab(context, h.filterEarned, BadgeFilter.earned),
          _buildTab(context, h.filterLocked, BadgeFilter.locked),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title, BadgeFilter filter) {
    final isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              color: const Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 4),
          // Underline
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: isSelected ? 40 : 0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ],
      ),
    );
  }
}
