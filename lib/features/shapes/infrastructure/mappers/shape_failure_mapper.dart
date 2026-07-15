import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/features/shapes/domain/failure/shape_failure.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShapeFailureMapper implements FailureMapper {
  ShapeFailureMapper(
    this._defaultMapper,
  );
  final FailureMapper _defaultMapper;

  @override
  Failure mapExceptionToFailure(Exception exception, [StackTrace? stackTrace]) {
    final defaultFailure = _defaultMapper.mapExceptionToFailure(exception, stackTrace);
    if (defaultFailure is UnexpectedFailure) {
      return const ShapeRecognitionFailed();
    }
    return defaultFailure;
  }
}
