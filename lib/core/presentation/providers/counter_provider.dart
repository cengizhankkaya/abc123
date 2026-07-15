import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier {
  CounterProvider(this._prefs) {
    _loadCounter();
  }

  final SharedPreferences _prefs;
  static const _key = 'reward_counter';

  int _counter = 0;
  int get counter => _counter;

  void _loadCounter() {
    _counter = _prefs.getInt(_key) ?? 0;
    notifyListeners();
  }

  Future<void> increment([int value = 1]) async {
    final next = (_counter + value).clamp(0, 500);
    if (next == _counter) return;
    _counter = next;
    await _prefs.setInt(_key, _counter);
    notifyListeners();
  }
}
