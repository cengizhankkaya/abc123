import 'package:abc123/core/network/app_api_endpoints.dart';
import 'package:chopper/chopper.dart';

part 'app_api_service.chopper.dart';

/// Uygulama genel Chopper servisi (`19_api_integration.md`).
@ChopperApi(baseUrl: AppApiEndpoints.appBasePath)
abstract class AppApiService extends ChopperService {
  static AppApiService create([ChopperClient? client]) => _$AppApiService(client);

  @GET(path: AppApiEndpoints.health)
  Future<Response<Map<String, dynamic>>> healthCheck();
}
