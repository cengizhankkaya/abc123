@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_data.dart';

void main() {
  group('QuestModel', () {
    test('ilerleme oranı hedefe göre 0 ile 1 arasında kalır', () {
      final half = GamificationTestData.sampleQuest(currentCount: 5);
      expect(half.progress, closeTo(0.5, 1e-9));

      final over = GamificationTestData.sampleQuest(currentCount: 25);
      expect(over.progress, 1.0);

      final zero = GamificationTestData.sampleQuest();
      expect(zero.progress, 0.0);
    });

    test('aynı id ile Entity eşitliği sağlanır', () {
      final a = QuestModel(
        id: 'same',
        titleKey: 't1',
        targetType: DrawingType.letter,
        targetCount: 1,
        rewardPoints: 1,
      );
      final b = QuestModel(
        id: 'same',
        titleKey: 'farklı',
        targetType: DrawingType.shape,
        targetCount: 99,
        rewardPoints: 99,
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('farklı id ile eşit değildir', () {
      final a = GamificationTestData.sampleQuest(id: 'a');
      final b = GamificationTestData.sampleQuest(id: 'b');
      expect(a, isNot(equals(b)));
    });

    test('copyWith yeni örnek üretir; orijinal değişmez', () {
      final original = QuestModel(
        id: 'q',
        titleKey: 't',
        targetType: DrawingType.number,
        targetCount: 10,
        currentCount: 3,
        rewardPoints: 5,
      );
      final updated =
          original.copyWith(currentCount: 4, isCompleted: false);

      expect(original.currentCount, 3);
      expect(updated.currentCount, 4);
      expect(identical(original, updated), isFalse);
    });
  });
}
