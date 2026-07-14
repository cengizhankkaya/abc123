@TestOn('vm')
library;

import 'package:abc123/features/words/domain/word_catalog.dart';
import 'package:abc123/features/words/domain/word_story.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WordStory', () {
    test('sortedByLength tüm kelimeleri korur', () {
      final raw = WordCatalog.wordsForLocale('en');
      final chapters = WordCatalog.chaptersForLocale('en');
      final sorted = WordStory.sortedByLength(raw);
      expect(sorted.length, raw.length);
      expect(sorted.map((w) => w.id).toSet(), raw.map((w) => w.id).toSet());
      expect(sorted, orderedEquals(raw));
      expect(WordStory.totalLevels(chapters), 50);
    });

    test('levelAt doğru bölüm ve kelimeyi döner', () {
      final chapters = WordCatalog.chaptersForLocale('en');
      final first = WordStory.levelAt(chapters, 0);
      expect(first.chapter.length, 2);
      expect(first.levelInChapter, 0);

      final firstThree = WordStory.levelAt(chapters, 8);
      expect(firstThree.chapter.length, 3);
      expect(firstThree.levelInChapter, 0);
    });
  });
}
