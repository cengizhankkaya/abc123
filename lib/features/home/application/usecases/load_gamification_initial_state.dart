import 'package:abc123/core/application/base/use_case.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/error/run_guarded.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/home/application/dtos/gamification_initial_state.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:injectable/injectable.dart';

/// İlk açılışta kalıcılıktan oyun sayaçlarını ve envanter özetini okur (Query).
@injectable
final class LoadGamificationInitialState implements QueryNoParams<GamificationInitialState> {
  LoadGamificationInitialState(this._persistence);
  final IGamificationPersistence _persistence;

  @override
  FutureResult<GamificationInitialState> call() {
    return runGuarded(() async {
      final points = (await _persistence.getInt(GamificationConstants.keyPoints))
          .fold((_) => 0, (r) => r ?? 0);
      final streak = (await _persistence.getInt(GamificationConstants.keyStreak))
          .fold((_) => 0, (r) => r ?? 0);
      final totalDrawings = (await _persistence.getInt(GamificationConstants.keyTotalDrawings))
          .fold((_) => 0, (r) => r ?? 0);
      final numberDrawings = (await _persistence.getInt(GamificationConstants.keyNumberDrawings))
          .fold((_) => 0, (r) => r ?? 0);
      final letterDrawings = (await _persistence.getInt(GamificationConstants.keyLetterDrawings))
          .fold((_) => 0, (r) => r ?? 0);
      final shapeDrawings = (await _persistence.getInt(GamificationConstants.keyShapeDrawings))
          .fold((_) => 0, (r) => r ?? 0);
      final colorRounds = (await _persistence.getInt(GamificationConstants.keyColorRounds))
          .fold((_) => 0, (r) => r ?? 0);
      final wordsCompleted = (await _persistence.getInt(GamificationConstants.keyWordsCompleted))
          .fold((_) => 0, (r) => r ?? 0);
      final unlockedBadgeIds =
          (await _persistence.getStringList(GamificationConstants.keyUnlockedBadges))
              .fold((_) => <String>[], (r) => r ?? <String>[]);
      final ownedItemIds = (await _persistence.getStringList(GamificationConstants.keyOwnedItems))
          .fold((_) => <String>[], (r) => r ?? <String>[]);
      final equippedItemsJson =
          (await _persistence.getString(GamificationConstants.keyEquippedItems))
              .fold((_) => null, (r) => r);
      final questsLedgerJson = (await _persistence.getString(GamificationConstants.keyQuestsLedger))
          .fold((_) => null, (r) => r);

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
