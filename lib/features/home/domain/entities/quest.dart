import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/domain/base/entity.dart';

/// Görev tanımı — alanlar değişmez; güncelleme `copyWith` ile (`11_data_modeling.md`).
class Quest extends Entity {
  Quest({
    required this.id,
    required this.titleKey,
    required this.targetType,
    required this.targetCount,
    required this.rewardPoints,
    this.targetLabel,
    this.currentCount = 0,
    this.isCompleted = false,
    this.isClaimed = false,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    final typeName = json['targetType'] as String?;
    final type = DrawingType.values.firstWhere(
      (e) => e.name == typeName,
      orElse: () => DrawingType.any,
    );
    return Quest(
      id: json['id']! as String,
      titleKey: json['titleKey']! as String,
      targetType: type,
      targetLabel: json['targetLabel'] as String?,
      targetCount: (json['targetCount'] as num?)?.toInt() ?? 1,
      currentCount: (json['currentCount'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isClaimed: json['isClaimed'] as bool? ?? false,
      rewardPoints: (json['rewardPoints'] as num?)?.toInt() ?? 0,
    );
  }
  final String id;
  final String titleKey;
  final DrawingType targetType;
  final String? targetLabel;
  final int targetCount;
  final int currentCount;
  final bool isCompleted;
  final bool isClaimed;
  final int rewardPoints;

  @override
  Object get entityId => id;

  /// İlerleme 0.0–1.0 (saf hesaplama, yan etki yok).
  double get progress => (currentCount / targetCount).clamp(0.0, 1.0);

  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'titleKey': titleKey,
        'targetType': targetType.name,
        'targetLabel': targetLabel,
        'targetCount': targetCount,
        'currentCount': currentCount,
        'isCompleted': isCompleted,
        'isClaimed': isClaimed,
        'rewardPoints': rewardPoints,
      };

  Quest copyWith({
    String? id,
    String? titleKey,
    DrawingType? targetType,
    String? targetLabel,
    int? targetCount,
    int? currentCount,
    bool? isCompleted,
    bool? isClaimed,
    int? rewardPoints,
  }) {
    return Quest(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      targetType: targetType ?? this.targetType,
      targetLabel: targetLabel ?? this.targetLabel,
      targetCount: targetCount ?? this.targetCount,
      currentCount: currentCount ?? this.currentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      isClaimed: isClaimed ?? this.isClaimed,
      rewardPoints: rewardPoints ?? this.rewardPoints,
    );
  }
}
