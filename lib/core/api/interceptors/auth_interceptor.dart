import 'dart:async';

import 'package:chopper/chopper.dart';

/// İsteklere `Authorization: Bearer` ekler (`19_api_integration.md`).
final class AuthInterceptor implements Interceptor {
  const AuthInterceptor(this._getToken);

  final Future<String?> Function() _getToken;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final token = await _getToken();
    final request = token != null
        ? applyHeader(chain.request, 'Authorization', 'Bearer $token')
        : chain.request;
    return chain.proceed(request);
  }
}
