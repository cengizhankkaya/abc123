import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';

/// Rakam tanıma için domain portu — TFLite detaylarına bağımlı değil.
///
/// Implementation: `infrastructure/repositories/number_recognition_repository_impl.dart`
abstract interface class INumberRecognitionRepository {
  /// PNG byte dizisini alıp tanınan **rakamı** (0–9) döndürür.
  FutureResult<int> recognizeNumber(Uint8List imageBytes);
}
