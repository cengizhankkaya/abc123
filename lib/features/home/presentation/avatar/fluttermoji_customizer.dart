import 'dart:async';

import 'package:abc123/features/home/presentation/avatar/defaults.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/fluttermojimodel.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:abc123/features/home/presentation/avatar/widgets/attribute_grid.dart';
import 'package:abc123/features/home/presentation/avatar/widgets/attribute_tile.dart'
    show AttributeTile;
import 'package:abc123/features/home/presentation/avatar/widgets/avatar_tab_bar.dart';
import 'package:abc123/features/home/presentation/avatar/widgets/buy_item_bottom_sheet.dart';
import 'package:abc123/features/home/presentation/avatar/widgets/earn_stars_bottom_sheet.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';

/// Kullanıcıya avatar özelleştirme arayüzü sunar.
///
/// GetX kaldırıldı — `ChangeNotifierProvider<FluttermojiController>` ile çalışır.
///
/// UI parçaları ayrı widget'lara bölünmüştür:
/// - [AvatarTabBar]          → AppBar + TabBar + ok butonları
/// - [AttributeGrid]         → Tek özellik için GridView
/// - [AttributeTile]         → Her grid kartı (AttributeGrid içinde kullanılır)
/// - [EarnStarsBottomSheet]  → Yetersiz yıldız uyarısı
/// - [BuyItemBottomSheet]    → Satın alma onay dialog'u
class FluttermojiCustomizer extends StatefulWidget {
  FluttermojiCustomizer({
    super.key,
    this.scaffoldHeight,
    this.scaffoldWidth,
    FluttermojiThemeData? theme,
    List<String>? attributeTitles,
    List<String>? attributeIcons,
    this.autosave = true,
  })  : assert(
          attributeTitles == null || attributeTitles.length == attributesCount,
          'List of Attribute Titles must be of length $attributesCount.',
        ),
        assert(
          attributeIcons == null || attributeIcons.length == attributesCount,
          'List of Attribute Icon paths must be of length $attributesCount.',
        ),
        theme = theme ?? FluttermojiThemeData.standard,
        attributeTitles = attributeTitles ?? defaultAttributeTitles,
        attributeIcons = attributeIcons ?? defaultAttributeIcons;

  final double? scaffoldHeight;
  final double? scaffoldWidth;
  final FluttermojiThemeData theme;
  final List<String> attributeTitles;
  final List<String> attributeIcons;
  final bool autosave;

  static const int attributesCount = 11;

  @override
  State<FluttermojiCustomizer> createState() => _FluttermojiCustomizerState();
}

class _FluttermojiCustomizerState extends State<FluttermojiCustomizer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FluttermojiController _fluttermojiController;

  static const int _attributesCount = 11;
  static const double _heightFactor = 0.4;

  // -------------------------------------------------------------------------
  // Lifecycle
  // -------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _fluttermojiController = context.read<FluttermojiController>();
    _tabController = TabController(length: _attributesCount, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Kaydedilmemiş değişiklikleri geri al.
    // Dispose esnasında notifyListeners() çağrılırsa widget ağacı locked olduğu için
    // hata fırlatır. Bunu önlemek için microtask kullanıyoruz.
    Future.microtask(() => _fluttermojiController.restoreState());
    _tabController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Tap logic
  // -------------------------------------------------------------------------

  Future<void> _onTapOption(
    int index,
    int? currentIndex,
    AttributeItem attribute,
    FluttermojiController controller,
  ) async {
    final gamification = context.read<GamificationProvider>();
    final isOwned = gamification.isAvatarItemOwned(attribute.key!, index);

    if (!isOwned) {
      final price = gamification.getAvatarItemPrice(attribute.key!, index);

      // Yetersiz yıldız
      if (gamification.points < price) {
        if (!mounted) return;
        await EarnStarsBottomSheet.show(
          context,
          price: price,
          attributeKey: attribute.key!,
          index: index,
          controller: controller,
          autosave: widget.autosave,
        );
        return;
      }

      // Yeterli yıldız — satın alma onayı iste
      if (!mounted) return;
      final confirmed = await BuyItemBottomSheet.show(
        context,
        price: price,
        attributeTitle: attribute.title,
        gamification: gamification,
      );

      if (confirmed == true) {
        final success = await gamification.buyAvatarItem(attribute.key!, index);
        if (!mounted) return;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.homeL10n!.avatarItemBought),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
          setState(() => controller.selectedOptions[attribute.key] = index);
          controller.updatePreview();
          if (widget.autosave) unawaited(controller.setFluttermoji());
        } else {
          await EarnStarsBottomSheet.show(
            context,
            price: price,
            attributeKey: attribute.key!,
            index: index,
            controller: controller,
            autosave: widget.autosave,
          );
        }
      }
      return;
    }

    // Zaten sahip olunan — sadece seç
    if (index != currentIndex) {
      setState(() => controller.selectedOptions[attribute.key] = index);
      controller.updatePreview();
      if (widget.autosave) unawaited(controller.setFluttermoji());
    }
  }

  void _onArrowTap(bool isLeft) {
    final current = _tabController.index;
    if (isLeft) {
      _tabController.animateTo(current > 0 ? current - 1 : current);
    } else {
      _tabController.animateTo(
        current < _attributesCount - 1 ? current + 1 : current,
      );
    }
    setState(() {});
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = context.watch<FluttermojiController>();

    final attributes = List<AttributeItem>.generate(
      _attributesCount,
      (i) => AttributeItem(
        iconAsset: widget.attributeIcons[i],
        title: widget.attributeTitles[i],
        key: attributeKeys[i],
      ),
      growable: false,
    );

    // Seçili olmayan özellikler için varsayılan değer ata
    for (final attr in attributes) {
      controller.selectedOptions.putIfAbsent(attr.key, () => 0);
    }

    final attributeGrids = [
      for (final attr in attributes)
        AttributeGrid(
          attribute: attr,
          controller: controller,
          theme: widget.theme,
          onTapOption: (index, currentIndex) => _onTapOption(index, currentIndex, attr, controller),
        ),
    ];

    return SizedBox(
      height: widget.scaffoldHeight ?? (size.height * _heightFactor),
      width: widget.scaffoldWidth ?? size.width,
      child: Container(
        decoration: widget.theme.boxDecoration,
        clipBehavior: Clip.hardEdge,
        child: DefaultTabController(
          length: _attributesCount,
          child: Scaffold(
            key: const ValueKey('FMojiCustomizer'),
            backgroundColor: widget.theme.secondaryBgColor,
            appBar: AvatarTabBar(
              attributes: attributes,
              tabController: _tabController,
              attributesCount: _attributesCount,
              theme: widget.theme,
              onArrowTap: _onArrowTap,
            ),
            body: TabBarView(
              physics: widget.theme.scrollPhysics,
              controller: _tabController,
              children: attributeGrids,
            ),
          ),
        ),
      ),
    );
  }
}
