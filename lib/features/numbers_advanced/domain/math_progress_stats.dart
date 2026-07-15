import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';

/// Bir seviyenin doğru/toplam istatistiği.
class LevelStat {
  LevelStat({this.correct = 0, this.total = 0});

  int correct;
  int total;

  double get accuracy => total == 0 ? 0.0 : correct / total;

  int get percent => (accuracy * 100).round();

  void addCorrect() {
    correct++;
    total++;
  }

  void addWrong() {
    total++;
  }
}

/// Matematik modülünün ilerleme istatistikleri.
class MathProgressStats {
  MathProgressStats({
    this.additionsCompleted = 0,
    this.subtractionsCompleted = 0,
    this.tensCompleted = 0,
    this.visualCompleted = 0,
    this.freeCompleted = 0,
    Map<DifficultyLevel, LevelStat>? levelStats,
  }) : levelStats = levelStats ??
            {
              DifficultyLevel.levelA: LevelStat(),
              DifficultyLevel.levelB: LevelStat(),
              DifficultyLevel.levelC: LevelStat(),
            };

  int additionsCompleted;
  int subtractionsCompleted;
  int tensCompleted;
  int visualCompleted;
  int freeCompleted;
  final Map<DifficultyLevel, LevelStat> levelStats;
}
