// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i31;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:synchronized/synchronized.dart' as _i409;

import '../../features/colors/application/usecases/get_color_palettes.dart'
    as _i920;
import '../../features/colors/domain/repositories/i_color_game_repository.dart'
    as _i1025;
import '../../features/colors/infrastructure/repositories/color_game_repository_impl.dart'
    as _i601;
import '../../features/colors/presentation/failure_message/color_failure_message_mapper.dart'
    as _i744;
import '../../features/draw/application/usecases/recognize_letter.dart'
    as _i222;
import '../../features/draw/application/usecases/recognize_number.dart'
    as _i409;
import '../../features/draw/domain/repositories/i_number_recognition_repository.dart'
    as _i826;
import '../../features/draw/domain/repositories/i_recognition_repository.dart'
    as _i330;
import '../../features/draw/infrastructure/repositories/letter_recognition_repository_impl.dart'
    as _i857;
import '../../features/draw/infrastructure/repositories/number_recognition_repository_impl.dart'
    as _i502;
import '../../features/draw/presentation/failure_message/draw_failure_message_mapper.dart'
    as _i510;
import '../../features/draw/presentation/providers/draw_screen_provider.dart'
    as _i879;
import '../../features/home/application/quest/quest_rollover_resolver.dart'
    as _i1018;
import '../../features/home/application/usecases/load_gamification_initial_state.dart'
    as _i522;
import '../../features/home/application/usecases/persist_drawing_counters.dart'
    as _i188;
import '../../features/home/application/usecases/persist_quest_ledger.dart'
    as _i110;
import '../../features/home/domain/repositories/i_gamification_persistence.dart'
    as _i725;
import '../../features/home/infrastructure/datasources/gamification_local_data_source.dart'
    as _i977;
import '../../features/home/infrastructure/mappers/gamification_failure_mapper.dart'
    as _i605;
import '../../features/home/infrastructure/repositories/gamification_repository_impl.dart'
    as _i603;
import '../../features/home/presentation/failure_message/home_failure_message_mapper.dart'
    as _i24;
import '../../features/home/presentation/providers/gamification_provider.dart'
    as _i1019;
import '../../features/info/presentation/failure_message/info_failure_message_mapper.dart'
    as _i565;
import '../../features/letters/presentation/failure_message/letter_failure_message_mapper.dart'
    as _i602;
import '../../features/letters/presentation/providers/letter_drawing_provider.dart'
    as _i961;
import '../../features/numbers_advanced/application/usecases/recognize_multi_digit.dart'
    as _i558;
import '../../features/numbers_advanced/data/repositories/math_progress_repository_impl.dart'
    as _i208;
import '../../features/numbers_advanced/domain/repositories/i_math_progress_repository.dart'
    as _i769;
import '../../features/numbers_advanced/domain/repositories/i_multi_digit_recognition_repository.dart'
    as _i866;
import '../../features/numbers_advanced/infrastructure/repositories/multi_digit_recognition_repository_impl.dart'
    as _i27;
import '../../features/numbers_advanced/presentation/failure_message/math_failure_message_mapper.dart'
    as _i270;
import '../../features/numbers_advanced/presentation/providers/math_progress_provider.dart'
    as _i96;
import '../../features/parent_panel/application/usecases/get_recommendations.dart'
    as _i126;
import '../../features/parent_panel/domain/repositories/i_recommendation_repository.dart'
    as _i31;
import '../../features/parent_panel/infrastructure/repositories/recommendation_repository_impl.dart'
    as _i389;
import '../../features/parent_panel/presentation/failure_message/parent_panel_failure_message_mapper.dart'
    as _i869;
import '../../features/shapes/application/usecases/recognize_shape.dart'
    as _i865;
import '../../features/shapes/domain/repositories/i_shape_recognition_repository.dart'
    as _i787;
import '../../features/shapes/infrastructure/datasources/shape_inference_data_source.dart'
    as _i598;
import '../../features/shapes/infrastructure/mappers/shape_failure_mapper.dart'
    as _i997;
import '../../features/shapes/infrastructure/repositories/shape_recognition_repository_impl.dart'
    as _i813;
import '../../features/shapes/presentation/failure_message/shape_failure_message_mapper.dart'
    as _i300;
import '../../features/shapes/presentation/providers/shapes_drawing_provider.dart'
    as _i93;
import '../../features/words/application/usecases/get_word_list.dart' as _i645;
import '../../features/words/domain/repositories/i_word_repository.dart'
    as _i739;
import '../../features/words/infrastructure/repositories/word_repository_impl.dart'
    as _i239;
import '../../features/words/presentation/failure_message/word_failure_message_mapper.dart'
    as _i671;
import '../../features/words/presentation/providers/word_drawing_provider.dart'
    as _i337;
import '../api/app_api_service.dart' as _i22;
import '../api/network_error_handler.dart' as _i578;
import '../constants/language_constants.dart' as _i721;
import '../domain/ports/i_ad_service.dart' as _i654;
import '../domain/ports/i_app_review_service.dart' as _i616;
import '../domain/ports/i_audio_service.dart' as _i951;
import '../domain/ports/i_feature_flag_service.dart' as _i624;
import '../domain/ports/i_remote_config_service.dart' as _i705;
import '../domain/ports/i_token_storage.dart' as _i449;
import '../domain/ports/i_url_launcher.dart' as _i777;
import '../error/exception_handler.dart' as _i747;
import '../error/failure_mapper.dart' as _i537;
import '../infrastructure/ads/ad_service.dart' as _i464;
import '../infrastructure/audio/audio_service.dart' as _i710;
import '../infrastructure/feature_flags/feature_flag_service.dart' as _i600;
import '../infrastructure/remote_config/remote_config_service.dart' as _i840;
import '../infrastructure/review/app_review_service.dart' as _i505;
import '../infrastructure/security/url_launch_guard.dart' as _i588;
import '../infrastructure/storage/token_storage.dart' as _i1006;
import '../logging/app_logger.dart' as _i354;
import '../presentation/services/failure_message_mapper.dart' as _i1010;
import '../presentation/services/failure_message_service.dart' as _i242;
import 'modules/failure_mappers_module.dart' as _i722;
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
  final failureMappersModule = _$FailureMappersModule();
  gh.factory<_i1018.QuestRolloverResolver>(
      () => _i1018.QuestRolloverResolver());
  gh.lazySingleton<_i354.AppLogger>(() => loggingModule.appLogger());
  gh.lazySingleton<_i409.Lock>(() => networkModule.apiRefreshLock());
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => storageModule.sharedPreferences(),
    preResolve: true,
  );
  gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.flutterSecureStorage());
  gh.lazySingleton<_i744.ColorFailureMessageMapper>(
      () => _i744.ColorFailureMessageMapper());
  gh.lazySingleton<_i510.DrawFailureMessageMapper>(
      () => _i510.DrawFailureMessageMapper());
  gh.lazySingleton<_i24.HomeFailureMessageMapper>(
      () => _i24.HomeFailureMessageMapper());
  gh.lazySingleton<_i565.InfoFailureMessageMapper>(
      () => _i565.InfoFailureMessageMapper());
  gh.lazySingleton<_i602.LetterFailureMessageMapper>(
      () => _i602.LetterFailureMessageMapper());
  gh.lazySingleton<_i270.MathFailureMessageMapper>(
      () => _i270.MathFailureMessageMapper());
  gh.lazySingleton<_i869.ParentPanelFailureMessageMapper>(
      () => _i869.ParentPanelFailureMessageMapper());
  gh.lazySingleton<_i300.ShapeFailureMessageMapper>(
      () => _i300.ShapeFailureMessageMapper());
  gh.lazySingleton<_i671.WordFailureMessageMapper>(
      () => _i671.WordFailureMessageMapper());
  gh.lazySingleton<_i598.IShapeInferenceDataSource>(
      () => _i598.ShapeInferenceDataSourceImpl());
  gh.lazySingleton<_i951.IAudioService>(() => _i710.AudioService(
        gh<_i354.AppLogger>(),
        gh<_i460.SharedPreferences>(),
      ));
  gh.lazySingleton<_i578.NetworkErrorHandler>(
      () => _i578.NetworkErrorHandler(gh<_i354.AppLogger>()));
  gh.lazySingleton<_i747.ExceptionHandler>(
      () => _i747.ExceptionHandlerImpl(gh<_i354.AppLogger>()));
  gh.lazySingleton<List<_i1010.FailureMessageMapper>>(
      () => failureMappersModule.provideFailureMessageMappers(
            gh<_i270.MathFailureMessageMapper>(),
            gh<_i565.InfoFailureMessageMapper>(),
            gh<_i744.ColorFailureMessageMapper>(),
            gh<_i510.DrawFailureMessageMapper>(),
            gh<_i602.LetterFailureMessageMapper>(),
            gh<_i300.ShapeFailureMessageMapper>(),
            gh<_i869.ParentPanelFailureMessageMapper>(),
            gh<_i24.HomeFailureMessageMapper>(),
            gh<_i671.WordFailureMessageMapper>(),
          ));
  gh.lazySingleton<_i537.FailureMapper>(() => _i537.DefaultFailureMapper());
  gh.lazySingleton<_i705.IRemoteConfigService>(
      () => _i840.RemoteConfigService());
  gh.lazySingleton<_i777.IUrlLauncher>(() => const _i588.UrlLaunchGuardImpl());
  gh.lazySingleton<_i739.IWordRepository>(() => _i239.WordRepositoryImpl(
        gh<_i747.ExceptionHandler>(),
        gh<_i537.FailureMapper>(),
      ));
  gh.lazySingleton<_i616.IAppReviewService>(() => _i505.AppReviewService());
  gh.lazySingleton<_i866.IMultiDigitRecognitionRepository>(
      () => _i27.MultiDigitRecognitionRepositoryImpl(
            gh<_i747.ExceptionHandler>(),
            gh<_i537.FailureMapper>(),
            gh<_i354.AppLogger>(),
          ));
  gh.lazySingleton<_i330.IRecognitionRepository>(
      () => _i857.LetterRecognitionRepositoryImpl(
            gh<_i747.ExceptionHandler>(),
            gh<_i537.FailureMapper>(),
          ));
  gh.lazySingleton<_i826.INumberRecognitionRepository>(
      () => _i502.NumberRecognitionRepositoryImpl(
            gh<_i747.ExceptionHandler>(),
            gh<_i537.FailureMapper>(),
          ));
  gh.lazySingleton<_i624.IFeatureFlagService>(() => _i600.FeatureFlagService());
  gh.lazySingleton<_i31.IRecommendationRepository>(
      () => _i389.RecommendationRepositoryImpl(
            gh<_i747.ExceptionHandler>(),
            gh<_i537.FailureMapper>(),
          ));
  gh.factory<_i222.RecognizeLetter>(
      () => _i222.RecognizeLetter(gh<_i330.IRecognitionRepository>()));
  gh.lazySingleton<_i769.IMathProgressRepository>(
      () => _i208.MathProgressRepositoryImpl(gh<_i460.SharedPreferences>()));
  gh.factory<_i126.GetRecommendations>(
      () => _i126.GetRecommendations(gh<_i31.IRecommendationRepository>()));
  gh.lazySingleton<_i977.IGamificationLocalDataSource>(() =>
      _i977.GamificationLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i605.GamificationFailureMapper>(
      () => _i605.GamificationFailureMapper(gh<_i537.FailureMapper>()));
  gh.lazySingleton<_i997.ShapeFailureMapper>(
      () => _i997.ShapeFailureMapper(gh<_i537.FailureMapper>()));
  gh.lazySingleton<_i449.ITokenStorage>(
      () => _i1006.TokenStorage(gh<_i558.FlutterSecureStorage>()));
  gh.lazySingleton<_i725.IGamificationPersistence>(
      () => _i603.GamificationRepositoryImpl(
            gh<_i977.IGamificationLocalDataSource>(),
            gh<_i747.ExceptionHandler>(),
            gh<_i605.GamificationFailureMapper>(),
          ));
  gh.factory<_i558.RecognizeMultiDigit>(() =>
      _i558.RecognizeMultiDigit(gh<_i866.IMultiDigitRecognitionRepository>()));
  gh.lazySingleton<_i1025.IColorGameRepository>(
      () => _i601.ColorGameRepositoryImpl(
            gh<_i747.ExceptionHandler>(),
            gh<_i537.FailureMapper>(),
          ));
  gh.lazySingleton<_i242.FailureMessageService>(() =>
      _i242.FailureMessageService(gh<List<_i1010.FailureMessageMapper>>()));
  gh.lazySingleton<_i654.IAdService>(() => _i464.AdService(
        gh<_i354.AppLogger>(),
        gh<_i624.IFeatureFlagService>(),
      ));
  gh.factory<_i961.LetterDrawingProvider>(() => _i961.LetterDrawingProvider(
        gh<_i222.RecognizeLetter>(),
        gh<_i951.IAudioService>(),
        gh<_i354.AppLogger>(),
      ));
  gh.factory<_i409.RecognizeNumber>(
      () => _i409.RecognizeNumber(gh<_i826.INumberRecognitionRepository>()));
  gh.factory<_i645.GetWordList>(
      () => _i645.GetWordList(gh<_i739.IWordRepository>()));
  gh.factory<_i920.GetColorPalettes>(
      () => _i920.GetColorPalettes(gh<_i1025.IColorGameRepository>()));
  gh.factory<_i522.LoadGamificationInitialState>(() =>
      _i522.LoadGamificationInitialState(gh<_i725.IGamificationPersistence>()));
  gh.factory<_i188.PersistDrawingCounters>(
      () => _i188.PersistDrawingCounters(gh<_i725.IGamificationPersistence>()));
  gh.factory<_i110.PersistQuestLedger>(
      () => _i110.PersistQuestLedger(gh<_i725.IGamificationPersistence>()));
  gh.factory<_i337.WordDrawingProvider>(() => _i337.WordDrawingProvider(
        gh<_i222.RecognizeLetter>(),
        gh<_i645.GetWordList>(),
        gh<_i951.IAudioService>(),
        gh<_i354.AppLogger>(),
      ));
  gh.lazySingleton<_i787.IShapeRecognitionRepository>(
      () => _i813.ShapeRecognitionRepositoryImpl(
            gh<_i598.IShapeInferenceDataSource>(),
            gh<_i747.ExceptionHandler>(),
            gh<_i997.ShapeFailureMapper>(),
          ));
  gh.singleton<_i31.ChopperClient>(() => networkModule.chopperClient(
        gh<_i354.AppLogger>(),
        gh<_i578.NetworkErrorHandler>(),
        gh<_i449.ITokenStorage>(),
        gh<_i409.Lock>(),
      ));
  gh.factoryParam<_i879.DrawScreenProvider, _i409.BuildContext?,
      _i721.AppLanguage?>((
    context,
    language,
  ) =>
      _i879.DrawScreenProvider(
        recognizeNumberUseCase: gh<_i409.RecognizeNumber>(),
        audioService: gh<_i951.IAudioService>(),
        appLogger: gh<_i354.AppLogger>(),
        context: context,
        language: language,
      ));
  gh.factory<_i1019.GamificationProvider>(() => _i1019.GamificationProvider(
        persistence: gh<_i725.IGamificationPersistence>(),
        loadInitial: gh<_i522.LoadGamificationInitialState>(),
        persistDrawingCounters: gh<_i188.PersistDrawingCounters>(),
        persistQuestLedger: gh<_i110.PersistQuestLedger>(),
        questRolloverResolver: gh<_i1018.QuestRolloverResolver>(),
        logger: gh<_i354.AppLogger>(),
      ));
  gh.factory<_i865.RecognizeShape>(
      () => _i865.RecognizeShape(gh<_i787.IShapeRecognitionRepository>()));
  gh.factory<_i96.MathProgressProvider>(() => _i96.MathProgressProvider(
        gamification: gh<_i1019.GamificationProvider>(),
        recognizeMultiDigitUseCase: gh<_i558.RecognizeMultiDigit>(),
        repository: gh<_i769.IMathProgressRepository>(),
        audioService: gh<_i951.IAudioService>(),
      ));
  gh.lazySingleton<_i22.AppApiService>(
      () => networkModule.appApiService(gh<_i31.ChopperClient>()));
  gh.factory<_i93.ShapesDrawingProvider>(() => _i93.ShapesDrawingProvider(
        gh<_i865.RecognizeShape>(),
        gh<_i951.IAudioService>(),
        gh<_i354.AppLogger>(),
      ));
  return getIt;
}

class _$LoggingModule extends _i767.LoggingModule {}

class _$NetworkModule extends _i851.NetworkModule {}

class _$StorageModule extends _i148.StorageModule {}

class _$FailureMappersModule extends _i722.FailureMappersModule {}
