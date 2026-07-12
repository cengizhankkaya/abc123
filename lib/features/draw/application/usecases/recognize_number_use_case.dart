import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/draw/domain/failure/draw_failure.dart';
import 'package:abc123/features/draw/domain/repositories/i_number_recognition_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Rakam tanıma use case — Presentation katmanı bu use case'i çağırır,
/// doğrudan infrastructure'a erişmez.
@injectable
final class RecognizeNumberUseCase {
  final INumberRecognitionRepository _repository;

  const RecognizeNumberUseCase(this._repository);

  /// [imageBytes]: Çizim alanından elde edilen PNG bytes.
  /// Döndürür: Tanınan rakam (0–9) veya [DrawRecognitionFailed].
  FutureResult<int> call(Uint8List imageBytes) async {
    try {
      return await _repository.recognizeNumber(imageBytes);
    } catch (e) {
      return Left(const DrawRecognitionFailed());
    }
  }
}
