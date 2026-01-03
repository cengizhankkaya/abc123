import 'package:abc123/features/home/domain/models/shop_item_model.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  final bool showBackground;

  const AvatarWidget({
    super.key,
    this.size = 180,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final equipped = provider.equippedItems;
    final allItems = provider.shopItems;

    ShopItemModel? getItem(ShopItemType type) {
      final id = equipped[type.toString()];
      if (id == null) return null;
      try {
        return allItems.firstWhere((item) => item.id == id);
      } catch (e) {
        return null;
      }
    }

    final hat = getItem(ShopItemType.hat);
    final glasses = getItem(ShopItemType.glasses);
    final outfit = getItem(ShopItemType.outfit);

    return Container(
      width: size,
      height: size,
      decoration: showBackground
          ? BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                )
              ],
            )
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Body
          Positioned(
            bottom: size * 0.1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size * 0.5,
                  height: size * 0.4,
                  decoration: BoxDecoration(
                    color: outfit?.color ?? const Color(0xFFE4BC9D),
                    borderRadius: BorderRadius.circular(size * 0.2),
                  ),
                ),
                if (outfit?.iconData != null)
                  Icon(
                    outfit!.iconData,
                    size: size * 0.25,
                    color: Colors.white.withOpacity(0.8),
                  ),
              ],
            ),
          ),

          // Head
          Positioned(
            top: size * 0.15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Head Shape
                Container(
                  width: size * 0.45,
                  height: size * 0.5,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCCAA),
                    shape: BoxShape.circle,
                  ),
                ),

                // Eyes
                Positioned(
                  top: size * 0.2,
                  left: size * 0.1,
                  child: _buildEye(size),
                ),
                Positioned(
                  top: size * 0.2,
                  right: size * 0.1,
                  child: _buildEye(size),
                ),

                // Smile
                Positioned(
                  bottom: size * 0.12,
                  child: Container(
                    width: size * 0.1,
                    height: size * 0.05,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.brown, width: size * 0.015),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                // Glasses
                if (glasses != null)
                  Positioned(
                    top: size * 0.19, // Align with eyes
                    child: SizedBox(
                      width: size * 0.35, // Approx width between eyes
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Lens
                          Icon(
                            glasses.iconData,
                            size: size * 0.14,
                            color: glasses.color?.withOpacity(0.8),
                          ),
                          // Bridge
                          Expanded(
                            child: Container(
                              height: size * 0.015,
                              color: glasses.color,
                              margin: EdgeInsets.only(top: size * 0.02),
                            ),
                          ),
                          // Right Lens
                          Icon(
                            glasses.iconData,
                            size: size * 0.14,
                            color: glasses.color?.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Hat
                if (hat != null)
                  Positioned(
                    bottom: size * 0.35,
                    child: Icon(
                      hat.iconData,
                      size: size * 0.35,
                      color: hat.color,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEye(double parentSize) {
    return Container(
      width: parentSize * 0.08,
      height: parentSize * 0.08,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: parentSize * 0.025,
              height: parentSize * 0.025,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
