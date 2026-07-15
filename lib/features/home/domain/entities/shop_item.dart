import 'package:abc123/core/domain/base/entity.dart';

enum ShopItemType {
  hat,
  glasses,
  outfit,
  accessory,
}

/// Mağaza öğesi domain varlığı (`colorArgb`: 0xAARRGGBB); alanlar değişmez (`11_data_modeling.md`).
class ShopItem extends Entity {
  ShopItem({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.iconKey,
    this.assetPath,
    this.colorArgb,
  });
  final String id;
  final String name;
  final ShopItemType type;
  final int price;
  final String? iconKey;
  final String? assetPath;
  final int? colorArgb;

  @override
  Object get entityId => id;
}
