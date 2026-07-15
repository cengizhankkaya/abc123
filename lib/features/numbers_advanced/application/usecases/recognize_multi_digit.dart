import 'dart:typed_data';

import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/numbers_advanced/domain/repositories/i_multi_digit_recognition_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
final class RecognizeMultiDigit {
  const RecognizeMultiDigit(this._repository);
  final IMultiDigitRecognitionRepository _repository;

  FutureResult<int> recognizeDigit(Uint8List pngBytes) {
    return _repository.recognizeDigit(pngBytes);
  }

  FutureResult<int> recognizeMultiDigit({
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  }) {
    return _repository.recognizeMultiDigit(tensBytes: tensBytes, unitsBytes: unitsBytes);
  }

  FutureResult<int> recognizeTripleDigit({
    required Uint8List hundredsBytes,
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  }) {
    return _repository.recognizeTripleDigit(
      hundredsBytes: hundredsBytes,
      tensBytes: tensBytes,
      unitsBytes: unitsBytes,
    );
  }
}
