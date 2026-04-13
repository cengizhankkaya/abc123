import 'package:abc123/app/app.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

/// Widget testlerinde kullanılan varsayılan [Provider] listesi.
List<SingleChildWidget> defaultTestNotifierProviders() {
  return [
    ChangeNotifierProvider(create: (_) => DrawScreenProvider()),
    ChangeNotifierProvider(create: (_) => LetterDrawingProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
    ChangeNotifierProvider(create: (_) => CounterProvider()),
    ChangeNotifierProvider(create: (_) => getIt<GamificationProvider>()),
  ];
}

/// Tam uygulama ağacı: [MyApp] + mevcut çoklu provider’lar.
///
/// Önkoşul: [configureDependencies] ve gerekirse SharedPreferences mock’u.
Widget wrapWithDefaultAppProviders({Widget? child}) {
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
