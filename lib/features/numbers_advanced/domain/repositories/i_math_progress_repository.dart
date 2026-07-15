import 'package:abc123/features/numbers_advanced/domain/math_progress_stats.dart';

/// Repository interface for saving and loading math progress.
abstract class IMathProgressRepository {
  /// Loads the saved math progress statistics.
  Future<MathProgressStats> getProgress();

  /// Saves the math progress statistics.
  Future<void> saveProgress(MathProgressStats stats);
}
