import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';

/// Matematik işlemi domain varlığı.
///
/// Toplama (`+`) ve çıkarma (`-`) işlemlerini temsil eder.
/// [result] daima negatif olmaz — üretici bu kısıtı garantiler.
class MathOperation {
  const MathOperation({
    required this.operandA,
    required this.operandB,
    required this.operator,
    required this.result,
    required this.difficulty,
  });

  /// Birinci operand (sol taraf).
  final int operandA;

  /// İkinci operand (sağ taraf).
  final int operandB;

  /// İşlem operatörü: `'+'` veya `'-'`.
  final String operator;

  /// Beklenen doğru sonuç.
  final int result;

  /// Sorunun zorluk kademesi.
  final DifficultyLevel difficulty;

  /// Sonuç çift basamaklı mı? (≥ 10)
  bool get isDoubleDigitResult => result >= 10;

  /// Onlar basamağı (tek basamak sonuç için 0).
  int get tensDigit => result ~/ 10;

  /// Birler basamağı.
  int get unitsDigit => result % 10;

  @override
  String toString() => '$operandA $operator $operandB = $result';
}
