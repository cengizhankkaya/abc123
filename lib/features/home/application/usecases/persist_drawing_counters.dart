import 'package:abc123/core/application/base/async_use_case.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/error/run_guarded.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/home/application/dtos/drawing_counters_write.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Çizim kategorisi sayaçlarını kalıcılığa yazar (Command).
@injectable
final class PersistDrawingCounters implements AsyncCommandResult<DrawingCountersWrite> {
  final IGamificationPersistence _persistence;

  PersistDrawingCounters(this._persistence);

  @override
  FutureResult<Unit> call(DrawingCountersWrite input) {
    return runGuarded(() async {
      await _persistence.setInt(
        GamificationConstants.keyTotalDrawings,
        input.totalDrawings,
      );
      await _persistence.setInt(
        GamificationConstants.keyNumberDrawings,
        input.numberDrawings,
      );
      await _persistence.setInt(
        GamificationConstants.keyLetterDrawings,
        input.letterDrawings,
      );
      await _persistence.setInt(
        GamificationConstants.keyShapeDrawings,
        input.shapeDrawings,
      );
      await _persistence.setInt(
        GamificationConstants.keyColorRounds,
        input.colorRounds,
      );
      return unit;
    });
  }
}
