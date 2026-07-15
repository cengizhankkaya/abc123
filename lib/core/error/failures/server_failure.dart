import 'package:abc123/core/error/failures/technical_failure.dart';

/// Sunucu / HTTP hatası için [TechnicalFailure] (`19_api_integration.md`, `08_error_handling.md`).
final class ServerFailure extends TechnicalFailure {
  const ServerFailure({
    required this.message,
    required this.statusCode,
    this.stackTrace,
  });

  final String message;
  final int statusCode;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  @override
  String toString() => 'ServerFailure($statusCode): $message';
}
