import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/ads/mobile_ads_gate.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Uygulama genelinde paylaşılan async başlatma (docs: `bootstrap.dart`).
///
/// iOS’ta ATT diyaloğu aktif pencere gerektirir; Google Mobile Ads başlatması ve
/// `MobileAdsGate.markReady` çağrısı `MyApp` ilk kare sonrasında yapılır.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  if (kIsWeb) {
    MobileAdsGate.markReady();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    // ATT + MobileAds: `app.dart` içinde ilk frame sonrası.
  } else {
    try {
      await MobileAds.instance.initialize();
    } on Object catch (_) {
      // Masaüstü / desteklenmeyen hedeflerde reklam SDK’sı başarısız olabilir.
    }
    MobileAdsGate.markReady();
  }
  await AudioService().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
