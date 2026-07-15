import 'package:abc123/app/app.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/ads/mobile_ads_gate.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

/// Widget testlerinde kullanılan varsayılan [Provider] listesi.
List<SingleChildWidget> defaultTestNotifierProviders() {
  return [
    ChangeNotifierProvider<DrawScreenProvider>.value(value: getIt<DrawScreenProvider>()),
    ChangeNotifierProvider<LetterDrawingProvider>.value(value: getIt<LetterDrawingProvider>()),
    ChangeNotifierProvider(create: (_) => LanguageProvider(getIt())),
    ChangeNotifierProvider(create: (_) => ThemeModeProvider(getIt())),
    ChangeNotifierProvider(create: (_) => CounterProvider(getIt())),
    ChangeNotifierProvider(create: (_) => getIt<GamificationProvider>()),
    ChangeNotifierProvider(create: (_) => ScreenTimeProvider(getIt())),
  ];
}

/// Tam uygulama ağacı: [MyApp] + mevcut çoklu provider’lar.
///
/// Önkoşul: [configureDependencies] ve gerekirse SharedPreferences mock’u.
Widget wrapWithDefaultAppProviders({Widget? child}) {
  // Widget testleri `bootstrap()` çalıştırmaz; reklam kapısı sonsuza kadar beklemesin.
  MobileAdsGate.markReady();
  return MultiProvider(
    providers: defaultTestNotifierProviders(),
    child: child ?? const MyApp(),
  );
}

extension PumpApp on WidgetTester {
  /// [wrapWithDefaultAppProviders] ile kök widget’ı çizer.
  Future<void> pumpAppWithDefaultProviders({Widget? child}) {
    return pumpWidget(wrapWithDefaultAppProviders(child: child));
  }
}
