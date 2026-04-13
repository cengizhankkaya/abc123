import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Yerel kalıcılık adaptörü (`05_infrastructure_layer` — datasources).
///
/// Domain portu [IGamificationPersistence] için SharedPreferences uygulaması.
@LazySingleton(as: IGamificationPersistence)
final class GamificationSharedPreferencesDataSource implements IGamificationPersistence {
  GamificationSharedPreferencesDataSource(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<int?> getInt(String key) async => _prefs.getInt(key);

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async => _prefs.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }
}
