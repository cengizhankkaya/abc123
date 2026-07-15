import 'package:abc123/app/app.dart';
import 'package:abc123/app/config/app_environment.dart';
import 'package:abc123/bootstrap.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary.dart';
import 'package:abc123/features/parent_panel/infrastructure/repositories/progress_aggregator_repository_impl.dart';
import 'package:abc123/features/parent_panel/presentation/providers/premium_provider.dart';
import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:abc123/features/shapes/presentation/providers/shapes_drawing_provider.dart';
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Production ortamı giriş noktası (`01_project_structure.md` — Build Flavors).
///
/// Çalıştırmak için:
/// ```sh
/// flutter run --dart-define=APP_ENV=production -t lib/main_production.dart
/// ```
/// veya release build:
/// ```sh
/// flutter build apk --dart-define=APP_ENV=production -t lib/main_production.dart
/// ```
void main() async {
  await bootstrap();
  AppEnvironment.assertHttpsApiBase();
  final prefs = getIt<SharedPreferences>();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<DrawScreenProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<LetterDrawingProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ShapesDrawingProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<WordDrawingProvider>()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(prefs)),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => CounterProvider(prefs)),
        ChangeNotifierProvider(create: (_) => PremiumProvider(prefs)),
        ChangeNotifierProvider(create: (_) => ScreenTimeProvider(prefs)),
        ChangeNotifierProvider(
          create: (_) => getIt<GamificationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => FluttermojiController(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MathProgressProvider>(),
        ),
        Provider<ProgressAggregatorRepositoryImpl>(
          create: (context) => ProgressAggregatorRepositoryImpl(
            [
              context.read<DrawScreenProvider>(),
              context.read<LetterDrawingProvider>(),
              context.read<ShapesDrawingProvider>(),
              context.read<WordDrawingProvider>(),
              context.read<MathProgressProvider>(),
            ],
            getIt(),
            getIt(),
          ),
        ),
        ProxyProvider<ProgressAggregatorRepositoryImpl, GetProgressSummary>(
          update: (context, repo, _) => GetProgressSummary(repo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
