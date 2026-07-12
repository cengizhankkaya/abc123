import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:abc123/core/domain/ports/i_token_storage.dart';

/// [FlutterSecureStorage] ile belirteç saklama (`15_security.md`).
@LazySingleton(as: ITokenStorage)
class TokenStorage implements ITokenStorage {
  TokenStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';

  @override
  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() => _secureStorage.read(key: _refreshTokenKey);

  @override
  Future<void> saveTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
    ]);
  }
}
