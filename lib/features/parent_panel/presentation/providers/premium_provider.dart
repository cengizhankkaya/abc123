import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Ebeveyn Paneli ve Paywall ekranı için Premium/Abonelik durumu yöneticisi.
class PremiumProvider extends ChangeNotifier {
  static const String _keyIsPremium = 'is_premium_subscription_active';
  static const String _keyExpiryDate = 'premium_subscription_expiry_date';

  bool _isPremium = false;
  DateTime? _expiryDate;
  bool _isLoading = true;

  bool get isPremium => _isPremium;
  DateTime? get expiryDate => _expiryDate;
  bool get isLoading => _isLoading;

  PremiumProvider() {
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_keyIsPremium) ?? false;
    final expiryStr = prefs.getString(_keyExpiryDate);
    if (expiryStr != null) {
      _expiryDate = DateTime.tryParse(expiryStr);
      if (_expiryDate != null && _expiryDate!.isBefore(DateTime.now())) {
        // Süresi dolmuşsa otomatik kapat
        _isPremium = false;
        await prefs.setBool(_keyIsPremium, false);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  /// Premium durumunu açıp kapatır (Test veya Satın alma simülasyonu için).
  Future<void> setPremiumStatus(bool active, {DateTime? expiry}) async {
    _isPremium = active;
    _expiryDate = expiry ?? (active ? DateTime.now().add(const Duration(days: 365)) : null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsPremium, _isPremium);
    if (_expiryDate != null) {
      await prefs.setString(_keyExpiryDate, _expiryDate!.toIso8601String());
    } else {
      await prefs.remove(_keyExpiryDate);
    }
    notifyListeners();
  }

  Future<void> togglePremium() async {
    await setPremiumStatus(!_isPremium);
  }
}
