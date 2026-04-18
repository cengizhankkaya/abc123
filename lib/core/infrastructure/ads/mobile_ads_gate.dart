import 'dart:async';

/// iOS’ta reklam SDK’sı başlatılmadan önce ATT gösterildiği için, reklam yükleri
/// bu [Future] tamamlanana kadar bekler. Android’de `bootstrap` içinde tamamlanır.
class MobileAdsGate {
  MobileAdsGate._();

  static final Completer<void> _ready = Completer<void>();

  static Future<void> get whenReady => _ready.future;

  static void markReady() {
    if (!_ready.isCompleted) {
      _ready.complete();
    }
  }
}
