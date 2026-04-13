import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/logging/loggers/console_logger.dart';
import 'package:injectable/injectable.dart';

/// [AppLogger] kaydı (`17_logging.md`, `09_dependency_injection.md`).
@module
abstract class LoggingModule {
  @lazySingleton
  AppLogger appLogger() => ConsoleLogger();
}
