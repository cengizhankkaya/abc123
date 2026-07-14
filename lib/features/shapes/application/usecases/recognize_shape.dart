import 'dart:typed_data';

import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/shapes/domain/repositories/i_shape_recognition_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

final class ShapeRecognitionFailed extends Failure {
  const ShapeRecognitionFailed();
}

@injectable
final class RecognizeShape {

  const RecognizeShape(this._repository);
  final IShapeRecognitionRepository _repository;

  FutureResult<String> call(Uint8List imageBytes) async {
    try {
      return await _repository.recognizeShape(imageBytes);
    } catch (e) {
      return const Left(ShapeRecognitionFailed());
    }
  }
}
