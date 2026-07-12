import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';

/// Şekil tanıma için domain portu.
///
/// Implementation: `infrastructure/repositories/shape_recognition_repository_impl.dart`
abstract interface class IShapeRecognitionRepository {
  /// PNG byte dizisini alıp tanınan şekli döndürür.
  FutureResult<String> recognizeShape(Uint8List imageBytes);
}
