import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/infrastructure/ads/mobile_ads_gate.dart';
import 'package:abc123/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  await getIt<IAudioService>().init();
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } on Object catch (_) {
    // iPadOS Split View / Slide Over: orientation lock desteklenmiyor.
  }
}
