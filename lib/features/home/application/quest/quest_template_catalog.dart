import 'dart:math';

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';

/// Görev şablonları — yeni görev eklemek için çoğunlukla burası güncellenir.
abstract final class QuestTemplateCatalog {
  static QuestModel buildDaily(String dayKey, Random random) {
    final typeIndex = random.nextInt(3);
    final count = random.nextInt(3) + 3; // 3–5
    late final DrawingType type;
    late final String targetLabel;

    if (typeIndex == 0) {
      type = DrawingType.number;
      targetLabel = (random.nextInt(9) + 1).toString();
    } else if (typeIndex == 1) {
      type = DrawingType.letter;
      const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      targetLabel = letters[random.nextInt(letters.length)];
    } else {
      type = DrawingType.shape;
      const shapes = <String>['DAIRE', 'UCGEN', 'KARE'];
      targetLabel = shapes[random.nextInt(shapes.length)];
    }

    return QuestModel(
      id: 'daily_$dayKey',
      titleKey: 'daily_quest',
      targetType: type,
      targetLabel: targetLabel,
      targetCount: count,
      rewardPoints: 20,
    );
  }

  static QuestModel weeklyNumbers(String weekKey) => QuestModel(
        id: 'weekly_numbers_$weekKey',
        titleKey: 'weekly_number_quest',
        targetType: DrawingType.number,
        targetCount: 10,
        rewardPoints: 50,
      );

  static QuestModel weeklyGeneric(String weekKey) => QuestModel(
        id: 'weekly_generic_$weekKey',
        titleKey: 'weekly_generic_quest',
        targetType: DrawingType.any,
        targetCount: 20,
        rewardPoints: 100,
      );
}
