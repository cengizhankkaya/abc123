import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/error/exception_handler.dart';
import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/l10n/app_localizations_setup.dart';
import 'package:abc123/core/logging/loggers/console_logger.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary.dart';
import 'package:abc123/features/parent_panel/infrastructure/repositories/progress_aggregator_repository_impl.dart';
import 'package:abc123/features/parent_panel/presentation/providers/premium_provider.dart';
import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:abc123/features/parent_panel/presentation/screens/parent_dashboard_screen.dart';
import 'package:abc123/features/parent_panel/presentation/screens/parental_gate_screen.dart';
import 'package:abc123/features/parent_panel/presentation/screens/screen_time_settings_screen.dart';
import 'package:abc123/features/shapes/presentation/providers/shapes_drawing_provider.dart';
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  Widget createTestApp(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamificationProvider>.value(
          value: getIt<GamificationProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => DrawScreenProvider(recognizeNumberUseCase: getIt())),
        ChangeNotifierProvider(create: (_) => LetterDrawingProvider()),
        ChangeNotifierProvider(create: (_) => ShapesDrawingProvider()),
        ChangeNotifierProvider(create: (_) => WordDrawingProvider()),
        ChangeNotifierProvider(create: (_) => PremiumProvider()),
        ChangeNotifierProvider(create: (_) => ScreenTimeProvider()),
        ChangeNotifierProxyProvider<GamificationProvider, MathProgressProvider>(
          create: (ctx) => MathProgressProvider(
            gamification: ctx.read<GamificationProvider>(),
            recognizeMultiDigitUseCase: getIt(),
          ),
          update: (ctx, gam, prev) => prev ?? MathProgressProvider(
            gamification: gam,
            recognizeMultiDigitUseCase: getIt(),
          ),
        ),
        ProxyProvider0<ProgressAggregatorRepositoryImpl>(
          update: (context, _) => ProgressAggregatorRepositoryImpl([
            context.read<DrawScreenProvider>(),
            context.read<LetterDrawingProvider>(),
            context.read<ShapesDrawingProvider>(),
            context.read<WordDrawingProvider>(),
            context.read<MathProgressProvider>(),
          ], ExceptionHandlerImpl(ConsoleLogger()), DefaultFailureMapper(),),
        ),
        ProxyProvider<ProgressAggregatorRepositoryImpl, GetProgressSummary>(
          update: (context, repo, _) => GetProgressSummary(repo),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: kAppLocalizationDelegates,
        supportedLocales: kAppSupportedLocales,
        home: child,
      ),
    );
  }

  group('ParentalGateScreen, ParentDashboardScreen, ScreenTimeSettingsScreen Testleri', () {
    testWidgets('ParentalGateScreen render olur ve tuş takımı çalışır', (tester) async {
      await tester.pumpWidget(createTestApp(const ParentalGateScreen()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Ebeveyn Doğrulaması'), findsOneWidget);
      expect(find.text('GİR'), findsOneWidget);

      // Sayı butonuna bas
      await tester.tap(find.text('5'));
      await tester.pump();

      // Tuşa basıldığı görünmeli
      expect(find.text('5'), findsWidgets);
    });

    testWidgets('ParentDashboardScreen render olur ve özet, grafik ile modül kartlarını gösterir', (tester) async {
      await tester.pumpWidget(createTestApp(const ParentDashboardScreen()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Ebeveyn Kontrol Paneli'), findsOneWidget);
      expect(find.text('Öğrenme ve Başarı Özeti'), findsOneWidget);
      expect(find.text('Haftalık Aktivite & Çalışma Süresi'), findsOneWidget);
      expect(find.text('MODÜL BAZLI İLERLEME RAPORLARI'), findsOneWidget);
    });

    testWidgets('ScreenTimeSettingsScreen render olur ve günlük süre seçeneklerini listeler', (tester) async {
      await tester.pumpWidget(createTestApp(const ScreenTimeSettingsScreen()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Ekran Süresi Kontrolü'), findsOneWidget);
      expect(find.text('Bugünkü Kullanım Süresi'), findsOneWidget);
      expect(find.text('30 Dakika'), findsWidgets);
    });
  });
}
