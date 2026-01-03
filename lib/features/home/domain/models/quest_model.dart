import 'package:abc123/core/constants/gamification_constants.dart';

class QuestModel {
  final String id;
  final String titleKey; // Localized key
  final DrawingType targetType; // What to draw?
  final String?
      targetLabel; // e.g. "A", "1", "Circle" (optional specific target)
  final int targetCount;
  int currentCount;
  bool isCompleted;
  bool isClaimed;
  final int rewardPoints;

  QuestModel({
    required this.id,
    required this.titleKey,
    required this.targetType,
    this.targetLabel,
    required this.targetCount,
    this.currentCount = 0,
    this.isCompleted = false,
    this.isClaimed = false,
    required this.rewardPoints,
  });

  // Calculate progress 0.0 to 1.0
  double get progress => (currentCount / targetCount).clamp(0.0, 1.0);
}
