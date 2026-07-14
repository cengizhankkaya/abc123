import 'dart:async';
import 'dart:convert';

import 'package:abc123/features/parent_panel/domain/entities/daily_activity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Ebeveyn Paneli: Günlük Ekran Süresi Kontrolü yöneticisi.
class ScreenTimeProvider extends ChangeNotifier {

  ScreenTimeProvider() {
    _loadSettings();
    _startTicker();
  }
  static const String _keyDailyLimitMinutes = 'parent_screen_time_limit_minutes';
  static const String _keyUsedSecondsToday = 'child_daily_screen_time_used_seconds';
  static const String _keyLastRecordedDate = 'child_daily_screen_time_last_date';
  static const String _keyDailySecondsHistory = 'parent_daily_seconds_history_json';
  static const String _keyDailyActivityCount = 'parent_daily_activities_count_json';

  int _dailyLimitMinutes = 0; // 0 = Sınırsız
  int _usedSecondsToday = 0;
  String _lastRecordedDateStr = '';
  bool _limitModalShown = false;
  Timer? _timer;

  final Map<String, int> _dailySecondsHistory = {};
  final Map<String, int> _dailyActivitiesCountHistory = {};

  int get dailyLimitMinutes => _dailyLimitMinutes;
  int get usedSecondsToday => _usedSecondsToday;
  bool get isLimitExceeded => _dailyLimitMinutes > 0 && _usedSecondsToday >= _dailyLimitMinutes * 60;
  bool get limitModalShown => _limitModalShown;

  void markModalShown() {
    _limitModalShown = true;
    notifyListeners();
  }

  void resetModalShown() {
    _limitModalShown = false;
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyLimitMinutes = prefs.getInt(_keyDailyLimitMinutes) ?? 0;
    _usedSecondsToday = prefs.getInt(_keyUsedSecondsToday) ?? 0;
    _lastRecordedDateStr = prefs.getString(_keyLastRecordedDate) ?? _getTodayDateStr();

    final secondsJson = prefs.getString(_keyDailySecondsHistory);
    if (secondsJson != null) {
      try {
        final decoded = jsonDecode(secondsJson) as Map<String, dynamic>;
        decoded.forEach((k, v) => _dailySecondsHistory[k] = (v as num).toInt());
      } catch (_) {}
    }
    final countJson = prefs.getString(_keyDailyActivityCount);
    if (countJson != null) {
      try {
        final decoded = jsonDecode(countJson) as Map<String, dynamic>;
        decoded.forEach((k, v) => _dailyActivitiesCountHistory[k] = (v as num).toInt());
      } catch (_) {}
    }

    if (_lastRecordedDateStr != _getTodayDateStr()) {
      // Yeni gün başladı, sayaç sıfırlanıyor
      _usedSecondsToday = 0;
      _lastRecordedDateStr = _getTodayDateStr();
      _limitModalShown = false;
      await prefs.setInt(_keyUsedSecondsToday, 0);
      await prefs.setString(_keyLastRecordedDate, _lastRecordedDateStr);
    }
    _dailySecondsHistory[_lastRecordedDateStr] = _usedSecondsToday;
    await prefs.setString(_keyDailySecondsHistory, jsonEncode(_dailySecondsHistory));
    notifyListeners();
  }

  String _getTodayDateStr() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_lastRecordedDateStr != _getTodayDateStr()) {
        _loadSettings();
      } else {
        _usedSecondsToday += 10;
        _persistUsedSeconds();
        if (isLimitExceeded && !_limitModalShown) {
          notifyListeners();
        }
      }
    });
  }

  Future<void> _persistUsedSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUsedSecondsToday, _usedSecondsToday);
    _dailySecondsHistory[_getTodayDateStr()] = _usedSecondsToday;
    await prefs.setString(_keyDailySecondsHistory, jsonEncode(_dailySecondsHistory));
    notifyListeners();
  }

  Future<void> recordActivityCompleted([int count = 1]) async {
    final today = _getTodayDateStr();
    _dailyActivitiesCountHistory[today] = (_dailyActivitiesCountHistory[today] ?? 0) + count;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDailyActivityCount, jsonEncode(_dailyActivitiesCountHistory));
    notifyListeners();
  }

  List<DailyActivity> getWeeklyActivityData() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      var seconds = _dailySecondsHistory[dateStr] ?? 0;
      if (dateStr == _getTodayDateStr()) {
        seconds = _usedSecondsToday;
      }
      var minutes = seconds ~/ 60;
      if (seconds > 0 && minutes == 0) {
        minutes = 1; // 1 dakikadan az ama 0 olmayan süreyi 1 dk göster
      }
      final tasks = _dailyActivitiesCountHistory[dateStr] ?? (minutes > 0 ? (minutes / 3).ceil() : 0);
      return DailyActivity(
        date: date,
        durationMinutes: minutes,
        completedActivitiesCount: tasks,
      );
    });
  }

  Future<void> setDailyLimitMinutes(int minutes) async {
    _dailyLimitMinutes = minutes;
    if (!isLimitExceeded) {
      _limitModalShown = false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyDailyLimitMinutes, _dailyLimitMinutes);
    notifyListeners();
  }

  /// Ebeveyn girişi sonrası bugünkü süreyi 15 dakika uzat
  Future<void> extendTodayBy15Minutes() async {
    _usedSecondsToday = (_dailyLimitMinutes * 60) - (15 * 60);
    if (_usedSecondsToday < 0) _usedSecondsToday = 0;
    _limitModalShown = false;
    await _persistUsedSeconds();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
