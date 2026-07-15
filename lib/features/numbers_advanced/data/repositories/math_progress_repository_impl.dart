import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';
import 'package:abc123/features/numbers_advanced/domain/math_progress_stats.dart';
import 'package:abc123/features/numbers_advanced/domain/repositories/i_math_progress_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IMathProgressRepository)
class MathProgressRepositoryImpl implements IMathProgressRepository {
  MathProgressRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyAdditions = 'math_additions_completed';
  static const String _keySubtractions = 'math_subtractions_completed';
  static const String _keyTens = 'math_tens_completed';
  static const String _keyVisual = 'math_visual_completed';
  static const String _keyFree = 'math_free_completed';
  static const String _keyLevelACorrect = 'math_level_a_correct';
  static const String _keyLevelATotal = 'math_level_a_total';
  static const String _keyLevelBCorrect = 'math_level_b_correct';
  static const String _keyLevelBTotal = 'math_level_b_total';
  static const String _keyLevelCCorrect = 'math_level_c_correct';
  static const String _keyLevelCTotal = 'math_level_c_total';

  @override
  Future<MathProgressStats> getProgress() async {
    return MathProgressStats(
      additionsCompleted: _prefs.getInt(_keyAdditions) ?? 0,
      subtractionsCompleted: _prefs.getInt(_keySubtractions) ?? 0,
      tensCompleted: _prefs.getInt(_keyTens) ?? 0,
      visualCompleted: _prefs.getInt(_keyVisual) ?? 0,
      freeCompleted: _prefs.getInt(_keyFree) ?? 0,
      levelStats: {
        DifficultyLevel.levelA: LevelStat(
          correct: _prefs.getInt(_keyLevelACorrect) ?? 0,
          total: _prefs.getInt(_keyLevelATotal) ?? 0,
        ),
        DifficultyLevel.levelB: LevelStat(
          correct: _prefs.getInt(_keyLevelBCorrect) ?? 0,
          total: _prefs.getInt(_keyLevelBTotal) ?? 0,
        ),
        DifficultyLevel.levelC: LevelStat(
          correct: _prefs.getInt(_keyLevelCCorrect) ?? 0,
          total: _prefs.getInt(_keyLevelCTotal) ?? 0,
        ),
      },
    );
  }

  @override
  Future<void> saveProgress(MathProgressStats stats) async {
    await _prefs.setInt(_keyAdditions, stats.additionsCompleted);
    await _prefs.setInt(_keySubtractions, stats.subtractionsCompleted);
    await _prefs.setInt(_keyTens, stats.tensCompleted);
    await _prefs.setInt(_keyVisual, stats.visualCompleted);
    await _prefs.setInt(_keyFree, stats.freeCompleted);

    final a = stats.levelStats[DifficultyLevel.levelA]!;
    final b = stats.levelStats[DifficultyLevel.levelB]!;
    final c = stats.levelStats[DifficultyLevel.levelC]!;

    await _prefs.setInt(_keyLevelACorrect, a.correct);
    await _prefs.setInt(_keyLevelATotal, a.total);
    await _prefs.setInt(_keyLevelBCorrect, b.correct);
    await _prefs.setInt(_keyLevelBTotal, b.total);
    await _prefs.setInt(_keyLevelCCorrect, c.correct);
    await _prefs.setInt(_keyLevelCTotal, c.total);
  }
}
