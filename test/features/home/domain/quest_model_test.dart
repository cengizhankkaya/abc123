@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/entities/quest.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_data.dart';

void main() {
  group('Quest', () {
    test('ilerleme oranı hedefe göre 0 ile 1 arasında kalır', () {
      final half = GamificationTestData.sampleQuest(currentCount: 5);
      expect(half.progress, closeTo(0.5, 1e-9));

      final over = GamificationTestData.sampleQuest(currentCount: 25);
      expect(over.progress, 1.0);

      final zero = GamificationTestData.sampleQuest();
      expect(zero.progress, 0.0);
    });

    test('aynı id ile Entity eşitliği sağlanır', () {
      final a = Quest(
        id: 'same',
        titleKey: 't1',
        targetType: DrawingType.letter,
        targetCount: 1,
        rewardPoints: 1,
      );
      final b = Quest(
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

    test('JSON serileştirme round-trip', () {
      final original = Quest(
        id: 'daily_2026-04-13',
        titleKey: 'daily_quest',
        targetType: DrawingType.shape,
        targetLabel: 'KARE',
        targetCount: 4,
        currentCount: 2,
        rewardPoints: 20,
      );
      final decoded = Quest.fromJson(
        Map<String, dynamic>.from(original.toJson()),
      );
      expect(decoded.id, original.id);
      expect(decoded.titleKey, original.titleKey);
      expect(decoded.targetType, original.targetType);
      expect(decoded.targetLabel, original.targetLabel);
      expect(decoded.targetCount, original.targetCount);
      expect(decoded.currentCount, original.currentCount);
      expect(decoded.isCompleted, original.isCompleted);
      expect(decoded.isClaimed, original.isClaimed);
      expect(decoded.rewardPoints, original.rewardPoints);
    });

    test('copyWith yeni örnek üretir; orijinal değişmez', () {
      final original = Quest(
        id: 'q',
        titleKey: 't',
        targetType: DrawingType.number,
        targetCount: 10,
        currentCount: 3,
        rewardPoints: 5,
      );
      final updated = original.copyWith(currentCount: 4, isCompleted: false);

      expect(original.currentCount, 3);
      expect(updated.currentCount, 4);
      expect(identical(original, updated), isFalse);
    });
  });
}
