/// Ağ / sunucu katmanından fırlatılan temel istisna (`19_api_integration.md`).
abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
