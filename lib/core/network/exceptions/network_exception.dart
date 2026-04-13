import 'package:abc123/core/network/exceptions/app_exception.dart';

/// Bağlantı, zaman aşımı ve benzeri ağ hataları (`19_api_integration.md`).
final class NetworkException extends AppException {
  const NetworkException({
    required String message,
    this.originalError,
  }) : super(message);

  final Object? originalError;
}
