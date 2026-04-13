import 'dart:async';

import 'package:abc123/core/network/exceptions/server_exception.dart';
import 'package:abc123/core/network/network_error_handler.dart';
import 'package:chopper/chopper.dart';

/// Başarısız HTTP yanıtlarını [ServerException]'a çevirir (`19_api_integration.md`).
final class ErrorInterceptor implements Interceptor {
  const ErrorInterceptor(this._networkErrorHandler);

  final NetworkErrorHandler _networkErrorHandler;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    try {
      final response = await chain.proceed(chain.request);

      if (!response.isSuccessful) {
        _throwFromResponse(response);
      }

      return response;
    } catch (error, stackTrace) {
      _networkErrorHandler.handleError(error, stackTrace);
    }
  }

  Never _throwFromResponse(Response<dynamic> response) {
    throw ServerException(
      message: _extractErrorMessage(response),
      statusCode: response.statusCode,
    );
  }

  String _extractErrorMessage(Response<dynamic> response) {
    final body = response.body;
    if (body is Map<String, dynamic>) {
      final msg = body['message'] ?? body['error'] ?? body['detail'];
      if (msg is String && msg.isNotEmpty) return msg;
    }
    if (body is String && body.isNotEmpty) return body;
    return 'HTTP ${response.statusCode}';
  }
}
