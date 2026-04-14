import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Uygulama genelinde paylaşılan async başlatma (docs: `bootstrap.dart`).
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on Object catch (_) {
      // Simülatör veya nadir platform hatalarında reklam başlatmayı engelleme.
    }
  }
  await MobileAds.instance.initialize();
  await AudioService().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
