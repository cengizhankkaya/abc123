import 'dart:async';
import 'dart:io';

import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/network/exceptions/app_exception.dart';
import 'package:abc123/core/network/exceptions/network_exception.dart';
import 'package:injectable/injectable.dart';

/// Ağ katmanı istisnalarını günlükler ve uygun [AppException]'a sarar (`19_api_integration.md`).
@lazySingleton
final class NetworkErrorHandler {
  NetworkErrorHandler(this._logger);

  final AppLogger _logger;

  /// Bilinen hataları [NetworkException] / [AppException] olarak yeniden fırlatır.
  Never handleError(Object error, StackTrace stackTrace) {
    if (error is AppException) {
      _logger.error(
        error.message,
        error: error,
        stackTrace: stackTrace,
        tag: 'Network',
      );
      throw error;
    }

    if (error is SocketException) {
      _logger.error(
        'Bağlantı hatası',
        error: error,
        stackTrace: stackTrace,
        tag: 'Network',
      );
      throw NetworkException(
        message: 'İnternet bağlantısı yok veya sunucuya ulaşılamıyor.',
        originalError: error,
      );
    }

    if (error is TimeoutException) {
      _logger.error(
        'İstek zaman aşımı',
        error: error,
        stackTrace: stackTrace,
        tag: 'Network',
      );
      throw NetworkException(
        message: 'İstek zaman aşımına uğradı.',
        originalError: error,
      );
    }

    _logger.error(
      'Ağ hatası',
      error: error,
      stackTrace: stackTrace,
      tag: 'Network',
    );
    throw NetworkException(
      message: error.toString(),
      originalError: error,
    );
  }
}
