import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopHeaderWidget extends StatelessWidget {
  const ShopHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => headerPointsStreakSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final h = context.homeL10n!;
        final ownedCount = provider.ownedItemIds.length;

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(HomeDesignTokens.headerBottomRadius),
            bottomRight: Radius.circular(HomeDesignTokens.headerBottomRadius),
          ),
          child: Container(
            width: double.infinity,
            color: HomeDesignTokens.colorsCard,
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
                if (Navigator.of(context).canPop())
                  Positioned(
                    right: 16,
                    top: MediaQuery.paddingOf(context).top + 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: HomeDesignTokens.darkText,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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
                        '🛍️ ${h.shopTitle}',
                        style: HomeDesignTokens.headingLarge(
                          color: HomeDesignTokens.darkText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        h.shopScreenSubtitle,
                        style: HomeDesignTokens.bodyMedium(
                          color: HomeDesignTokens.darkText.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _ShopHeaderPill(
                            label: '⭐ ${provider.points}',
                          ),
                          const SizedBox(width: 8),
                          _ShopHeaderPill(
                            label: '👕 $ownedCount',
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

class _ShopHeaderPill extends StatelessWidget {
  const _ShopHeaderPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.darkText).copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
