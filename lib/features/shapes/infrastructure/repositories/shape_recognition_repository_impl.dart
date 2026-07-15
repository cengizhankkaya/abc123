import 'dart:typed_data';

import 'package:abc123/core/error/exception_handler.dart';
import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/shapes/domain/repositories/i_shape_recognition_repository.dart';
import 'package:abc123/features/shapes/infrastructure/datasources/shape_inference_data_source.dart';
import 'package:abc123/features/shapes/infrastructure/mappers/shape_failure_mapper.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IShapeRecognitionRepository)
final class ShapeRecognitionRepositoryImpl extends BaseRepository
    implements IShapeRecognitionRepository {
  ShapeRecognitionRepositoryImpl(
    this._dataSource,
    ExceptionHandler exceptionHandler,
    ShapeFailureMapper failureMapper,
  ) : super(exceptionHandler, failureMapper);
  final IShapeInferenceDataSource _dataSource;

  @override
  FutureResult<String> recognizeShape(Uint8List imageBytes) => execute(() async {
        return _dataSource.recognizeShape(imageBytes);
      });
}
