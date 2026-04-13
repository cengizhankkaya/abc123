import 'package:flutter/material.dart';

/// Domain `colorArgb` (0xAARRGGBB) → Flutter `Color`.
Color? gamificationColor(int? argb) => argb == null ? null : Color(argb);

/// Domain `iconKey` alanlarını Material ikonlarına çevirir (sunum katmanı).
IconData gamificationIcon(String? key) {
  if (key == null || key.isEmpty) return Icons.help_outline;
  return _kIcons[key] ?? Icons.help_outline;
}

const Map<String, IconData> _kIcons = <String, IconData>{
  'school': Icons.school,
  'emoji_events': Icons.emoji_events,
  'auto_fix_high': Icons.auto_fix_high,
  'local_florist': Icons.local_florist,
  'explore': Icons.explore,
  'restaurant_menu': Icons.restaurant_menu,
  'visibility': Icons.visibility,
  'remove_red_eye': Icons.remove_red_eye,
  'favorite': Icons.favorite,
  'videogame_asset': Icons.videogame_asset,
  'vrpano': Icons.vrpano,
  'downhill_skiing': Icons.downhill_skiing,
  'masks': Icons.masks,
  'menu_book': Icons.menu_book,
  'checkroom': Icons.checkroom,
  'shield': Icons.shield,
  'forest': Icons.forest,
  'medical_services': Icons.medical_services,
  'rocket_launch': Icons.rocket_launch,
  'sports_soccer': Icons.sports_soccer,
  'local_police': Icons.local_police,
  'restaurant': Icons.restaurant,
  'ac_unit': Icons.ac_unit,
  'person': Icons.person,
  'login': Icons.login,
  'edit': Icons.edit,
  'local_fire_department': Icons.local_fire_department,
  'stars': Icons.stars,
  'whatshot': Icons.whatshot,
  'edit_note': Icons.edit_note,
  'brush': Icons.brush,
  'palette': Icons.palette,
  'color_lens': Icons.color_lens,
  'diamond': Icons.diamond,
  'wb_sunny': Icons.wb_sunny,
  'nights_stay': Icons.nights_stay,
  'weekend': Icons.weekend,
  'looks_one': Icons.looks_one,
  'abc': Icons.abc,
  'category': Icons.category,
  'military_tech': Icons.military_tech,
  'collections_bookmark': Icons.collections_bookmark,
  'workspace_premium': Icons.workspace_premium,
};
