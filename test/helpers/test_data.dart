import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/application/dtos/drawing_counters_write.dart';
import 'package:abc123/features/home/application/dtos/gamification_initial_state.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';

/// Ortak test verileri (`10_testing_standards.md` — Test Helpers).
abstract final class GamificationTestData {
  static const GamificationInitialState initialStateDefaults =
      GamificationInitialState(
    points: 100,
    streak: 3,
    totalDrawings: 10,
    numberDrawings: 4,
    letterDrawings: 3,
    shapeDrawings: 3,
    colorRounds: 2,
    unlockedBadgeIds: ['badge_first_login'],
    ownedItemIds: ['hat_blue_cap'],
    equippedItemsJson: '{"ShopItemType.hat":"hat_blue_cap"}',
    questsLedgerJson: null,
  );

  static const DrawingCountersWrite sampleCountersWrite =
      DrawingCountersWrite(
    totalDrawings: 20,
    numberDrawings: 8,
    letterDrawings: 7,
    shapeDrawings: 5,
    colorRounds: 1,
  );

  static QuestModel sampleQuest({
    String id = 'q1',
    int targetCount = 10,
    int currentCount = 0,
  }) {
    return QuestModel(
      id: id,
      titleKey: 'quest_title',
      targetType: DrawingType.number,
      targetCount: targetCount,
      currentCount: currentCount,
      rewardPoints: 50,
    );
  }
}
