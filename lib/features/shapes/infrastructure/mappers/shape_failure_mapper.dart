import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/features/shapes/infrastructure/repositories/shape_recognition_repository_impl.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShapeFailureMapper implements FailureMapper {

  ShapeFailureMapper(
    this._defaultMapper,
  );
  final FailureMapper _defaultMapper;

  @override
  Failure mapExceptionToFailure(Exception exception) {
    final defaultFailure = _defaultMapper.mapExceptionToFailure(exception);
    if (defaultFailure is UnexpectedFailure) {
      return ShapeRecognitionFailure(exception.toString());
    }
    return defaultFailure;
  }
}
