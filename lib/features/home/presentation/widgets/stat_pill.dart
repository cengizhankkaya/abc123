import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';

/// Header'da seri ve puan gibi istatistikleri gösteren ortak pill widget'ı.
///
/// Kullanım:
/// ```dart
/// StatPill(emoji: '🔥', label: '7-day streak')
/// StatPill(emoji: '⭐', label: '240')
/// ```
class StatPill extends StatelessWidget {
  const StatPill({
    required this.emoji,
    required this.label,
    super.key,
  });

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$emoji $label',
        style: HomeDesignTokens.bodyMedium(),
      ),
    );
  }
}
