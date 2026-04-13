/// Yerel oyun durumu kalıcılığı için domain portu (`I` öneki — 03_domain_layer).
abstract class IGamificationPersistence {
  Future<int?> getInt(String key);
  Future<void> setInt(String key, int value);

  Future<String?> getString(String key);
  Future<void> setString(String key, String value);

  Future<List<String>?> getStringList(String key);
  Future<void> setStringList(String key, List<String> value);
}
