import 'package:abc123/core/error/failures/failure.dart';

/// Beklenmeyen teknik hata (ör. SharedPreferences / platform istisnası).
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required this.message,
    this.stackTrace,
  });

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'UnexpectedFailure($message)';
}
