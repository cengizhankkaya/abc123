// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i31;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:synchronized/synchronized.dart' as _i409;

import '../../features/home/application/usecases/load_gamification_initial_state.dart'
    as _i522;
import '../../features/home/application/usecases/persist_drawing_counters.dart'
    as _i188;
import '../../features/home/domain/repositories/i_gamification_persistence.dart'
    as _i725;
import '../../features/home/infrastructure/datasources/gamification_shared_preferences_data_source.dart'
    as _i236;
import '../../features/home/presentation/providers/gamification_provider.dart'
    as _i1019;
import '../feature_flags/feature_flag_service.dart' as _i349;
import '../feature_flags/i_feature_flag_service.dart' as _i6;
import '../logging/app_logger.dart' as _i354;
import '../network/app_api_service.dart' as _i393;
import '../network/network_error_handler.dart' as _i42;
import '../storage/i_token_storage.dart' as _i163;
import '../storage/token_storage.dart' as _i973;
import 'modules/logging_module.dart' as _i767;
import 'modules/network_module.dart' as _i851;
import 'modules/storage_module.dart' as _i148;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final loggingModule = _$LoggingModule();
  final networkModule = _$NetworkModule();
  final storageModule = _$StorageModule();
  gh.lazySingleton<_i354.AppLogger>(() => loggingModule.appLogger());
  gh.lazySingleton<_i409.Lock>(() => networkModule.apiRefreshLock());
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => storageModule.sharedPreferences(),
    preResolve: true,
  );
  gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.flutterSecureStorage());
  gh.lazySingleton<_i42.NetworkErrorHandler>(
      () => _i42.NetworkErrorHandler(gh<_i354.AppLogger>()));
  gh.lazySingleton<_i6.IFeatureFlagService>(() => _i349.FeatureFlagService());
  gh.lazySingleton<_i163.ITokenStorage>(
      () => _i973.TokenStorage(gh<_i558.FlutterSecureStorage>()));
  gh.lazySingleton<_i725.IGamificationPersistence>(() =>
      _i236.GamificationSharedPreferencesDataSource(
          gh<_i460.SharedPreferences>()));
  gh.factory<_i522.LoadGamificationInitialState>(() =>
      _i522.LoadGamificationInitialState(gh<_i725.IGamificationPersistence>()));
  gh.factory<_i188.PersistDrawingCounters>(
      () => _i188.PersistDrawingCounters(gh<_i725.IGamificationPersistence>()));
  gh.singleton<_i31.ChopperClient>(() => networkModule.chopperClient(
        gh<_i354.AppLogger>(),
        gh<_i42.NetworkErrorHandler>(),
        gh<_i163.ITokenStorage>(),
        gh<_i409.Lock>(),
      ));
  gh.factory<_i1019.GamificationProvider>(() => _i1019.GamificationProvider(
        persistence: gh<_i725.IGamificationPersistence>(),
        loadInitial: gh<_i522.LoadGamificationInitialState>(),
        persistDrawingCounters: gh<_i188.PersistDrawingCounters>(),
        logger: gh<_i354.AppLogger>(),
      ));
  gh.lazySingleton<_i393.AppApiService>(
      () => networkModule.appApiService(gh<_i31.ChopperClient>()));
  return getIt;
}

class _$LoggingModule extends _i767.LoggingModule {}

class _$NetworkModule extends _i851.NetworkModule {}

class _$StorageModule extends _i148.StorageModule {}
