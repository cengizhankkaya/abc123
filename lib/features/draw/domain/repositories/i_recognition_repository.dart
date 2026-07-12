import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';

/// Çizim tanıma için domain portu — TFLite detaylarına bağımlı değil.
///
/// Implementation: `infrastructure/repositories/recognition_repository_impl.dart`
abstract interface class IRecognitionRepository {
  /// PNG byte dizisini alıp tanınan **harfi** (A–Z) döndürür.
  FutureResult<String> recognizeLetter(Uint8List imageBytes);
}
