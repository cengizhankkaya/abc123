import 'dart:math';

import 'package:abc123/features/home/application/dtos/quest_ledger.dart';
import 'package:abc123/features/home/application/quest/quest_period_keys.dart';
import 'package:abc123/features/home/application/quest/quest_resolve_result.dart';
import 'package:abc123/features/home/application/quest/quest_template_catalog.dart';
import 'package:abc123/features/home/domain/entities/quest.dart';
import 'package:injectable/injectable.dart';

@injectable
final class QuestRolloverResolver {
  /// Beklenen toplam görev sayısı (3 günlük + 4 haftalık).
  static const int expectedQuestCount = 7;

  QuestResolveResult resolve({
    required DateTime now,
    required QuestLedger? saved,
  }) {
    final dayKey = calendarDayKey(now);
    final weekKey = isoWeekKey(now);

    if (saved == null ||
        saved.schemaVersion != QuestLedger.currentSchemaVersion ||
        saved.quests.length != expectedQuestCount) {
      final ledger = _buildFreshLedger(dayKey, weekKey);
      return QuestResolveResult(ledger: ledger, didRollover: saved != null);
    }

    if (saved.dayKey == dayKey && saved.weekKey == weekKey) {
      return QuestResolveResult(ledger: saved, didRollover: false);
    }

    final dayChanged = saved.dayKey != dayKey;
    final weekChanged = saved.weekKey != weekKey;

    // --- Günlük görevler ---
    final Quest daily;
    final Quest dailyColor;
    final Quest dailyWord;
    if (dayChanged) {
      daily = QuestTemplateCatalog.buildDaily(dayKey, Random(dayKey.hashCode));
      dailyColor = QuestTemplateCatalog.buildDailyColor(dayKey);
      dailyWord = QuestTemplateCatalog.buildDailyWord(dayKey);
    } else {
      daily = _firstWithIdPrefix(saved.quests, 'daily_') ??
          QuestTemplateCatalog.buildDaily(dayKey, Random(dayKey.hashCode));
      dailyColor = _firstWithIdPrefix(saved.quests, 'daily_color_') ??
          QuestTemplateCatalog.buildDailyColor(dayKey);
      dailyWord = _firstWithIdPrefix(saved.quests, 'daily_word_') ??
          QuestTemplateCatalog.buildDailyWord(dayKey);
    }

    // --- Haftalık görevler ---
    final Quest weeklyNums;
    final Quest weeklyLetters;
    final Quest weeklyShapes;
    final Quest weeklyGen;
    if (weekChanged) {
      weeklyNums = QuestTemplateCatalog.weeklyNumbers(weekKey);
      weeklyLetters = QuestTemplateCatalog.weeklyLetters(weekKey);
      weeklyShapes = QuestTemplateCatalog.weeklyShapes(weekKey);
      weeklyGen = QuestTemplateCatalog.weeklyGeneric(weekKey);
    } else {
      weeklyNums = _firstWithIdPrefix(saved.quests, 'weekly_numbers') ??
          QuestTemplateCatalog.weeklyNumbers(weekKey);
      weeklyLetters = _firstWithIdPrefix(saved.quests, 'weekly_letters') ??
          QuestTemplateCatalog.weeklyLetters(weekKey);
      weeklyShapes = _firstWithIdPrefix(saved.quests, 'weekly_shapes') ??
          QuestTemplateCatalog.weeklyShapes(weekKey);
      weeklyGen = _firstWithIdPrefix(saved.quests, 'weekly_generic') ??
          QuestTemplateCatalog.weeklyGeneric(weekKey);
    }

    final ledger = QuestLedger(
      schemaVersion: QuestLedger.currentSchemaVersion,
      dayKey: dayKey,
      weekKey: weekKey,
      quests: <Quest>[
        daily,
        dailyColor,
        dailyWord,
        weeklyNums,
        weeklyLetters,
        weeklyShapes,
        weeklyGen,
      ],
    );
    return QuestResolveResult(ledger: ledger, didRollover: true);
  }

  QuestLedger _buildFreshLedger(String dayKey, String weekKey) {
    final rng = Random(dayKey.hashCode ^ weekKey.hashCode);
    return QuestLedger(
      schemaVersion: QuestLedger.currentSchemaVersion,
      dayKey: dayKey,
      weekKey: weekKey,
      quests: <Quest>[
        QuestTemplateCatalog.buildDaily(dayKey, rng),
        QuestTemplateCatalog.buildDailyColor(dayKey),
        QuestTemplateCatalog.buildDailyWord(dayKey),
        QuestTemplateCatalog.weeklyNumbers(weekKey),
        QuestTemplateCatalog.weeklyLetters(weekKey),
        QuestTemplateCatalog.weeklyShapes(weekKey),
        QuestTemplateCatalog.weeklyGeneric(weekKey),
      ],
    );
  }

  static Quest? _firstWithIdPrefix(List<Quest> list, String prefix) {
    for (final q in list) {
      if (q.id.startsWith(prefix)) return q;
    }
    return null;
  }
}
