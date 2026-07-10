import 'package:abc123/core/application/base/async_use_case.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/error/run_guarded.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/home/application/dtos/gamification_initial_state.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:injectable/injectable.dart';

/// İlk açılışta kalıcılıktan oyun sayaçlarını ve envanter özetini okur (Query).
@injectable
final class LoadGamificationInitialState
    implements AsyncQueryNoParamsResult<GamificationInitialState> {
  final IGamificationPersistence _persistence;

  LoadGamificationInitialState(this._persistence);

  @override
  FutureResult<GamificationInitialState> call() {
    return runGuarded(() async {
      final points = await _persistence.getInt(GamificationConstants.keyPoints) ?? 0;
      final streak = await _persistence.getInt(GamificationConstants.keyStreak) ?? 0;
      final totalDrawings = await _persistence.getInt(GamificationConstants.keyTotalDrawings) ?? 0;
      final numberDrawings =
          await _persistence.getInt(GamificationConstants.keyNumberDrawings) ?? 0;
      final letterDrawings =
          await _persistence.getInt(GamificationConstants.keyLetterDrawings) ?? 0;
      final shapeDrawings = await _persistence.getInt(GamificationConstants.keyShapeDrawings) ?? 0;
      final colorRounds = await _persistence.getInt(GamificationConstants.keyColorRounds) ?? 0;
      final wordsCompleted =
          await _persistence.getInt(GamificationConstants.keyWordsCompleted) ?? 0;
      final unlockedBadgeIds =
          await _persistence.getStringList(GamificationConstants.keyUnlockedBadges) ?? [];
      final ownedItemIds =
          await _persistence.getStringList(GamificationConstants.keyOwnedItems) ?? [];
      final equippedItemsJson =
          await _persistence.getString(GamificationConstants.keyEquippedItems);
      final questsLedgerJson =
          await _persistence.getString(GamificationConstants.keyQuestsLedger);

      return GamificationInitialState(
        points: points,
        streak: streak,
        totalDrawings: totalDrawings,
        numberDrawings: numberDrawings,
        letterDrawings: letterDrawings,
        shapeDrawings: shapeDrawings,
        colorRounds: colorRounds,
        wordsCompleted: wordsCompleted,
        unlockedBadgeIds: unlockedBadgeIds,
        ownedItemIds: ownedItemIds,
        equippedItemsJson: equippedItemsJson,
        questsLedgerJson: questsLedgerJson,
      );
    });
  }
}
