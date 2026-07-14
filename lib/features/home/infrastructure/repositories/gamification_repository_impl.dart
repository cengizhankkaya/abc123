import 'package:abc123/core/error/exception_handler.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/types/types.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:abc123/features/home/infrastructure/datasources/gamification_local_data_source.dart';
import 'package:abc123/features/home/infrastructure/mappers/gamification_failure_mapper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

class StorageFailure extends Failure {
  const StorageFailure();
}

@LazySingleton(as: IGamificationPersistence)
class GamificationRepositoryImpl extends BaseRepository implements IGamificationPersistence {

  GamificationRepositoryImpl(
    this._localDataSource,
    ExceptionHandler exceptionHandler,
    GamificationFailureMapper failureMapper,
  ) : super(exceptionHandler, failureMapper);
  final IGamificationLocalDataSource _localDataSource;

  @override
  FutureResult<int?> getInt(String key) => execute(() async => _localDataSource.getInt(key));

  @override
  FutureResult<Unit> setInt(String key, int value) => execute(() async {
    await _localDataSource.setInt(key, value);
    return unit;
  });

  @override
  FutureResult<String?> getString(String key) => execute(() async => _localDataSource.getString(key));

  @override
  FutureResult<Unit> setString(String key, String value) => execute(() async {
    await _localDataSource.setString(key, value);
    return unit;
  });

  @override
  FutureResult<List<String>?> getStringList(String key) => execute(() async => _localDataSource.getStringList(key));

  @override
  FutureResult<Unit> setStringList(String key, List<String> value) => execute(() async {
    await _localDataSource.setStringList(key, value);
    return unit;
  });
}
