import 'package:abc123/core/error/failures/technical_failure.dart';

/// Önbellek ve yerel veri depolama (Storage / SharedPreferences) hataları (`08_error_handling.md`).
final class CacheFailure extends TechnicalFailure {
  const CacheFailure({
    this.message = 'Önbellek/veri depolama işlemi başarısız oldu.',
    this.stackTrace,
  });

  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  @override
  String toString() => 'CacheFailure: $message';
}
