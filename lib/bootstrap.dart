import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Uygulama genelinde paylaşılan async başlatma (docs: `bootstrap.dart`).
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await AudioService().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
