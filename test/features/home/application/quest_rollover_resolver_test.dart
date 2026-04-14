@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/application/dtos/quest_ledger.dart';
import 'package:abc123/features/home/application/quest/quest_period_keys.dart';
import 'package:abc123/features/home/application/quest/quest_rollover_resolver.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final resolver = QuestRolloverResolver();

  group('QuestRolloverResolver', () {
    test('ilk kurulumda didRollover false', () {
      final r = resolver.resolve(
        now: DateTime(2026, 4, 13),
        saved: null,
      );
      expect(r.didRollover, isFalse);
      expect(r.ledger.quests, hasLength(3));
      expect(r.ledger.dayKey, calendarDayKey(DateTime(2026, 4, 13)));
      expect(r.ledger.weekKey, isoWeekKey(DateTime(2026, 4, 13)));
      expect(r.ledger.quests.first.id, 'daily_${r.ledger.dayKey}');
    });

    test('aynı gün ve hafta kayıt korunur', () {
      final dayKey = calendarDayKey(DateTime(2026, 6, 1));
      final weekKey = isoWeekKey(DateTime(2026, 6, 1));
      final saved = QuestLedger(
        schemaVersion: QuestLedger.currentSchemaVersion,
        dayKey: dayKey,
        weekKey: weekKey,
        quests: [
          QuestModel(
            id: 'daily_$dayKey',
            titleKey: 'daily_quest',
            targetType: DrawingType.number,
            targetLabel: '3',
            targetCount: 3,
            currentCount: 2,
            rewardPoints: 20,
          ),
          QuestModel(
            id: 'weekly_numbers_$weekKey',
            titleKey: 'weekly_number_quest',
            targetType: DrawingType.number,
            targetCount: 10,
            currentCount: 5,
            rewardPoints: 50,
          ),
          QuestModel(
            id: 'weekly_generic_$weekKey',
            titleKey: 'weekly_generic_quest',
            targetType: DrawingType.any,
            targetCount: 20,
            currentCount: 1,
            rewardPoints: 100,
          ),
        ],
      );

      final r = resolver.resolve(now: DateTime(2026, 6, 1, 15), saved: saved);
      expect(r.didRollover, isFalse);
      expect(identical(r.ledger, saved), isTrue);
    });

    test('gün değişince günlük görev yenilenir; haftalıklar kalır', () {
      final oldDay = calendarDayKey(DateTime(2026, 6, 1));
      final weekKey = isoWeekKey(DateTime(2026, 6, 1));
      final saved = QuestLedger(
        schemaVersion: QuestLedger.currentSchemaVersion,
        dayKey: oldDay,
        weekKey: weekKey,
        quests: [
          QuestModel(
            id: 'daily_$oldDay',
            titleKey: 'daily_quest',
            targetType: DrawingType.letter,
            targetLabel: 'X',
            targetCount: 4,
            currentCount: 4,
            isCompleted: true,
            rewardPoints: 20,
          ),
          QuestModel(
            id: 'weekly_numbers_$weekKey',
            titleKey: 'weekly_number_quest',
            targetType: DrawingType.number,
            targetCount: 10,
            currentCount: 7,
            rewardPoints: 50,
          ),
          QuestModel(
            id: 'weekly_generic_$weekKey',
            titleKey: 'weekly_generic_quest',
            targetType: DrawingType.any,
            targetCount: 20,
            currentCount: 3,
            rewardPoints: 100,
          ),
        ],
      );

      final newDay = calendarDayKey(DateTime(2026, 6, 2));
      final r = resolver.resolve(now: DateTime(2026, 6, 2), saved: saved);
      expect(r.didRollover, isTrue);
      expect(r.ledger.dayKey, newDay);
      expect(r.ledger.weekKey, weekKey);
      expect(r.ledger.quests[0].id, 'daily_$newDay');
      expect(r.ledger.quests[0].currentCount, 0);
      expect(r.ledger.quests[1].currentCount, 7);
      expect(r.ledger.quests[2].currentCount, 3);
    });

    test('şema sürümü uyuşmazsa tam yenileme ve didRollover true', () {
      final saved = QuestLedger(
        schemaVersion: 0,
        dayKey: '2026-01-01',
        weekKey: '2026W01',
        quests: [
          QuestModel(
            id: 'daily_2026-01-01',
            titleKey: 'daily_quest',
            targetType: DrawingType.number,
            targetCount: 3,
            currentCount: 1,
            rewardPoints: 20,
          ),
          QuestModel(
            id: 'weekly_numbers_2026W01',
            titleKey: 'weekly_number_quest',
            targetType: DrawingType.number,
            targetCount: 10,
            rewardPoints: 50,
          ),
          QuestModel(
            id: 'weekly_generic_2026W01',
            titleKey: 'weekly_generic_quest',
            targetType: DrawingType.any,
            targetCount: 20,
            rewardPoints: 100,
          ),
        ],
      );

      final r = resolver.resolve(now: DateTime(2026, 4, 13), saved: saved);
      expect(r.didRollover, isTrue);
      expect(r.ledger.schemaVersion, QuestLedger.currentSchemaVersion);
    });
  });
}
