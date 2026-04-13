import 'package:abc123/core/error/failures/failure.dart';

/// Sunucu / HTTP hatası için [Failure] (`19_api_integration.md`, `08_error_handling.md`).
final class ServerFailure extends Failure {
  const ServerFailure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  String toString() => 'ServerFailure($statusCode): $message';
}
