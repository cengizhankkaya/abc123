import 'package:abc123/core/error/failures/technical_failure.dart';

/// Ağ bağlantısı hatası için [TechnicalFailure] (`19_api_integration.md`, `08_error_handling.md`).
final class NetworkFailure extends TechnicalFailure {
  const NetworkFailure({
    this.message = 'İnternet bağlantısı yok.',
    this.stackTrace,
  });

  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  @override
  String toString() => 'NetworkFailure: $message';
}
