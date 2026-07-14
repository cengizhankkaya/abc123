import 'package:abc123/core/api/exceptions/network_exception.dart';
import 'package:abc123/core/api/exceptions/server_exception.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/network_failure.dart';
import 'package:abc123/core/error/failures/server_failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';

import 'package:injectable/injectable.dart';

abstract class FailureMapper {
  Failure mapExceptionToFailure(Exception exception);
}

@LazySingleton(as: FailureMapper)
class DefaultFailureMapper implements FailureMapper {
  @override
  Failure mapExceptionToFailure(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(message: exception.message, statusCode: exception.statusCode);
    } else if (exception is NetworkException) {
      return NetworkFailure(message: exception.message);
    } else {
      return UnexpectedFailure(message: exception.toString(), stackTrace: StackTrace.current);
    }
  }
}
