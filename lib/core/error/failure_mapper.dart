import 'package:abc123/core/api/exceptions/network_exception.dart';
import 'package:abc123/core/api/exceptions/server_exception.dart';
import 'package:abc123/core/error/exceptions/server_exception.dart' as error_ex;
import 'package:abc123/core/error/failures/cache_failure.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/network_failure.dart';
import 'package:abc123/core/error/failures/server_failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';

import 'package:injectable/injectable.dart';

abstract class FailureMapper {
  Failure mapExceptionToFailure(Exception exception, [StackTrace? stackTrace]);
}

@LazySingleton(as: FailureMapper)
class DefaultFailureMapper implements FailureMapper {
  @override
  Failure mapExceptionToFailure(Exception exception, [StackTrace? stackTrace]) {
    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      );
    } else if (exception is error_ex.ServerException) {
      return ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode ?? 500,
        stackTrace: stackTrace,
      );
    } else if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        stackTrace: stackTrace,
      );
    } else if (exception is error_ex.NetworkException) {
      return NetworkFailure(
        message: exception.message,
        stackTrace: stackTrace,
      );
    } else if (exception is error_ex.CacheException) {
      return CacheFailure(
        message: exception.message,
        stackTrace: stackTrace,
      );
    } else {
      return UnexpectedFailure(
        message: exception.toString(),
        stackTrace: stackTrace ?? StackTrace.current,
      );
    }
  }
}
