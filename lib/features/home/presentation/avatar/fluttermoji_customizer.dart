import 'dart:async';

import 'package:abc123/core/infrastructure/ads/ad_service.dart';
import 'package:abc123/features/home/presentation/avatar/defaults.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/fluttermojimodel.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_save_widget.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Kullanıcıya avatar özelleştirme arayüzü sunar.
///
/// GetX kaldırıldı — `ChangeNotifierProvider<FluttermojiController>` ile çalışır.
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
  _FluttermojiCustomizerState createState() => _FluttermojiCustomizerState();
}

class _FluttermojiCustomizerState extends State<FluttermojiCustomizer>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final attributesCount = 11;
  final heightFactor = 0.4;
  final widthFactor = 0.95;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: attributesCount, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Kaydedilmemiş değişiklikleri geri al
    context.read<FluttermojiController>().restoreState();
    tabController.dispose();
    super.dispose();
  }

  void _showEarnStarsDialog(BuildContext context, int price, String attributeKey, int index, FluttermojiController controller) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).padding.bottom + 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_border_rounded, size: 36, color: Colors.orange),
              ),
              const SizedBox(height: 10),
              const Text(
                'Yetersiz Yıldız! ⭐️',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HomeDesignTokens.darkText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Bu seçeneği açmak için $price Yıldıza ihtiyacın var (Mevcut: ${context.watch<GamificationProvider>().points} ⭐️).\n\nHemen yıldız kazanmak için bir yöntem seç:',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: HomeDesignTokens.mutedText,
                ),
              ),
              const SizedBox(height: 16),
              // 1. Reklam İzle Butonu
              InkWell(
                onTap: () {
                  Navigator.pop(ctx);
                  AdService().showRewardedAd(
                    onReward: (amount) async {
                      const earned = 5;
                      unawaited(context.read<GamificationProvider>().addPoints(earned));
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("🎉 +$earned Yıldız kazandın! (Yeni bakiye: ${context.read<GamificationProvider>().points} ⭐️)"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: HomeDesignTokens.lettersCard,
                        ),
                      );
                      final gam = context.read<GamificationProvider>();
                      if (gam.points >= price) {
                        final success = await gam.buyAvatarItem(attributeKey, index);
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("✨ Harika! Yeterli yıldıza ulaşıldı ve seçenek otomatik satın alındı!"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            controller.selectedOptions[attributeKey] = index;
                          });
                          controller.updatePreview();
                          if (widget.autosave) {
                            controller.setFluttermoji();
                          }
                        }
                      }
                    },
                    onAdNotReady: () {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("⏳ Reklam yükleniyor; birkaç saniye sonra tekrar deneyin."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: HomeDesignTokens.lettersCard.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: HomeDesignTokens.lettersCard, width: 2),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.ondemand_video_rounded, color: HomeDesignTokens.lettersCard, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reklam İzleyerek Kazan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: HomeDesignTokens.darkText)),
                            Text('Kısa bir video izle, anında +5 ⭐️ kazan', style: TextStyle(fontSize: 12, color: HomeDesignTokens.mutedText)),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 14, color: HomeDesignTokens.lettersCard),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // 2. Görevleri Tamamla Butonu
              InkWell(
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("🚀 Ana sayfadaki çizim ve oyun etkinliklerini tamamlayarak bolca Yıldız ⭐️ kazanabilirsin!"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: HomeDesignTokens.headerBlue,
                    ),
                  );
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: HomeDesignTokens.continueIconBlue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: HomeDesignTokens.continueIconBlue, width: 2),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.rocket_launch_rounded, color: HomeDesignTokens.continueIconBlue, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Görevleri Tamamla & Oyun Oyna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: HomeDesignTokens.darkText)),
                            Text('Ana sayfada çizim ve görev yaparak yıldız topla', style: TextStyle(fontSize: 12, color: HomeDesignTokens.mutedText)),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 14, color: HomeDesignTokens.continueIconBlue),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapOption(
      int index, int? currentIndex, AttributeItem attribute, FluttermojiController controller, BuildContext context) async {
    final gamification = context.read<GamificationProvider>();
    final isOwned = gamification.isAvatarItemOwned(attribute.key!, index);

    if (!isOwned) {
      final price = gamification.getAvatarItemPrice(attribute.key!, index);
      if (gamification.points < price) {
        _showEarnStarsDialog(context, price, attribute.key!, index, controller);
        return;
      }

      final confirmed = await showModalBottomSheet<bool>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(ctx).padding.bottom + 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: HomeDesignTokens.lettersCard.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('⭐️', style: TextStyle(fontSize: 34)),
                ),
                const SizedBox(height: 12),
                Text(
                  '${attribute.title ?? "Bu Özel Seçenek"}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HomeDesignTokens.darkText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Bu harika seçeneği kalıcı olarak açmak için $price Yıldız ⭐️ kullanılsın mı?\n(Mevcut Yıldızın: ${gamification.points} ⭐️)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: HomeDesignTokens.mutedText,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Vazgeç', style: TextStyle(color: HomeDesignTokens.mutedText, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HomeDesignTokens.lettersCard,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          '$price ⭐️ Satın Al',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      if (confirmed == true) {
        final success = await gamification.buyAvatarItem(attribute.key!, index);
        if (success) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("🎉 Harika! Seçenek başarıyla satın alındı ve açıldı!"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
          setState(() {
            controller.selectedOptions[attribute.key] = index;
          });
          controller.updatePreview();
          if (widget.autosave) {
            controller.setFluttermoji();
          }
        } else {
          if (!context.mounted) return;
          _showEarnStarsDialog(context, price, attribute.key!, index, controller);
        }
      }
      return;
    }

    if (index != currentIndex) {
      setState(() {
        controller.selectedOptions[attribute.key] = index;
      });
      controller.updatePreview();
      if (widget.autosave) {
        controller.setFluttermoji();
      }
    }
  }

  void onArrowTap(bool isLeft) {
    final current = tabController.index;
    if (isLeft) {
      tabController.animateTo(current > 0 ? current - 1 : current);
    } else {
      tabController.animateTo(
          current < attributesCount - 1 ? current + 1 : current);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = context.watch<FluttermojiController>();

    return SizedBox(
      height: widget.scaffoldHeight ?? (size.height * heightFactor),
      width: widget.scaffoldWidth ?? size.width,
      child: _buildBody(
        controller: controller,
        attributes: List<AttributeItem>.generate(
          attributesCount,
          (index) => AttributeItem(
            iconAsset: widget.attributeIcons[index],
            title: widget.attributeTitles[index],
            key: attributeKeys[index],
          ),
          growable: false,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(List<Widget> navbarWidgets) {
    return Container(
      color: widget.theme.primaryBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        indicatorColor: widget.theme.selectedIconColor,
        indicatorPadding: const EdgeInsets.all(2),
        tabs: navbarWidgets,
      ),
    );
  }

  AppBar _buildAppBar(List<AttributeItem> attributes, List<Widget> navbarWidgets) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: widget.theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        attributes[tabController.index].title,
        style: widget.theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: _arrowButton(true),
      actions: [_arrowButton(false)],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _buildBottomNavBar(navbarWidgets),
      ),
    );
  }

  Widget _arrowButton(bool isLeft) {
    return Visibility(
      visible: isLeft
          ? tabController.index > 0
          : tabController.index < attributesCount - 1,
      child: IconButton(
        icon: Icon(
          isLeft
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_forward_ios_rounded,
          color: widget.theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }

  Widget _buildBody({
    required FluttermojiController controller,
    required List<AttributeItem> attributes,
  }) {
    final size = MediaQuery.of(context).size;
    final attributeGrids = <Widget>[];
    final navbarWidgets = <Widget>[];

    for (var attrIndex = 0; attrIndex < attributes.length; attrIndex++) {
      final attribute = attributes[attrIndex];

      if (!controller.selectedOptions.containsKey(attribute.key)) {
        controller.selectedOptions[attribute.key] = 0;
      }

      final attributeListLength =
          fluttermojiProperties[attribute.key!]!.property!.length;

      int gridCrossAxisCount;
      if (attributeListLength < 6) {
        gridCrossAxisCount = 2;
      } else if (attributeListLength < 12) {
        gridCrossAxisCount = 3;
      } else {
        gridCrossAxisCount = 4;
      }

      final int? currentSelection = controller.selectedOptions[attribute.key] as int?;

      final tileGrid = GridView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 110),
        itemCount: attributeListLength,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCrossAxisCount,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          final gamification = context.watch<GamificationProvider>();
          final isOwned = gamification.isAvatarItemOwned(attribute.key!, index);
          final price = gamification.getAvatarItemPrice(attribute.key!, index);

          return InkWell(
            onTap: () => onTapOption(index, currentSelection, attribute, controller, context),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: index == currentSelection
                        ? widget.theme.selectedTileDecoration
                        : widget.theme.unselectedTileDecoration,
                    margin: widget.theme.tileMargin,
                    padding: widget.theme.tilePadding,
                    child: Center(
                      child: Opacity(
                        opacity: isOwned ? 1.0 : 0.55,
                        child: SvgPicture.string(
                          controller.getComponentSVG(attribute.key, index),
                          height: 38,
                          semanticsLabel: 'Your Fluttermoji',
                          placeholderBuilder: (context) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (!isOwned)
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: HomeDesignTokens.lettersCard,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lock, size: 10, color: Colors.white),
                          const SizedBox(width: 2),
                          const Text('⭐️', style: TextStyle(fontSize: 10)),
                          const SizedBox(width: 2),
                          Text(
                            '$price',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      );

      final navWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        child: SvgPicture.asset(
          attribute.iconAsset!,
          height: attribute.iconsize ?? 26.0,
          colorFilter: ColorFilter.mode(
            attrIndex == tabController.index
                ? widget.theme.selectedIconColor
                : widget.theme.unselectedIconColor,
            BlendMode.srcIn,
          ),
          semanticsLabel: attribute.title,
        ),
      );

      attributeGrids.add(tileGrid);
      navbarWidgets.add(navWidget);
    }

    return Container(
      decoration: widget.theme.boxDecoration,
      clipBehavior: Clip.hardEdge,
      child: DefaultTabController(
        length: attributeGrids.length,
        child: Scaffold(
          key: const ValueKey('FMojiCustomizer'),
          backgroundColor: widget.theme.secondaryBgColor,
          appBar: _buildAppBar(attributes, navbarWidgets),
          body: TabBarView(
            physics: widget.theme.scrollPhysics,
            controller: tabController,
            children: attributeGrids,
          ),
        ),
      ),
    );
  }
}
