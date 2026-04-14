import 'package:abc123/core/di/injection.dart';
import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
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

  testWidgets('AvatarWidget taşma üretmez; şapka gözlük kıyafet birlikte çizilir', (tester) async {
    final provider = getIt<GamificationProvider>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<GamificationProvider>.value(
            value: provider,
            child: const Center(
              child: AvatarWidget(size: 200, showBackground: false),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await provider.addPoints(50000);
    await tester.pumpAndSettle();

    final hat = provider.shopItems.firstWhere((i) => i.id == 'hat_chef');
    final glasses = provider.shopItems.firstWhere((i) => i.id == 'glasses_sun');
    final outfit = provider.shopItems.firstWhere((i) => i.id == 'outfit_doctor');

    await provider.buyItem(hat);
    await provider.buyItem(glasses);
    await provider.buyItem(outfit);
    await tester.pumpAndSettle();

    await provider.equipItem(hat);
    await provider.equipItem(glasses);
    await provider.equipItem(outfit);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
    expect(find.byType(AvatarWidget), findsOneWidget);
  });

  testWidgets('equip değişince nabız animasyonu tetiklenir', (tester) async {
    final provider = getIt<GamificationProvider>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<GamificationProvider>.value(
            value: provider,
            child: const AvatarWidget(size: 180),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final item = provider.shopItems.firstWhere((i) => i.type == ShopItemType.hat);
    await provider.addPoints(5000);
    await provider.buyItem(item);
    await tester.pumpAndSettle();

    await provider.equipItem(item);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(provider.equippedItems[ShopItemType.hat.toString()], item.id);
  });
}
