import 'package:flutter/material.dart';
import 'package:abc123/features/numbers_advanced/l10n/l10n_extensions.dart';

class LevelLockBadge extends StatelessWidget {
  const LevelLockBadge({
    required this.isLocked,
    required this.progressPercent,
    required this.correctCount,
    required this.totalCount,
    super.key,
  });

  final bool isLocked;
  final int progressPercent;
  final int correctCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;

    if (isLocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              l10n.mathLevelLocked,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
          const SizedBox(width: 6),
          Text(
            l10n.mathLevelProgress(correctCount, totalCount, progressPercent),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
