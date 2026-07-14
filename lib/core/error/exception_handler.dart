import 'package:abc123/core/logging/app_logger.dart';
import 'package:injectable/injectable.dart';

abstract class ExceptionHandler {
  Exception handleException(Object error, StackTrace stackTrace);
}

@LazySingleton(as: ExceptionHandler)
class ExceptionHandlerImpl implements ExceptionHandler {

  ExceptionHandlerImpl(this._logger);
  final AppLogger _logger;

  @override
  Exception handleException(Object error, StackTrace stackTrace) {
    _logger.error(
      'Repository exception caught',
      error: error,
      stackTrace: stackTrace,
      tag: 'ExceptionHandler',
    );
    
    if (error is Exception) {
      return error;
    }
    
    return Exception(error.toString());
  }
}
