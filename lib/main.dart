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
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
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
        ChangeNotifierProvider(create: (_) => WordDrawingProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(
          create: (_) => getIt<GamificationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => FluttermojiController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
