@TestOn('vm')
library;

import 'package:abc123/features/words/domain/word_catalog.dart';
import 'package:abc123/features/words/domain/word_story.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WordCatalog', () {
    test('TR locale için TR kelimeleri döner', () {
      final words = WordCatalog.wordsForLocale(const Locale('tr'));
      expect(words, isNotEmpty);
      expect(words.any((w) => w.id.startsWith('tr_')), isTrue);
      expect(words.every((w) => RegExp(r'^[A-Z]+$').hasMatch(w.spelling)), isTrue);
    });

    test('desteklenmeyen locale EN fallback döner', () {
      final words = WordCatalog.wordsForLocale(const Locale('de'));
      expect(words, isNotEmpty);
      expect(words.any((w) => w.id.startsWith('en_')), isTrue);
    });

    test('her locale için 50 kelime vardır', () {
      expect(WordCatalog.wordCountForLocale(const Locale('en')), 50);
      expect(WordCatalog.wordCountForLocale(const Locale('tr')), 50);
    });

    test('kelimeler uzunluğa göre sıralıdır', () {
      final words = WordCatalog.wordsForLocale(const Locale('en'));
      for (var i = 1; i < words.length; i++) {
        expect(
          words[i].length,
          greaterThanOrEqualTo(words[i - 1].length),
          reason: '${words[i - 1].spelling} → ${words[i].spelling}',
        );
      }
    });

    test('bölümler harf uzunluğuna göre gruplanır', () {
      final chapters = WordCatalog.chaptersForLocale(const Locale('en'));
      expect(chapters.map((c) => c.length).toList(), [2, 3, 4, 5, 6]);
      expect(WordStory.totalLevels(chapters), 50);
    });
  });
}
