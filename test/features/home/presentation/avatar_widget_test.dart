import 'package:abc123/core/di/injection.dart';
import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  testWidgets('AvatarWidget taşma üretmez; Fluttermoji SVG düzgün render edilir', (tester) async {
    final provider = getIt<GamificationProvider>();
    final fluttermojiController = FluttermojiController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<GamificationProvider>.value(value: provider),
              ChangeNotifierProvider<FluttermojiController>.value(value: fluttermojiController),
            ],
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
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
    expect(find.byType(AvatarWidget), findsOneWidget);
    expect(find.byType(SvgPicture), findsWidgets);
    expect(provider.equippedItems[ShopItemType.hat.toString()], hat.id);
    expect(provider.equippedItems[ShopItemType.glasses.toString()], glasses.id);
    expect(provider.equippedItems[ShopItemType.outfit.toString()], outfit.id);
  });

  testWidgets('buyItem sonrası öğe otomatik giyilir', (tester) async {
    final provider = getIt<GamificationProvider>();
    final fluttermojiController = FluttermojiController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<GamificationProvider>.value(value: provider),
              ChangeNotifierProvider<FluttermojiController>.value(value: fluttermojiController),
            ],
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

    expect(provider.equippedItems[ShopItemType.hat.toString()], item.id);
    expect(provider.ownedItemIds, contains(item.id));
  });

  testWidgets('equip değişince GamificationProvider durumu ve bildirim tetiklenir', (tester) async {
    final provider = getIt<GamificationProvider>();
    final fluttermojiController = FluttermojiController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<GamificationProvider>.value(value: provider),
              ChangeNotifierProvider<FluttermojiController>.value(value: fluttermojiController),
            ],
            child: const AvatarWidget(size: 180),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final firstHat = provider.shopItems.firstWhere((i) => i.id == 'hat_blue_cap');
    final secondHat = provider.shopItems.firstWhere((i) => i.id == 'hat_crown');
    await provider.addPoints(10000);
    await provider.buyItem(firstHat);
    await provider.buyItem(secondHat);
    await tester.pumpAndSettle();

    await provider.equipItem(secondHat);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(provider.equippedItems[ShopItemType.hat.toString()], secondHat.id);
    expect(find.byType(AvatarWidget), findsOneWidget);
  });
}
