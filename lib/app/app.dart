import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:abc123/core/l10n/app_locale.dart';
import 'package:abc123/core/l10n/app_localizations_setup.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/navigation/app_router.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      AudioService().stopBackground();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeModeProvider>(
      builder: (context, languageProvider, themeProvider, _) {
        return MaterialApp.router(
          onGenerateTitle: (ctx) => AppLocalizations.of(ctx)?.appTitle ?? 'Abc123',
          debugShowCheckedModeBanner: false,
          locale: materialLocaleForAppLanguage(languageProvider.language),
          localizationsDelegates: kAppLocalizationDelegates,
          supportedLocales: kAppSupportedLocales,
          localeListResolutionCallback: (locales, supported) {
            if (locales == null || locales.isEmpty) {
              return supported.first;
            }
            for (final deviceLocale in locales) {
              for (final supportedLocale in supported) {
                if (supportedLocale.languageCode == deviceLocale.languageCode) {
                  return supportedLocale;
                }
              }
            }
            return const Locale('en');
          },
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.materialThemeMode,
        );
      },
    );
  }
}
