import 'dart:math';

import 'package:abc123/features/home/application/dtos/quest_ledger.dart';
import 'package:abc123/features/home/application/quest/quest_period_keys.dart';
import 'package:abc123/features/home/application/quest/quest_resolve_result.dart';
import 'package:abc123/features/home/application/quest/quest_template_catalog.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:injectable/injectable.dart';

@injectable
final class QuestRolloverResolver {
  QuestResolveResult resolve({
    required DateTime now,
    required QuestLedger? saved,
  }) {
    final dayKey = calendarDayKey(now);
    final weekKey = isoWeekKey(now);

    if (saved == null ||
        saved.schemaVersion != QuestLedger.currentSchemaVersion ||
        saved.quests.length != 3) {
      final rng = Random(dayKey.hashCode ^ weekKey.hashCode);
      final quests = <QuestModel>[
        QuestTemplateCatalog.buildDaily(dayKey, rng),
        QuestTemplateCatalog.weeklyNumbers(weekKey),
        QuestTemplateCatalog.weeklyGeneric(weekKey),
      ];
      final ledger = QuestLedger(
        schemaVersion: QuestLedger.currentSchemaVersion,
        dayKey: dayKey,
        weekKey: weekKey,
        quests: quests,
      );
      return QuestResolveResult(ledger: ledger, didRollover: saved != null);
    }

    if (saved.dayKey == dayKey && saved.weekKey == weekKey) {
      return QuestResolveResult(ledger: saved, didRollover: false);
    }

    final dayChanged = saved.dayKey != dayKey;
    final weekChanged = saved.weekKey != weekKey;

    final QuestModel daily;
    if (dayChanged) {
      daily = QuestTemplateCatalog.buildDaily(dayKey, Random(dayKey.hashCode));
    } else {
      daily = _firstWithIdPrefix(saved.quests, 'daily_') ??
          QuestTemplateCatalog.buildDaily(dayKey, Random(dayKey.hashCode));
    }

    final QuestModel weeklyNums;
    final QuestModel weeklyGen;
    if (weekChanged) {
      weeklyNums = QuestTemplateCatalog.weeklyNumbers(weekKey);
      weeklyGen = QuestTemplateCatalog.weeklyGeneric(weekKey);
    } else {
      weeklyNums = _firstWithIdPrefix(saved.quests, 'weekly_numbers') ??
          QuestTemplateCatalog.weeklyNumbers(weekKey);
      weeklyGen = _firstWithIdPrefix(saved.quests, 'weekly_generic') ??
          QuestTemplateCatalog.weeklyGeneric(weekKey);
    }

    final ledger = QuestLedger(
      schemaVersion: QuestLedger.currentSchemaVersion,
      dayKey: dayKey,
      weekKey: weekKey,
      quests: <QuestModel>[daily, weeklyNums, weeklyGen],
    );
    return QuestResolveResult(ledger: ledger, didRollover: true);
  }

  static QuestModel? _firstWithIdPrefix(List<QuestModel> list, String prefix) {
    for (final q in list) {
      if (q.id.startsWith(prefix)) return q;
    }
    return null;
  }
}
