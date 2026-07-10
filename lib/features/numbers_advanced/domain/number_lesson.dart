/// Onluk sayı dersi domain varlığı.
///
/// Onluklar modülünde (10, 20, … 100) her ders bir [NumberLesson] ile temsil edilir.
/// Kullanıcı iki ayrı basamak kutucuğuna onlar ve birler hanesini çizer.
class NumberLesson {
  const NumberLesson({
    required this.targetNumber,
  }) : assert(
          targetNumber >= 10 && targetNumber <= 100,
          'Onluk sayı 10–100 aralığında olmalı',
        );

  /// Hedef sayı (örn. 30, 70, 100).
  final int targetNumber;

  /// Onlar basamağı (örn. 30 → 3).
  /// 100 için özel durum: onlar = 10, birler = 0.
  int get tensDigit => targetNumber == 100 ? 10 : targetNumber ~/ 10;

  /// Birler basamağı (onluklar için daima 0).
  int get unitsDigit => targetNumber % 10;

  /// Onlar basamağı ekranda gösterilecek string (100 → "10", 30 → "3").
  String get tensString => tensDigit.toString();

  /// Birler basamağı ekranda gösterilecek string.
  String get unitsString => unitsDigit.toString();

  @override
  String toString() => 'NumberLesson($targetNumber)';
}
