import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/l10n/app_localizations_setup.dart';
import 'package:abc123/features/colors/presentation/pages/color_game_screen.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
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

  testWidgets('ColorGameScreen başlık ve seçenekleri gösterir', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: kAppLocalizationDelegates,
        supportedLocales: kAppSupportedLocales,
        locale: const Locale('tr'),
        home: ChangeNotifierProvider<GamificationProvider>.value(
          value: getIt<GamificationProvider>(),
          child: const ColorGameScreen(),
        ),
      ),
    );
    // Nabız animasyonu sürekli döndüğü için pumpAndSettle kullanılmaz.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('Renkler'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('color_choice_row')),
        matching: find.byType(Ink),
      ),
      findsNWidgets(3),
    );
  });
}
