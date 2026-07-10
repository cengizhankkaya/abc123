import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/fluttermojimodel.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:abc123/features/home/presentation/avatar/widgets/attribute_tile.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Tek bir avatar özelliği için `GridView.builder` — tüm seçenekleri listeler.
///
/// `onTapOption` callback'ini ana customizer'dan alır, böylece satın alma
/// logic'i bu widget'tan bağımsız kalır.
class AttributeGrid extends StatelessWidget {
  const AttributeGrid({
    required this.attribute,
    required this.controller,
    required this.theme,
    required this.onTapOption,
    super.key,
  });

  final AttributeItem attribute;
  final FluttermojiController controller;
  final FluttermojiThemeData theme;

  /// index, currentIndex
  final void Function(int index, int? currentIndex) onTapOption;

  @override
  Widget build(BuildContext context) {
    final attributeListLength =
        fluttermojiProperties[attribute.key!]!.property!.length;

    final int crossAxisCount;
    if (attributeListLength < 6) {
      crossAxisCount = 2;
    } else if (attributeListLength < 12) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    final currentSelection =
        controller.selectedOptions[attribute.key] as int?;

    return GridView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 110),
      itemCount: attributeListLength,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final gamification = context.watch<GamificationProvider>();
        final isOwned = gamification.isAvatarItemOwned(attribute.key!, index);
        final price = gamification.getAvatarItemPrice(attribute.key!, index);

        return AttributeTile(
          svgString: controller.getComponentSVG(attribute.key, index),
          isSelected: index == currentSelection,
          isOwned: isOwned,
          price: price,
          theme: theme,
          onTap: () => onTapOption(index, currentSelection),
        );
      },
    );
  }
}
