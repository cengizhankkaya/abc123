import 'dart:async';
import 'dart:convert';

import 'package:abc123/core/logging/app_logger.dart';
import 'package:chopper/chopper.dart';

const int _kMaxLoggedBodyLength = 1000;

final _sensitiveHeaderKeys = {
  'authorization',
  'cookie',
  'set-cookie',
  'x-api-key',
  'api-key',
};

final _sensitiveBodyKeys = {
  'password',
  'token',
  'access_token',
  'refresh_token',
  'secret',
  'authorization',
};

/// İstek/yanıt günlüğü; hassas alanları maskele (`19_api_integration.md`).
final class LoggingInterceptor implements Interceptor {
  const LoggingInterceptor(this._logger);

  final AppLogger _logger;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final stopwatch = Stopwatch()..start();
    _logRequest(chain.request);

    try {
      final response = await chain.proceed(chain.request);
      stopwatch.stop();
      _logResponse(response, stopwatch.elapsedMilliseconds);
      return response;
    } catch (error, stackTrace) {
      stopwatch.stop();
      _logError(chain.request, error, stackTrace, stopwatch.elapsedMilliseconds);
      rethrow;
    }
  }

  void _logRequest(Request request) {
    final headers = _sanitizeHeaders(request.headers);
    final body = _stringifyAndRedactBody(request.body);
    _logger.debug(
      '${request.method} ${request.url}',
      data: {
        'headers': headers,
        if (body != null) 'body': body,
      },
      tag: 'HTTP',
    );
  }

  void _logResponse(Response<dynamic> response, int elapsedMs) {
    final body = _truncate(_stringifyBody(response.body));
    _logger.debug(
      '${response.statusCode} (${elapsedMs}ms)',
      data: body != null ? {'body': body} : null,
      tag: 'HTTP',
    );
  }

  void _logError(
    Request request,
    Object error,
    StackTrace stackTrace,
    int elapsedMs,
  ) {
    _logger.error(
      '${request.method} ${request.url} başarısız (${elapsedMs}ms)',
      error: error,
      stackTrace: stackTrace,
      tag: 'HTTP',
    );
  }

  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    return {
      for (final e in headers.entries)
        e.key: _sensitiveHeaderKeys.contains(e.key.toLowerCase())
            ? '***REDACTED***'
            : e.value,
    };
  }

  String? _stringifyAndRedactBody(Object? body) {
    if (body == null) return null;
    try {
      if (body is Map<String, dynamic>) {
        final redacted = _redactMap(body);
        return jsonEncode(redacted);
      }
      if (body is String) {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          return jsonEncode(_redactMap(decoded));
        }
        return _truncate(body);
      }
      return _truncate(body.toString());
    } on Object {
      return _truncate(body.toString());
    }
  }

  String? _stringifyBody(Object? body) {
    if (body == null) return null;
    if (body is String) return _truncate(body);
    try {
      return _truncate(jsonEncode(body));
    } on Object {
      return _truncate(body.toString());
    }
  }

  Map<String, dynamic> _redactMap(Map<String, dynamic> map) {
    return {
      for (final e in map.entries)
        e.key: _sensitiveBodyKeys.contains(e.key.toLowerCase())
            ? '***REDACTED***'
            : e.value is Map<String, dynamic>
                ? _redactMap(e.value as Map<String, dynamic>)
                : e.value,
    };
  }

  String? _truncate(String? s) {
    if (s == null) return null;
    if (s.length <= _kMaxLoggedBodyLength) return s;
    return '${s.substring(0, _kMaxLoggedBodyLength)}… (${s.length} karakter)';
  }
}
