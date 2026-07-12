import 'package:abc123/app/app.dart';
import 'package:abc123/bootstrap.dart';
import 'package:abc123/app/config/app_environment.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/features/draw/application/usecases/recognize_number_use_case.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
import 'package:abc123/features/parent_panel/infrastructure/repositories/progress_aggregator_repository_impl.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary_use_case.dart';
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
        ChangeNotifierProvider(
          create: (_) => DrawScreenProvider(
            recognizeNumberUseCase: getIt<RecognizeNumberUseCase>(),
          ),
        ),
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
          create: (context) => MathProgressProvider(recognizeMultiDigitUseCase: getIt(), 
            gamification: context.read<GamificationProvider>(),
          ),
          update: (context, gamification, previous) =>
              previous ?? MathProgressProvider(recognizeMultiDigitUseCase: getIt(), gamification: gamification),
        ),
        ProxyProvider0<ProgressAggregatorRepositoryImpl>(
          update: (context, _) => ProgressAggregatorRepositoryImpl([
            context.read<DrawScreenProvider>(),
            context.read<LetterDrawingProvider>(),
            context.read<ShapesDrawingProvider>(),
            context.read<WordDrawingProvider>(),
            context.read<MathProgressProvider>(),
          ]),
        ),
        ProxyProvider<ProgressAggregatorRepositoryImpl, GetProgressSummaryUseCase>(
          update: (context, repo, _) => GetProgressSummaryUseCase(repo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
