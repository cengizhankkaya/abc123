import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/presentation/widgets/fade_in_slide.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyQuestWidget extends StatelessWidget {
  const DailyQuestWidget({
    required this.quest,
    this.animationDelay = Duration.zero,
    super.key,
  });

  final QuestModel quest;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GamificationProvider>();
    final h = context.homeL10n!;
    final accent = _questColor(quest.targetType);
    final isWeekly = quest.id.contains('weekly');

    return FadeInSlide(
      delay: animationDelay,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(HomeDesignTokens.cardRadius),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: _buildTargetVisual(quest, accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isWeekly ? h.weeklyQuest : h.dailyQuest,
                        style: HomeDesignTokens.cardSubtitle(color: accent).copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildProgressIndicator(quest, accent),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _RewardButton(
                quest: quest,
                accent: accent,
                onClaim: quest.isCompleted && !quest.isClaimed
                    ? () => provider.claimQuestReward(quest.id)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(QuestModel quest, Color accent) {
    if (quest.targetCount <= 5) {
      return Row(
        children: List.generate(quest.targetCount, (index) {
          final isDone = index < quest.currentCount;
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              color: isDone ? accent : HomeDesignTokens.mutedText.withValues(alpha: 0.35),
              size: 22,
            ),
          );
        }),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${quest.currentCount} / ${quest.targetCount}',
          style: HomeDesignTokens.cardTitle(color: HomeDesignTokens.darkText).copyWith(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: quest.progress,
            backgroundColor: accent.withValues(alpha: 0.12),
            color: accent,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Color _questColor(DrawingType type) {
    return switch (type) {
      DrawingType.number => HomeDesignTokens.numbersCard,
      DrawingType.letter => HomeDesignTokens.lettersCard,
      DrawingType.shape => HomeDesignTokens.shapesCard,
      DrawingType.color => HomeDesignTokens.colorsCard,
      DrawingType.word => HomeDesignTokens.wordsCard,
      DrawingType.any => HomeDesignTokens.wordsCard,
    };
  }

  Widget _buildTargetVisual(QuestModel quest, Color accent) {
    if (quest.targetType == DrawingType.shape) {
      final icon = switch (quest.targetLabel) {
        'DAIRE' => Icons.circle_outlined,
        'KARE' => Icons.crop_square_rounded,
        'UCGEN' || 'ÜÇGEN' => Icons.change_history_rounded,
        _ => Icons.category_outlined,
      };
      return Icon(icon, size: 28, color: accent);
    }

    if (quest.targetType == DrawingType.color) {
      return Icon(Icons.palette_outlined, size: 28, color: accent);
    }

    if (quest.targetType == DrawingType.word) {
      return Icon(Icons.spellcheck_rounded, size: 28, color: accent);
    }

    if (quest.targetType == DrawingType.any) {
      return Icon(Icons.auto_awesome_rounded, size: 28, color: accent);
    }

    return Text(
      quest.targetLabel ?? '?',
      style: HomeDesignTokens.continueBadgeText(color: accent).copyWith(fontSize: 26),
    );
  }
}

class _RewardButton extends StatelessWidget {
  const _RewardButton({
    required this.quest,
    required this.accent,
    required this.onClaim,
  });

  final QuestModel quest;
  final Color accent;
  final VoidCallback? onClaim;

  @override
  Widget build(BuildContext context) {
    if (quest.isClaimed) {
      return Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: HomeDesignTokens.lettersCard.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.check_rounded, color: HomeDesignTokens.lettersCard, size: 28),
      );
    }

    if (quest.isCompleted) {
      return Material(
        color: HomeDesignTokens.shapesCard,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onClaim,
          borderRadius: BorderRadius.circular(14),
          child: const SizedBox(
            width: 52,
            height: 52,
            child: Icon(Icons.card_giftcard_rounded, color: HomeDesignTokens.darkText, size: 26),
          ),
        ),
      );
    }

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.stars_rounded, color: accent, size: 20),
          Text(
            '+${quest.rewardPoints}',
            style: HomeDesignTokens.cardSubtitle(color: accent).copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
