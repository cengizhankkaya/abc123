import 'package:abc123/core/domain/base/entity.dart';

/// Rozet domain varlığı; değişmez, kilit durumu `copyWith` ile güncellenir (`11_data_modeling.md`).
class Badge extends Entity {

  Badge({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    this.iconPath,
    this.iconKey,
    this.isLocked = true,
  });
  final String id;
  final String nameKey;
  final String descriptionKey;
  final String? iconPath;

  /// Material ikon anahtarı, örn. `login` → `Icons.login` (`gamification_icon_catalog`).
  final String? iconKey;
  final bool isLocked;

  bool get isUnlocked => !isLocked;

  @override
  Object get entityId => id;

  Badge copyWith({bool? isLocked}) {
    return Badge(
      id: id,
      nameKey: nameKey,
      descriptionKey: descriptionKey,
      iconPath: iconPath,
      iconKey: iconKey,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
