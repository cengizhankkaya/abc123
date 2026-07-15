import 'package:abc123/features/words/domain/word_entry.dart';

/// Çizim tabanlı kelime oturumu (sırayla harf tamamlama).
final class WordDrawingSession {
  WordDrawingSession({
    required List<WordEntry> words,
  }) : _words = List.unmodifiable(words) {
    if (_words.isEmpty) {
      throw ArgumentError.value(words, 'words', 'Boş olamaz');
    }
  }

  final List<WordEntry> _words;

  int _wordIndex = 0;
  int _letterIndex = 0;

  int _totalAttempts = 0;
  int _correctLetters = 0;
  int _completedWords = 0;

  WordEntry get currentWord => _words[_wordIndex];

  int get currentWordIndex => _wordIndex;
  int get currentLetterIndex => _letterIndex;

  int get totalAttempts => _totalAttempts;
  int get correctLetters => _correctLetters;
  int get completedWords => _completedWords;

  String get targetLetter => currentWord.spelling[_letterIndex].toUpperCase();

  bool evaluateRecognitionResult(String recognizedLetter) {
    final r = recognizedLetter.trim().toUpperCase();
    return r == targetLetter;
  }

  /// Bir deneme kaydeder. Doğruysa sonraki harfe geçer; kelime biterse sonraki kelimeye geçer.
  ///
  /// Geri dönüş: `(isCorrect, wordCompletedNow)`.
  ({bool isCorrect, bool wordCompletedNow}) registerAttempt({required bool isCorrect}) {
    _totalAttempts++;

    if (!isCorrect) {
      return (isCorrect: false, wordCompletedNow: false);
    }

    _correctLetters++;
    _letterIndex++;

    if (_letterIndex < currentWord.spelling.length) {
      return (isCorrect: true, wordCompletedNow: false);
    }

    _completedWords++;
    _letterIndex = 0;
    _wordIndex = (_wordIndex + 1) % _words.length;
    return (isCorrect: true, wordCompletedNow: true);
  }
}
