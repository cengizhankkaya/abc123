@TestOn('vm')
library;

import 'package:abc123/features/words/domain/word_drawing_session.dart';
import 'package:abc123/features/words/domain/word_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WordDrawingSession', () {
    test('doğru harfte harf indeksi ilerler; kelime bitince sonraki kelimeye geçer', () {
      final s = WordDrawingSession(
        words: const [
          WordEntry(id: 'w1', spelling: 'CAT', displayKey: 'k1', emoji: '🐱'),
          WordEntry(id: 'w2', spelling: 'DOG', displayKey: 'k2', emoji: '🐶'),
        ],
      );

      expect(s.currentWord.id, 'w1');
      expect(s.currentLetterIndex, 0);
      expect(s.targetLetter, 'C');

      var r = s.registerAttempt(isCorrect: true);
      expect(r.isCorrect, isTrue);
      expect(r.wordCompletedNow, isFalse);
      expect(s.currentLetterIndex, 1);
      expect(s.targetLetter, 'A');

      s.registerAttempt(isCorrect: true);
      r = s.registerAttempt(isCorrect: true);
      expect(r.wordCompletedNow, isTrue);
      expect(s.currentWord.id, 'w2');
      expect(s.currentLetterIndex, 0);
      expect(s.completedWords, 1);
    });

    test('yanlış harfte indeks ilerlemez ama deneme sayısı artar', () {
      final s = WordDrawingSession(
        words: const [
          WordEntry(id: 'w1', spelling: 'CAT', displayKey: 'k1', emoji: '🐱'),
        ],
      );

      expect(s.totalAttempts, 0);
      final r = s.registerAttempt(isCorrect: false);
      expect(r.isCorrect, isFalse);
      expect(r.wordCompletedNow, isFalse);
      expect(s.currentLetterIndex, 0);
      expect(s.totalAttempts, 1);
      expect(s.correctLetters, 0);
    });
  });
}
