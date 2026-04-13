import 'package:abc123/core/network/exceptions/app_exception.dart';

/// HTTP 4xx / 5xx cevapları (`19_api_integration.md`).
final class ServerException extends AppException {
  const ServerException({
    required String message,
    required this.statusCode,
  }) : super(message);

  final int statusCode;
}
