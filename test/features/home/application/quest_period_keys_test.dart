@TestOn('vm')
library;

import 'package:abc123/features/home/application/quest/quest_period_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('quest_period_keys', () {
    test('calendarDayKey yerel günü yyyy-MM-dd döndürür', () {
      expect(
        calendarDayKey(DateTime(2026, 4, 13, 23, 59)),
        '2026-04-13',
      );
    });

    test('isoYearAndWeek bilinen tarih için tutarlıdır', () {
      final (y, w) = isoYearAndWeek(DateTime(2026, 4, 13));
      expect(y, 2026);
      expect(w, greaterThanOrEqualTo(1));
      expect(w, lessThanOrEqualTo(53));
      expect(isoWeekKey(DateTime(2026, 4, 13)), '${y}W${w.toString().padLeft(2, '0')}');
    });
  });
}
