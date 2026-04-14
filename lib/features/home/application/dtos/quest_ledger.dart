import 'dart:convert';

import 'package:abc123/features/home/domain/entities/quest_model.dart';

/// Kalıcı görev defteri (`schemaVersion` ile genişletilebilir).
class QuestLedger {
  static const int currentSchemaVersion = 1;

  final int schemaVersion;
  final String dayKey;
  final String weekKey;
  final List<QuestModel> quests;

  const QuestLedger({
    required this.schemaVersion,
    required this.dayKey,
    required this.weekKey,
    required this.quests,
  });

  Map<String, Object?> toJson() => <String, Object?>{
        'schemaVersion': schemaVersion,
        'dayKey': dayKey,
        'weekKey': weekKey,
        'quests': quests.map((q) => q.toJson()).toList(),
      };

  factory QuestLedger.fromJson(Map<String, dynamic> json) {
    final rawQuests = json['quests'] as List<dynamic>? ?? const [];
    return QuestLedger(
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? currentSchemaVersion,
      dayKey: json['dayKey'] as String? ?? '',
      weekKey: json['weekKey'] as String? ?? '',
      quests: rawQuests
          .map((e) => QuestModel.fromJson(Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
          .toList(),
    );
  }

  String encode() => json.encode(toJson());

  /// Kalıcı metinden okur; bozuksa `null`.
  static QuestLedger? tryDecode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = json.decode(raw);
      if (decoded is! Map) return null;
      return QuestLedger.fromJson(Map<String, dynamic>.from(decoded));
    } on Object {
      return null;
    }
  }
}
