/// Yapılandırılabilir uygulama günlüğü (`17_logging.md`).
abstract interface class AppLogger {
  void debug(
    String message, {
    Map<String, dynamic>? data,
    String? tag,
  });

  void info(
    String message, {
    Map<String, dynamic>? data,
    String? tag,
  });

  void warning(
    String message, {
    Map<String, dynamic>? data,
    String? tag,
  });

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
    String? tag,
  });

  void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
    String? tag,
  });
}
