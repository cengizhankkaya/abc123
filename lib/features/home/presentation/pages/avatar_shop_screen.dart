import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/core/feature_flags/feature_flag.dart';
import 'package:abc123/core/feature_flags/i_feature_flag_service.dart';
import 'package:abc123/core/infrastructure/ads/ad_service.dart';
import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/presentation/gamification_icon_catalog.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:abc123/features/home/l10n/home_string_lookup.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';

class AvatarShopScreen extends StatefulWidget {
  const AvatarShopScreen({super.key});

  @override
  State<AvatarShopScreen> createState() => _AvatarShopScreenState();
}

class _AvatarShopScreenState extends State<AvatarShopScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      AdService().initialize();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      h.shopTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.purple,
                      ),
                    ),
                    Selector<GamificationProvider, int>(
                      selector: (_, p) => p.points,
                      builder: (context, points, _) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                '$points',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Avatar Preview
              const SizedBox(height: 16),
              // Avatar Stage (Spotlight)
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    const AvatarWidget(size: 200, showBackground: false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tabs
              // Styled Tabs
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.purple,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.purple,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: h.tabHat),
                    Tab(text: h.tabGlasses),
                    Tab(text: h.tabOutfit),
                  ],
                ),
              ),

              // Grid
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Selector<GamificationProvider, int>(
                      selector: (_, p) => shopTabSignature(p, ShopItemType.hat),
                      builder: (context, _, __) => _buildGrid(
                        context,
                        context.read<GamificationProvider>(),
                        ShopItemType.hat,
                      ),
                    ),
                    Selector<GamificationProvider, int>(
                      selector: (_, p) => shopTabSignature(p, ShopItemType.glasses),
                      builder: (context, _, __) => _buildGrid(
                        context,
                        context.read<GamificationProvider>(),
                        ShopItemType.glasses,
                      ),
                    ),
                    Selector<GamificationProvider, int>(
                      selector: (_, p) => shopTabSignature(p, ShopItemType.outfit),
                      builder: (context, _, __) => _buildGrid(
                        context,
                        context.read<GamificationProvider>(),
                        ShopItemType.outfit,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 110.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  AdService().showRewardedAd(onReward: (amount) {
                    context.read<GamificationProvider>().addPoints(amount);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.homeL10n!.rewardEarned(amount),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  });
                },
                label: Text(h.freePointsBtn),
                icon: const Icon(Icons.video_library),
                backgroundColor: Colors.amber,
              ),
            )
          : null,
    );
  }

  Widget _buildGrid(
    BuildContext context,
    GamificationProvider provider,
    ShopItemType type,
  ) {
    final h = context.homeL10n!;
    final items = provider.shopItems.where((item) => item.type == type).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isOwned = provider.ownedItemIds.contains(item.id);
        final isEquipped = provider.equippedItems[item.type.toString()] == item.id;
        final canBuy = provider.points >= item.price;

        return GestureDetector(
          key: ValueKey<String>('shop-item-${item.id}'),
          onTap: () {
            if (isOwned) {
              if (isEquipped) {
                provider.unequipItem(item.type);
              } else {
                provider.equipItem(item);
              }
            } else if (canBuy) {
              _showBuyDialog(context, provider, item);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(h.insufficientPoints)),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: isEquipped
                  ? Border.all(color: Colors.purple, width: 3)
                  : Border.all(color: Colors.grey.shade200),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  gamificationIcon(item.iconKey),
                  size: 60,
                  color: gamificationColor(item.colorArgb) ?? Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  homeShopItemName(h, item.name),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (isOwned)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isEquipped ? Colors.purple : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isEquipped ? h.equipped : h.owned,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${item.price}",
                        style: TextStyle(
                          color: canBuy ? Colors.black : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBuyDialog(
    BuildContext scaffoldContext,
    GamificationProvider provider,
    ShopItemModel item,
  ) {
    final h = scaffoldContext.homeL10n!;
    final messenger = ScaffoldMessenger.of(scaffoldContext);
    showDialog<void>(
      context: scaffoldContext,
      builder: (dialogContext) => AlertDialog(
        title: Text(h.buyTitle),
        content: Text(h.buyDescription(item.price)),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: Text(h.noBtn),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              provider.buyItem(item);
              dialogContext.pop();
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    h.itemBought(homeShopItemName(h, item.name)),
                  ),
                ),
              );
            },
            child: Text(h.yesBuyBtn),
          ),
        ],
      ),
    );
  }
}
