import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('questListLayoutSignature ilerleme değişince değişir', () {
    final a = QuestModel(
      id: 'q1',
      titleKey: 't',
      targetType: DrawingType.number,
      targetCount: 5,
      currentCount: 1,
      rewardPoints: 10,
    );
    final b = a.copyWith(currentCount: 2);
    expect(
      questListLayoutSignature([a]) == questListLayoutSignature([b]),
      isFalse,
    );
  });
}
