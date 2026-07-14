import 'dart:math';

import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';
import 'package:abc123/features/numbers_advanced/domain/math_operation.dart';
import 'package:abc123/features/numbers_advanced/domain/number_lesson.dart';

/// Zorluk seviyesine duyarlı matematik sorusu üretici.
///
/// Tüm metodlar deterministik değil — her çağrıda rastgele bir soru döner.
/// Zorluk kuralları:
/// - [DifficultyLevel.levelA]: sonuç ≤ 10, tek basamak
/// - [DifficultyLevel.levelB]: sonuç ≤ 20, tek/çift karışık
/// - [DifficultyLevel.levelC]: 2 basamaklı + 2 basamaklı, taşımasız
class MathProblemGenerator {
  MathProblemGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  // ────────────────────────────── Toplama ──────────────────────────────

  /// Zorluk seviyesine göre rastgele toplama sorusu üretir.
  MathOperation generateAddition(DifficultyLevel level) {
    return switch (level) {
      DifficultyLevel.levelA => _additionLevelA(),
      DifficultyLevel.levelB => _additionLevelB(),
      DifficultyLevel.levelC => _additionLevelC(),
    };
  }

  // Seviye A: a + b = c, c ≤ 10
  MathOperation _additionLevelA() {
    final a = _random.nextInt(10); // 0–9
    final b = _random.nextInt(10 - a + 1); // 0–(10-a)
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '+',
      result: a + b,
      difficulty: DifficultyLevel.levelA,
    );
  }

  // Seviye B: a + b = c, 11 ≤ c ≤ 20
  MathOperation _additionLevelB() {
    // Sonuç 11–20 arasında olsun
    final result = 11 + _random.nextInt(10); // 11–20
    final a = 1 + _random.nextInt(result - 1); // 1–(result-1)
    final b = result - a;
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '+',
      result: result,
      difficulty: DifficultyLevel.levelB,
    );
  }

  // Seviye C: 2 basamaklı + 2 basamaklı, taşımasız
  // Taşımasız: birler hanelerinin toplamı < 10 ve onlar hanelerinin toplamı < 10
  MathOperation _additionLevelC() {
    // a = 10*a1 + a0 ; b = 10*b1 + b0 ; a0+b0 < 10 ; a1+b1 < 10
    int a1, a0, b1, b0;
    do {
      a1 = 1 + _random.nextInt(4); // 1–4
      b1 = 1 + _random.nextInt(9 - a1); // taşımasız
      a0 = _random.nextInt(9);
      b0 = _random.nextInt(9 - a0);
    } while (a1 + b1 >= 10);
    final a = a1 * 10 + a0;
    final b = b1 * 10 + b0;
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '+',
      result: a + b,
      difficulty: DifficultyLevel.levelC,
    );
  }

  // ────────────────────────────── Çıkarma ──────────────────────────────

  /// Zorluk seviyesine göre rastgele çıkarma sorusu üretir.
  /// Sonuç daima ≥ 0 garantilenir.
  MathOperation generateSubtraction(DifficultyLevel level) {
    return switch (level) {
      DifficultyLevel.levelA => _subtractionLevelA(),
      DifficultyLevel.levelB => _subtractionLevelB(),
      DifficultyLevel.levelC => _subtractionLevelC(),
    };
  }

  // Seviye A: a - b = c, a ≤ 10, c ≥ 0
  MathOperation _subtractionLevelA() {
    final a = 1 + _random.nextInt(10); // 1–10
    final b = _random.nextInt(a + 1); // 0–a
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '-',
      result: a - b,
      difficulty: DifficultyLevel.levelA,
    );
  }

  // Seviye B: a - b = c, a ≤ 20, c ≥ 0
  MathOperation _subtractionLevelB() {
    final a = 11 + _random.nextInt(10); // 11–20
    final b = _random.nextInt(a + 1); // 0–a
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '-',
      result: a - b,
      difficulty: DifficultyLevel.levelB,
    );
  }

  // Seviye C: 2 basamaklı - 2 basamaklı, borçlanmasız
  MathOperation _subtractionLevelC() {
    int a;
    int b;
    do {
      final a1 = 2 + _random.nextInt(7); // 2–8
      final a0 = _random.nextInt(10); // 0–9
      a = a1 * 10 + a0;
      final b1 = 1 + _random.nextInt(a1 - 1); // 1–(a1-1)
      final b0 = _random.nextInt(a0 + 1); // 0–a0 (borçlanmasız)
      b = b1 * 10 + b0;
    } while (a <= b);
    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '-',
      result: a - b,
      difficulty: DifficultyLevel.levelC,
    );
  }

  // ────────────────────────────── Görsel Toplama ──────────────────────────────

  /// Görsel toplama sorusu üretir; sonuç ≤ 20.
  MathOperation generateVisualAddition() {
    final result = 2 + _random.nextInt(19); // 2–20
    final a = 1 + _random.nextInt(result - 1); // 1–(result-1)
    final b = result - a;

    // Seviyeyi sonuca göre belirle
    final difficulty =
        result <= 10 ? DifficultyLevel.levelA : DifficultyLevel.levelB;

    return MathOperation(
      operandA: a,
      operandB: b,
      operator: '+',
      result: result,
      difficulty: difficulty,
    );
  }

  // ────────────────────────────── Onluklar ──────────────────────────────

  /// 10–100 arasında rastgele onluk sayı dersi döner.
  NumberLesson generateTensLesson() {
    final tensValues = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
    final target = tensValues[_random.nextInt(tensValues.length)];
    return NumberLesson(targetNumber: target);
  }

  /// Belirli bir onluk sayı için ders döner.
  NumberLesson tensLessonFor(int targetNumber) {
    return NumberLesson(targetNumber: targetNumber);
  }

  // ────────────────────────────── Serbest Pratik ──────────────────────────────

  /// 11–99 arasında rastgele çift haneli sayı döner.
  int generateFreePracticeNumber() {
    return 11 + _random.nextInt(89); // 11–99
  }
}
