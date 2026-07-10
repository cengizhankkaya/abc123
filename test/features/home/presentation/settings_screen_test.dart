import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/l10n/app_localizations_setup.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/core/theme/app_theme_mode.dart';
import 'package:abc123/features/home/presentation/pages/settings_screen.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/animated_choice_card.dart';
import 'package:abc123/features/home/presentation/widgets/child_name_editor.dart';
import 'package:abc123/features/home/presentation/widgets/settings_section_header.dart';
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
        ChangeNotifierProvider<ThemeModeProvider>(
          create: (_) => ThemeModeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
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

  group('SettingsScreen & Yeni Bileşen Testleri', () {
    testWidgets('SettingsSectionHeader başlık ve ikonu düzgün render eder', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsSectionHeader(
              title: 'Test Bölüm',
              subtitle: 'Alt başlık açıklaması',
              icon: Icons.child_care,
              iconColor: HomeDesignTokens.headerBlue,
            ),
          ),
        ),
      );

      expect(find.text('Test Bölüm'), findsOneWidget);
      expect(find.text('Alt başlık açıklaması'), findsOneWidget);
      expect(find.byIcon(Icons.child_care), findsOneWidget);
    });

    testWidgets('AnimatedChoiceCard dokunuşu algılar ve seçim durumunu gösterir', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedChoiceCard(
              title: 'Seçenek 1',
              subtitle: 'Açıklama',
              isSelected: true,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Seçenek 1'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);

      await tester.tap(find.text('Seçenek 1'));
      expect(tapped, isTrue);
    });

    testWidgets('ChildNameEditor boş girişte hata verir, dolu girişte kaydeder', (tester) async {
      String savedName = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChildNameEditor(
              initialName: 'Ali',
              onSave: (name) => savedName = name,
              hintText: 'İsim yaz',
              saveText: 'Kaydet',
              savedText: 'Kaydedildi',
              emptyErrorText: 'Boş olamaz',
            ),
          ),
        ),
      );

      expect(find.text('Ali'), findsOneWidget);
      expect(find.text('Kaydet'), findsOneWidget);

      // İsmi temizle ve kaydetmeyi dene
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('save_btn')));
      await tester.pump();

      expect(find.text('Boş olamaz'), findsOneWidget);
      expect(savedName, isEmpty);

      // Yeni geçerli isim gir ve kaydet
      await tester.enterText(find.byType(TextField), 'Ayşe');
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('save_btn')));
      await tester.pump();

      expect(savedName, 'Ayşe');
      expect(find.text('Kaydedildi'), findsOneWidget);
    });

    testWidgets('SettingsScreen iki bölümü (Benim Ayarlarım, Ebeveyn Alanı) de listeler', (tester) async {
      await tester.pumpWidget(createTestApp(const Scaffold(body: SettingsScreen())));
      await tester.pumpAndSettle();

      expect(find.text('Benim Ayarlarım'), findsOneWidget);

      // Ebeveyn alanı aşağıda kaldığı için kaydıralım
      await tester.scrollUntilVisible(
        find.text('Ebeveyn Alanı'),
        300.0,
        scrollable: find.byType(Scrollable).first,
      );

      expect(find.text('Ebeveyn Alanı'), findsOneWidget);
      expect(find.text('Ebeveyn Paneli'), findsWidgets);
      expect(find.text('Öğretici'), findsOneWidget);
    });
  });
}
