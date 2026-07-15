import 'dart:developer' as developer;

/// Performans ölçüm yardımcıları (`16_performance.md` §"Custom Performance Markers").
///
/// Kullanım:
/// ```dart
/// await PerformanceTrace.run('TFLite Inference', () async {
///   result = await model.runInference(input);
/// });
/// ```
abstract final class PerformanceTrace {
  /// Verilen [label] ile bir zaman dilimi başlatır, [action]'ı çalıştırır
  /// ve bitişte Timeline'ı kapatır.
  ///
  /// Sadece debug/profile modda etkindir; release'de no-op olarak derlenir.
  static Future<T> run<T>(
    String label,
    Future<T> Function() action,
  ) async {
    developer.Timeline.startSync(label);
    try {
      return await action();
    } finally {
      developer.Timeline.finishSync();
    }
  }

  /// Senkron işlemler için versiyon.
  static T runSync<T>(String label, T Function() action) {
    developer.Timeline.startSync(label);
    try {
      return action();
    } finally {
      developer.Timeline.finishSync();
    }
  }

  /// Flutter DevTools'da özel bir instant event işaretçisi ekler.
  ///
  /// Örnek: `PerformanceTrace.instant('Model Loaded');`
  static void instant(String name, [Map<String, Object>? args]) {
    developer.Timeline.instantSync(name, arguments: args);
  }
}
