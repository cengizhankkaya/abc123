import 'package:flutter/material.dart';

class BadgeModel {
  final String id;
  final String nameKey; // Localization key for name
  final String descriptionKey; // Localization key for description
  final String? iconPath;
  final IconData? iconData;
  final bool isLocked;

  bool get isUnlocked => !isLocked;

  BadgeModel({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    this.iconPath,
    this.iconData,
    this.isLocked = true,
  });

  BadgeModel copyWith({bool? isLocked}) {
    return BadgeModel(
      id: id,
      nameKey: nameKey,
      descriptionKey: descriptionKey,
      iconPath: iconPath,
      iconData: iconData,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
