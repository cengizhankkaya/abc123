import 'dart:math';

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/entities/quest.dart';

/// Görev şablonları — yeni görev eklemek için çoğunlukla burası güncellenir.
abstract final class QuestTemplateCatalog {
  static Quest buildDaily(String dayKey, Random random) {
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

    return Quest(
      id: 'daily_$dayKey',
      titleKey: 'daily_quest',
      targetType: type,
      targetLabel: targetLabel,
      targetCount: count,
      rewardPoints: 20,
    );
  }

  /// Günlük renk görevi — 3 renk turunu doğru tamamla.
  static Quest buildDailyColor(String dayKey) => Quest(
        id: 'daily_color_$dayKey',
        titleKey: 'daily_color_quest',
        targetType: DrawingType.color,
        targetCount: 3,
        rewardPoints: 15,
      );

  /// Günlük kelime görevi — 2 kelime tamamla.
  static Quest buildDailyWord(String dayKey) => Quest(
        id: 'daily_word_$dayKey',
        titleKey: 'daily_word_quest',
        targetType: DrawingType.word,
        targetCount: 2,
        rewardPoints: 15,
      );

  static Quest weeklyNumbers(String weekKey) => Quest(
        id: 'weekly_numbers_$weekKey',
        titleKey: 'weekly_number_quest',
        targetType: DrawingType.number,
        targetCount: 10,
        rewardPoints: 50,
      );

  /// Haftalık harf görevi — 10 harf çiz.
  static Quest weeklyLetters(String weekKey) => Quest(
        id: 'weekly_letters_$weekKey',
        titleKey: 'weekly_letter_quest',
        targetType: DrawingType.letter,
        targetCount: 10,
        rewardPoints: 50,
      );

  /// Haftalık şekil görevi — 8 şekil çiz.
  static Quest weeklyShapes(String weekKey) => Quest(
        id: 'weekly_shapes_$weekKey',
        titleKey: 'weekly_shape_quest',
        targetType: DrawingType.shape,
        targetCount: 8,
        rewardPoints: 50,
      );

  static Quest weeklyGeneric(String weekKey) => Quest(
        id: 'weekly_generic_$weekKey',
        titleKey: 'weekly_generic_quest',
        targetType: DrawingType.any,
        targetCount: 25,
        rewardPoints: 100,
      );
}
