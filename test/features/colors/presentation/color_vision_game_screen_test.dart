import 'package:abc123/core/l10n/app_localizations_setup.dart';
import 'package:abc123/features/colors/presentation/pages/color_vision_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ColorVisionGameScreen giriş metnini ve başla düğmesini gösterir', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: kAppLocalizationDelegates,
        supportedLocales: kAppSupportedLocales,
        locale: const Locale('tr'),
        home: const ColorVisionGameScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Renk şekilleri'), findsOneWidget);
    expect(find.text('Gizli şekiller'), findsOneWidget);
    expect(find.textContaining('tıbbi test değildir'), findsOneWidget);
    expect(find.text('Hadi oynayalım'), findsOneWidget);
  });
}
