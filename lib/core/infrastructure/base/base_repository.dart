import 'package:abc123/core/error/exception_handler.dart';
import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/types/result.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseRepository {

  BaseRepository(this.exceptionHandler, this.failureMapper);
  final ExceptionHandler exceptionHandler;
  final FailureMapper failureMapper;

  FutureResult<T> execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return right(result);
    } catch (e, st) {
      final exception = exceptionHandler.handleException(e, st);
      final failure = failureMapper.mapExceptionToFailure(exception);
      return left(failure);
    }
  }
}
