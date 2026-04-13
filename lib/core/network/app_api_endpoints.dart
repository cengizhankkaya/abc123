/// Uygulama genel API yolları (`19_api_integration.md`).
final class AppApiEndpoints {
  const AppApiEndpoints._();

  static const String version = String.fromEnvironment(
    'API_VERSION',
    defaultValue: 'v1',
  );

  /// [@ChopperApi] taban yolu: `/api/{version}`.
  static const String appBasePath = '/api/$version';

  static const String health = '/health';

  /// Yenileme uç noktası (taban URL ile birleştirilir): `/api/{version}/auth/refresh`.
  static const String authRefresh = '/auth/refresh';

  static String get refreshFullPath => '$appBasePath$authRefresh';
}
