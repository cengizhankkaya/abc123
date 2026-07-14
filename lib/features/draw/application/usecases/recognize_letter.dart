import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/draw/domain/failure/draw_failure.dart';
import 'package:abc123/features/draw/domain/repositories/i_recognition_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Harf tanıma use case — Presentation katmanı bu use case'i çağırır,
/// doğrudan infrastructure'a erişmez.
@injectable
final class RecognizeLetter {

  const RecognizeLetter(this._repository);
  final IRecognitionRepository _repository;

  /// [imageBytes]: Çizim alanından elde edilen PNG bytes.
  /// Döndürür: Tanınan harf (A–Z) veya [DrawRecognitionFailed].
  FutureResult<String> call(Uint8List imageBytes) async {
    try {
      return await _repository.recognizeLetter(imageBytes);
    } catch (e) {
      return const Left(DrawRecognitionFailed());
    }
  }
}
