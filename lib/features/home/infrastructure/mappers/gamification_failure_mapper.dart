import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/error/failures/cache_failure.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GamificationFailureMapper implements FailureMapper {
  GamificationFailureMapper(
    this._defaultMapper,
  );
  final FailureMapper _defaultMapper;

  @override
  Failure mapExceptionToFailure(Exception exception, [StackTrace? stackTrace]) {
    final defaultFailure = _defaultMapper.mapExceptionToFailure(exception, stackTrace);
    if (defaultFailure is UnexpectedFailure) {
      return CacheFailure(message: exception.toString(), stackTrace: stackTrace);
    }
    return defaultFailure;
  }
}
