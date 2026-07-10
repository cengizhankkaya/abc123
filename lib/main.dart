import 'package:abc123/app/app.dart';
import 'package:abc123/bootstrap.dart';
import 'package:abc123/core/config/app_environment.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
import 'package:abc123/features/parent_panel/data/services/progress_aggregator_service.dart';
import 'package:abc123/features/parent_panel/presentation/providers/premium_provider.dart';
import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:abc123/features/shapes/presentation/providers/shapes_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await bootstrap();
  AppEnvironment.assertHttpsApiBase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawScreenProvider()),
        ChangeNotifierProvider(create: (_) => LetterDrawingProvider()),
        ChangeNotifierProvider(create: (_) => ShapesDrawingProvider()),
        ChangeNotifierProvider(create: (_) => WordDrawingProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => PremiumProvider()),
        ChangeNotifierProvider(create: (_) => ScreenTimeProvider()),
        ChangeNotifierProvider(
          create: (_) => getIt<GamificationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => FluttermojiController(),
        ),
        ChangeNotifierProxyProvider<GamificationProvider, MathProgressProvider>(
          create: (context) => MathProgressProvider(
            gamification: context.read<GamificationProvider>(),
          ),
          update: (context, gamification, previous) =>
              previous ?? MathProgressProvider(gamification: gamification),
        ),
        ProxyProvider0<ProgressAggregatorService>(
          update: (context, _) => ProgressAggregatorService([
            context.read<DrawScreenProvider>(),
            context.read<LetterDrawingProvider>(),
            context.read<ShapesDrawingProvider>(),
            context.read<WordDrawingProvider>(),
            context.read<MathProgressProvider>(),
          ]),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
