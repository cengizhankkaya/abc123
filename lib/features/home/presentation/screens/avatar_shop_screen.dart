import 'package:abc123/features/home/domain/models/shop_item_model.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
import 'package:abc123/core/services/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:abc123/core/constants/language_constants.dart';

class AvatarShopScreen extends StatefulWidget {
  const AvatarShopScreen({super.key});

  @override
  State<AvatarShopScreen> createState() => _AvatarShopScreenState();
}

class _AvatarShopScreenState extends State<AvatarShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    AdService().initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final lang = context.watch<LanguageProvider>().language;
    final points = provider.points;

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
                      getLocalizedText('shopTitle', lang),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.purple,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                            "$points",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
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
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
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
                    Tab(text: getLocalizedText('tabHat', lang)),
                    Tab(text: getLocalizedText('tabGlasses', lang)),
                    Tab(text: getLocalizedText('tabOutfit', lang)),
                  ],
                ),
              ),

              // Grid
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGrid(provider, ShopItemType.hat, lang),
                    _buildGrid(provider, ShopItemType.glasses, lang),
                    _buildGrid(provider, ShopItemType.outfit, lang),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            AdService().showRewardedAd(onReward: (amount) {
              provider.addPoints(amount);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(getLocalizedText('rewardEarned', lang)
                      .replaceAll('{amount}', '$amount')),
                  backgroundColor: Colors.green,
                ),
              );
            });
          },
          label: Text(getLocalizedText('freePointsBtn', lang)),
          icon: const Icon(Icons.video_library),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }

  Widget _buildGrid(
      GamificationProvider provider, ShopItemType type, AppLanguage lang) {
    final items =
        provider.shopItems.where((item) => item.type == type).toList();

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
        final isEquipped =
            provider.equippedItems[item.type.toString()] == item.id;
        final canBuy = provider.points >= item.price;

        return GestureDetector(
          onTap: () {
            if (isOwned) {
              if (isEquipped) {
                provider.unequipItem(item.type);
              } else {
                provider.equipItem(item);
              }
            } else if (canBuy) {
              _showBuyDialog(context, provider, item, lang);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(getLocalizedText('insufficientPoints', lang))),
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
                  item.iconData ?? Icons.help,
                  size: 60,
                  color: item.color ?? Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  getLocalizedText(item.name, lang),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (isOwned)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isEquipped ? Colors.purple : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isEquipped
                          ? getLocalizedText('equipped', lang)
                          : getLocalizedText('owned', lang),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 18),
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

  void _showBuyDialog(BuildContext context, GamificationProvider provider,
      ShopItemModel item, AppLanguage lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(getLocalizedText('buyTitle', lang)),
        content: Text(getLocalizedText('buyDescription', lang)
            .replaceAll('{price}', '${item.price}')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(getLocalizedText('noBtn', lang)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              provider.buyItem(item);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(getLocalizedText('itemBought', lang)
                        .replaceAll(
                            '{item}', getLocalizedText(item.name, lang)))),
              );
            },
            child: Text(getLocalizedText('yesBuyBtn', lang)),
          ),
        ],
      ),
    );
  }
}
