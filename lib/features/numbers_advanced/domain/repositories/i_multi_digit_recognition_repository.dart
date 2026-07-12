import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';

/// Çok basamaklı sayıları tanımak için domain portu.
///
/// Implementation: `infrastructure/repositories/multi_digit_recognition_repository_impl.dart`
abstract interface class IMultiDigitRecognitionRepository {
  /// Tek basamaklı rakamı PNG bytes'tan tanır (0–9).
  FutureResult<int> recognizeDigit(Uint8List pngBytes);

  /// İki PNG bytes (onlar hanesi + birler hanesi) → tam sayı (0–99).
  FutureResult<int> recognizeMultiDigit({
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  });

  /// Üç PNG bytes (yüzler + onlar + birler) → tam sayı (örneğin 100).
  FutureResult<int> recognizeTripleDigit({
    required Uint8List hundredsBytes,
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  });
}
