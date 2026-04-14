/// Tek seviye: seçenek sayısı, havuz, hedef doğru sayısı, tur süresi (null = süresiz).
class ColorGameStageConfig {
  const ColorGameStageConfig({
    required this.choices,
    required this.poolSize,
    required this.requiredCorrect,
    this.secondsPerRound,
  });

  final int choices;
  final int poolSize;
  final int requiredCorrect;
  final int? secondsPerRound;
}

/// Bir bölüm (chapter): başlık anahtarı + iç seviyeler.
class ColorGameChapterConfig {
  const ColorGameChapterConfig({
    required this.titleKey,
    required this.levels,
  });

  /// Yerelleştirme ile eşleşen anahtar: `basics` | `wide` | `master`.
  final String titleKey;
  final List<ColorGameStageConfig> levels;
}

/// Üç bölüm, toplam 9 seviye; havuz ve süre kademeli artar.
abstract final class ColorGameStory {
  static const List<ColorGameChapterConfig> chapters = [
    ColorGameChapterConfig(
      titleKey: 'basics',
      levels: [
        ColorGameStageConfig(choices: 3, poolSize: 6, requiredCorrect: 4),
        ColorGameStageConfig(choices: 3, poolSize: 7, requiredCorrect: 4, secondsPerRound: 26),
        ColorGameStageConfig(choices: 4, poolSize: 8, requiredCorrect: 5, secondsPerRound: 24),
      ],
    ),
    ColorGameChapterConfig(
      titleKey: 'wide',
      levels: [
        ColorGameStageConfig(choices: 4, poolSize: 10, requiredCorrect: 5, secondsPerRound: 22),
        ColorGameStageConfig(choices: 4, poolSize: 12, requiredCorrect: 5, secondsPerRound: 20),
        ColorGameStageConfig(choices: 4, poolSize: 14, requiredCorrect: 6, secondsPerRound: 18),
      ],
    ),
    ColorGameChapterConfig(
      titleKey: 'master',
      levels: [
        ColorGameStageConfig(choices: 4, poolSize: 16, requiredCorrect: 6, secondsPerRound: 16),
        ColorGameStageConfig(choices: 4, poolSize: 17, requiredCorrect: 7, secondsPerRound: 14),
        ColorGameStageConfig(choices: 4, poolSize: 18, requiredCorrect: 8, secondsPerRound: 12),
      ],
    ),
  ];

  static int get totalChapters => chapters.length;

  static int get totalLevels =>
      chapters.fold<int>(0, (sum, ch) => sum + ch.levels.length);

  /// Düz seviye indeksi için bölüm + bölüm içi seviye + yapılandırma.
  static ({ColorGameChapterConfig chapter, int levelInChapter, ColorGameStageConfig stage}) levelAt(
    int flatIndex,
  ) {
    var idx = flatIndex;
    for (final ch in chapters) {
      if (idx < ch.levels.length) {
        return (chapter: ch, levelInChapter: idx, stage: ch.levels[idx]);
      }
      idx -= ch.levels.length;
    }
    throw RangeError.index(flatIndex, null, 'flatIndex', null, totalLevels);
  }

  static bool isFirstLevelOfChapter(int flatIndex) {
    if (flatIndex == 0) return true;
    final prev = levelAt(flatIndex - 1);
    final cur = levelAt(flatIndex);
    return prev.chapter.titleKey != cur.chapter.titleKey;
  }
}
