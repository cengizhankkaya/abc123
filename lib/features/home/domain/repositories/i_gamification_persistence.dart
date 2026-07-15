/// Yerel oyun durumu kalıcılığı için domain portu (`I` öneki — 03_domain_layer).
library;

import 'package:abc123/core/types/types.dart';
import 'package:fpdart/fpdart.dart';

abstract class IGamificationPersistence {
  FutureResult<int?> getInt(String key);
  FutureResult<Unit> setInt(String key, int value);

  FutureResult<String?> getString(String key);
  FutureResult<Unit> setString(String key, String value);

  FutureResult<List<String>?> getStringList(String key);
  FutureResult<Unit> setStringList(String key, List<String> value);
}
