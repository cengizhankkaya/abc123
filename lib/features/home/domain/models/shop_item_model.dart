import 'package:flutter/material.dart';

enum ShopItemType {
  hat,
  glasses,
  outfit, // shirt/body
  accessory, // e.g. holding a brush
}

class ShopItemModel {
  final String id;
  final String name; // Simple name for now, or localized key
  final ShopItemType type;
  final int price;
  final IconData? iconData; // For placeholder/icon based items
  final String? assetPath; // For actual image assets

  // UI Helper
  final Color? color; // Optional tint color

  const ShopItemModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.iconData,
    this.assetPath,
    this.color,
  });
}
