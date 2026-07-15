import 'package:abc123/core/error/failures/failure.dart' show Failure;

/// Sunucu tarafından dönen hatalar için exception (`01_project_structure.md` — core/error/exceptions).
///
/// Infrastructure katmanında fırlatılır; repository'ler bunu [Failure]'a
/// dönüştürerek domain katmanına iletir.
///
/// ```dart
/// try {
///   final response = await dio.get('/endpoint');
/// } on DioException catch (e) {
///   throw ServerException(
///     message: e.message ?? 'Bilinmeyen hata',
///     statusCode: e.response?.statusCode,
///   );
/// }
/// ```
class ServerException implements Exception {
  const ServerException({
    required this.message,
    this.statusCode,
  });

  /// İnsan tarafından okunabilir hata açıklaması.
  final String message;

  /// HTTP durum kodu (varsa).
  final int? statusCode;

  @override
  String toString() => 'ServerException(statusCode: $statusCode, message: $message)';
}

/// Önbellek / yerel depolama hatası.
class CacheException implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  String toString() => 'CacheException(message: $message)';
}

/// Ağ bağlantısı hatası — sunucu yanıtsız veya internet yok.
class NetworkException implements Exception {
  const NetworkException({this.message = 'İnternet bağlantısı yok.'});

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}
