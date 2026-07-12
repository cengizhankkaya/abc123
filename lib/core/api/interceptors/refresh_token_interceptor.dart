import 'dart:async';
import 'dart:convert';

import 'package:abc123/core/domain/ports/i_token_storage.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:synchronized/synchronized.dart';

/// 401 sonrası yenileme ve isteği tekrarlama (`19_api_integration.md`).
///
/// Sunucunun `POST {refreshFullPath}` gövdesinde `refresh_token`, yanıtta
/// `access_token` / `refresh_token` (veya camelCase eşdeğerleri) beklediği varsayılır.
final class RefreshTokenInterceptor implements Interceptor {
  RefreshTokenInterceptor({
    required ITokenStorage tokenStorage,
    required String refreshFullPath,
    required Uri apiBaseUri,
    required Lock refreshLock,
    required void Function() onRefreshFailed,
  })  : _tokenStorage = tokenStorage,
        _refreshUri = apiBaseUri.resolve(refreshFullPath),
        _lock = refreshLock,
        _onRefreshFailed = onRefreshFailed;

  final ITokenStorage _tokenStorage;
  final Uri _refreshUri;
  final Lock _lock;
  final void Function() _onRefreshFailed;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);

    if (response.statusCode != 401) {
      return response;
    }

    if (_isRefreshRequest(chain.request)) {
      _onRefreshFailed();
      return response;
    }

    final newToken = await _refreshAccessToken();
    if (newToken == null) {
      _onRefreshFailed();
      return response;
    }

    final newRequest = applyHeader(
      chain.request,
      'Authorization',
      'Bearer $newToken',
    );

    return chain.proceed(newRequest);
  }

  bool _isRefreshRequest(Request request) {
    return request.url.path == _refreshUri.path;
  }

  Future<String?> _refreshAccessToken() {
    return _lock.synchronized(_performRefresh);
  }

  Future<String?> _performRefresh() async {
    final refresh = await _tokenStorage.getRefreshToken();
    if (refresh == null) return null;

    try {
      final res = await http.post(
        _refreshUri,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refresh}),
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        return null;
      }

      final decoded = jsonDecode(res.body);
      if (decoded is! Map<String, dynamic>) return null;

      final access = decoded['access_token'] ?? decoded['accessToken'];
      if (access is! String || access.isEmpty) return null;

      final newRefresh = decoded['refresh_token'] ?? decoded['refreshToken'];
      await _tokenStorage.saveTokens(
        accessToken: access,
        refreshToken: newRefresh is String ? newRefresh : null,
      );

      return access;
    } on Object {
      return null;
    }
  }
}
