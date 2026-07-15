import 'package:abc123/app/config/app_environment.dart';
import 'package:abc123/core/api/app_api_endpoints.dart';
import 'package:abc123/core/api/app_api_service.dart';
import 'package:abc123/core/api/interceptors/auth_interceptor.dart';
import 'package:abc123/core/api/interceptors/error_interceptor.dart';
import 'package:abc123/core/api/interceptors/logging_interceptor.dart';
import 'package:abc123/core/api/interceptors/refresh_token_interceptor.dart';
import 'package:abc123/core/api/network_error_handler.dart';
import 'package:abc123/core/domain/ports/i_token_storage.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';

/// [ChopperClient] ve API servisleri (`19_api_integration.md`, `09_dependency_injection.md`).
@module
abstract class NetworkModule {
  @lazySingleton
  Lock apiRefreshLock() => Lock();

  @singleton
  ChopperClient chopperClient(
    AppLogger logger,
    NetworkErrorHandler networkErrorHandler,
    ITokenStorage tokenStorage,
    Lock apiRefreshLock,
  ) {
    final base = Uri.parse(AppEnvironment.current.apiBaseUrl);
    return ChopperClient(
      baseUrl: base,
      services: [
        AppApiService.create(),
      ],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      // Chopper'da yanıt en içteki zincirden döner: 401 için önce [Refresh]
      // çalışmalı, ardından [Error] başarısız yanıtı istisnaya çevirmeli.
      // Bu yüzden sıra dokümandaki satır sırasından farklı: Auth → Error → Refresh → Logging.
      interceptors: [
        AuthInterceptor(tokenStorage.getAccessToken),
        ErrorInterceptor(networkErrorHandler),
        RefreshTokenInterceptor(
          tokenStorage: tokenStorage,
          refreshFullPath: AppApiEndpoints.refreshFullPath,
          apiBaseUri: base,
          refreshLock: apiRefreshLock,
          onRefreshFailed: () {},
        ),
        LoggingInterceptor(logger),
      ],
    );
  }

  @lazySingleton
  AppApiService appApiService(ChopperClient client) => client.getService<AppApiService>();
}
