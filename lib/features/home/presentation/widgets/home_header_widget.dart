import 'package:abc123/core/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/stat_pill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => headerPointsStreakSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final h = context.homeL10n!;
        final greeting = provider.childName.isEmpty
            ? h.hello
            : h.homeGreetingWithName(provider.childName);

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(HomeDesignTokens.headerBottomRadius),
            bottomRight: Radius.circular(HomeDesignTokens.headerBottomRadius),
          ),
          child: Container(
            width: double.infinity,
            color: HomeDesignTokens.headerBlue,
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
                        '$greeting 👋',
                        style: HomeDesignTokens.headingLarge(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        h.homeSloganToday,
                        style: HomeDesignTokens.bodyMedium(
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatPill(
                            emoji: '🔥',
                            label: h.homeStreakDays(provider.streak),
                          ),
                          const SizedBox(width: 10),
                          StatPill(
                            emoji: '⭐',
                            label: '${provider.points}',
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
