import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/models/quest_model.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:abc123/core/constants/language_constants.dart';

class DailyQuestWidget extends StatelessWidget {
  final QuestModel quest;

  const DailyQuestWidget({
    required this.quest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GamificationProvider>();
    final lang = context.watch<LanguageProvider>().language;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            // Target Visual
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getQuestColor(quest.targetType).withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                    color: _getQuestColor(quest.targetType), width: 4),
              ),
              child: Center(
                child: _buildTargetVisual(quest),
              ),
            ),
            const SizedBox(width: 16),

            // Progress
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quest.id.contains('weekly')
                        ? getLocalizedText('weeklyQuest', lang)
                        : getLocalizedText('dailyQuest', lang),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildProgressIndicator(quest),
                ],
              ),
            ),

            // Reward / Action
            GestureDetector(
              onTap: () {
                if (quest.isCompleted && !quest.isClaimed) {
                  provider.claimQuestReward(quest.id);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: quest.isClaimed
                      ? Colors.green.shade100
                      : (quest.isCompleted
                          ? const Color(0xFFFFD32A)
                          : Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        quest.isCompleted ? Colors.black : Colors.grey.shade300,
                    width: quest.isCompleted ? 2 : 1,
                  ),
                ),
                child: quest.isClaimed
                    ? const Icon(Icons.check_rounded,
                        color: Colors.green, size: 32)
                    : (quest.isCompleted
                        ? const Icon(Icons.card_giftcard_rounded,
                            color: Colors.black, size: 32)
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.stars_rounded,
                                  color: Colors.amber, size: 24),
                              Text(
                                "+${quest.rewardPoints}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(QuestModel quest) {
    if (quest.targetCount <= 5) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(quest.targetCount, (index) {
          final isDone = index < quest.currentCount;
          return Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Icon(
              isDone ? Icons.star_rounded : Icons.star_outline_rounded,
              color: isDone ? const Color(0xFFFFD32A) : Colors.grey.shade300,
              size: 24,
            ),
          );
        }),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${quest.currentCount} / ${quest.targetCount}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: quest.progress,
              backgroundColor: Colors.grey.shade200,
              color: _getQuestColor(quest.targetType),
              minHeight: 8,
            ),
          ),
        ],
      );
    }
  }

  Color _getQuestColor(DrawingType type) {
    switch (type) {
      case DrawingType.number:
        return const Color(0xFFFF7675);
      case DrawingType.letter:
        return const Color(0xFF74B9FF);
      case DrawingType.shape:
        return const Color(0xFF55EFC4);
      default:
        return Colors.purple;
    }
  }

  Widget _buildTargetVisual(QuestModel quest) {
    if (quest.targetType == DrawingType.shape) {
      IconData icon;
      switch (quest.targetLabel) {
        case 'DAIRE':
          icon = Icons.circle_outlined;
          break;
        case 'KARE':
          icon = Icons.crop_square_rounded;
          break;
        case 'UCGEN':
        case 'ÜÇGEN':
          icon = Icons.change_history_rounded; // Triangle-ish
          break;
        default:
          icon = Icons.shape_line;
      }
      return Icon(icon, size: 40, color: _getQuestColor(quest.targetType));
    } else {
      return Text(
        quest.targetLabel ?? '?',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w900,
          color: _getQuestColor(quest.targetType),
        ),
      );
    }
  }
}
