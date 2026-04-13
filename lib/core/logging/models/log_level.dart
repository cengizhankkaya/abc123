/// Uygulama günlük seviyeleri (`17_logging.md`).
enum LogLevel {
  /// Geliştirme ayrıntıları.
  debug(0),

  /// Genel olaylar.
  info(1),

  /// Dikkat gerektiren durumlar.
  warning(2),

  /// Hata olayları.
  error(3),

  /// Kritik hatalar.
  fatal(4);

  const LogLevel(this.value);
  final int value;

  bool isEnabled(LogLevel minimumLevel) => value >= minimumLevel.value;

  String get emoji => switch (this) {
        LogLevel.debug => '🐛',
        LogLevel.info => 'ℹ️',
        LogLevel.warning => '⚠️',
        LogLevel.error => '❌',
        LogLevel.fatal => '💀',
      };
}
