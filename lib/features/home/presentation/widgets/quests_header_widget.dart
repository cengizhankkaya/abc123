import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Görevler sekmesi üst başlığı — [HomeHeaderWidget] ile aynı düzen.
class QuestsHeaderWidget extends StatelessWidget {
  const QuestsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => headerPointsStreakSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final h = context.homeL10n!;
        final claimed = provider.quests.where((q) => q.isClaimed).length;
        final total = provider.quests.length;

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(HomeDesignTokens.headerBottomRadius),
            bottomRight: Radius.circular(HomeDesignTokens.headerBottomRadius),
          ),
          child: Container(
            width: double.infinity,
            color: HomeDesignTokens.wordsCard,
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: HomeDesignTokens.headerCircle,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    MediaQuery.paddingOf(context).top + 16,
                    24,
                    28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🚀 ${h.myQuestsTitle}',
                        style: HomeDesignTokens.headingLarge(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        h.questsScreenSubtitle,
                        style: HomeDesignTokens.bodyMedium(
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _HeaderPill(
                            label: '🔥 ${h.homeStreakDays(provider.streak)}',
                          ),
                          const SizedBox(width: 8),
                          _HeaderPill(
                            label: '✅ $claimed / $total',
                          ),
                          const SizedBox(width: 8),
                          _HeaderPill(
                            label: '⭐ ${provider.points}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: HomeDesignTokens.bodyMedium().copyWith(fontSize: 12),
      ),
    );
  }
}
