import 'dart:developer' as developer;

import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/logging/models/log_level.dart';
import 'package:flutter/foundation.dart';

/// Konsol / DevTools çıktısı (`17_logging.md` — [ConsoleLogger]).
///
/// [LogLevel.debug] yalnızca [kDebugMode]; [info]/[warning] release'te
/// varsayılan olarak kapalı (gürültü ve performans). [error]/[fatal] her ortamda.
final class ConsoleLogger implements AppLogger {
  ConsoleLogger({this.name = 'abc123'});

  final String name;

  static String _formatMessage(
    String message,
    Map<String, dynamic>? data,
    String? tag,
  ) {
    final buffer = StringBuffer();
    if (tag != null) {
      buffer.write('[$tag] ');
    }
    buffer.write(message);
    if (data != null && data.isNotEmpty) {
      buffer.write(' | Data: $data');
    }
    return buffer.toString();
  }

  void _emit(
    LogLevel level,
    String message, {
    Map<String, dynamic>? data,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level == LogLevel.debug && !kDebugMode) {
      return;
    }
    if (kReleaseMode && (level == LogLevel.info || level == LogLevel.warning)) {
      return;
    }

    final text = '${level.emoji} ${_formatMessage(message, data, tag)}';
    developer.log(
      text,
      name: name,
      level: _developerLevel(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static int _developerLevel(LogLevel level) {
    return switch (level) {
      LogLevel.debug => 500,
      LogLevel.info => 800,
      LogLevel.warning => 900,
      LogLevel.error => 1000,
      LogLevel.fatal => 1200,
    };
  }

  @override
  void debug(String message, {Map<String, dynamic>? data, String? tag}) {
    _emit(LogLevel.debug, message, data: data, tag: tag);
  }

  @override
  void info(String message, {Map<String, dynamic>? data, String? tag}) {
    _emit(LogLevel.info, message, data: data, tag: tag);
  }

  @override
  void warning(String message, {Map<String, dynamic>? data, String? tag}) {
    _emit(LogLevel.warning, message, data: data, tag: tag);
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
    String? tag,
  }) {
    _emit(
      LogLevel.error,
      message,
      data: data,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
    String? tag,
  }) {
    _emit(
      LogLevel.fatal,
      message,
      data: data,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
