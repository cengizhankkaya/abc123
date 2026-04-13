import 'package:abc123/core/error/failures/failure.dart';

/// Ağ bağlantısı hatası için [Failure] (`19_api_integration.md`, `08_error_handling.md`).
final class NetworkFailure extends Failure {
  const NetworkFailure({required this.message});

  final String message;

  @override
  String toString() => 'NetworkFailure: $message';
}
