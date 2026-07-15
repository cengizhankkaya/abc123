import 'package:abc123/core/error/failures/technical_failure.dart';

/// Beklenmeyen teknik hata (ör. SharedPreferences / platform istisnası).
final class UnexpectedFailure extends TechnicalFailure {
  const UnexpectedFailure({
    required this.message,
    this.stackTrace,
  });

  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  @override
  String toString() => 'UnexpectedFailure($message)';
}
