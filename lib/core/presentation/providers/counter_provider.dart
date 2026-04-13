import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  CounterProvider() {
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('reward_counter') ?? 0;
    notifyListeners();
  }

  Future<void> increment([int value = 1]) async {
    _counter += value;
    if (_counter > 500) {
      _counter = 500;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reward_counter', _counter);
    notifyListeners();
  }
}
