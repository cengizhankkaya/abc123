import 'package:fpdart/fpdart.dart';
import 'package:abc123/core/types/types.dart';
import 'package:abc123/core/error/failures/failure.dart';
class StorageFailure extends Failure {}
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IGamificationPersistence)
class GamificationRepositoryImpl implements IGamificationPersistence {
  final SharedPreferences _prefs;

  GamificationRepositoryImpl(this._prefs);

  @override
  FutureResult<int?> getInt(String key) async {
    try { return Right(_prefs.getInt(key)); } catch (_) { return Left(StorageFailure()); }
  }

  @override
  FutureResult<Unit> setInt(String key, int value) async {
    try { await _prefs.setInt(key, value); return const Right(unit); } catch (_) { return Left(StorageFailure()); }
  }

  @override
  FutureResult<String?> getString(String key) async {
    try { return Right(_prefs.getString(key)); } catch (_) { return Left(StorageFailure()); }
  }

  @override
  FutureResult<Unit> setString(String key, String value) async {
    try { await _prefs.setString(key, value); return const Right(unit); } catch (_) { return Left(StorageFailure()); }
  }

  @override
  FutureResult<List<String>?> getStringList(String key) async {
    try { return Right(_prefs.getStringList(key)); } catch (_) { return Left(StorageFailure()); }
  }

  @override
  FutureResult<Unit> setStringList(String key, List<String> value) async {
    try { await _prefs.setStringList(key, value); return const Right(unit); } catch (_) { return Left(StorageFailure()); }
  }
}
