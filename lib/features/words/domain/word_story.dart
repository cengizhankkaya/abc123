import 'package:abc123/features/words/domain/word_entry.dart';

/// Renk oyunundaki `ColorGameStory` desenine benzer, basit seviye düzeni.
abstract final class WordStory {
  static List<WordChapterConfig> chaptersForWords(List<WordEntry> words) {
    final byLen = <int, List<WordEntry>>{};
    for (final w in words) {
      byLen.putIfAbsent(w.length, () => []).add(w);
    }

    final lengths = byLen.keys.toList()..sort();
    return [
      for (final len in lengths)
        WordChapterConfig(
          length: len,
          levels: byLen[len]!,
        ),
    ];
  }

  static ({WordChapterConfig chapter, int levelInChapter, WordEntry entry}) levelAt(
    List<WordChapterConfig> chapters,
    int flatIndex,
  ) {
    var idx = flatIndex;
    for (final ch in chapters) {
      if (idx < ch.levels.length) {
        return (chapter: ch, levelInChapter: idx, entry: ch.levels[idx]);
      }
      idx -= ch.levels.length;
    }
    throw RangeError.index(flatIndex, null, 'flatIndex', null, totalLevels(chapters));
  }

  static int totalLevels(List<WordChapterConfig> chapters) =>
      chapters.fold<int>(0, (sum, ch) => sum + ch.levels.length);

  /// Kelimeleri uzunluk bölümlerine ayırıp düz sırayla döner (kısa → uzun).
  static List<WordEntry> sortedByLength(List<WordEntry> words) {
    return [
      for (final chapter in chaptersForWords(words)) ...chapter.levels,
    ];
  }
}

final class WordChapterConfig {
  const WordChapterConfig({
    required this.length,
    required this.levels,
  });

  final int length;
  final List<WordEntry> levels;
}
