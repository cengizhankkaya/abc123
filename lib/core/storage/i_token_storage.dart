/// Oturum belirteçleri için soyutlama (`15_security.md`).
abstract interface class ITokenStorage {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveTokens({
    String? accessToken,
    String? refreshToken,
  });

  Future<void> clearTokens();
}
