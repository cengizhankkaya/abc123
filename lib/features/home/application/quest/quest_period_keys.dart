/// Yerel takvim günü anahtarı `yyyy-MM-dd`.
String calendarDayKey(DateTime d) {
  final x = DateTime(d.year, d.month, d.day);
  final y = x.year.toString().padLeft(4, '0');
  final m = x.month.toString().padLeft(2, '0');
  final day = x.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

/// ISO hafta takvimi: `yyyyWww` (ör. `2026W15`).
String isoWeekKey(DateTime any) {
  final (isoYear, isoWeek) = isoYearAndWeek(any);
  return '${isoYear}W${isoWeek.toString().padLeft(2, '0')}';
}

/// ISO-8601 hafta numarası ve haftanın ait olduğu ISO yıl (haftanın Perşembesi), yerel saat dilimi.
(int isoYear, int isoWeek) isoYearAndWeek(DateTime any) {
  final date = DateTime(any.year, any.month, any.day);
  final thursday = date.add(Duration(days: 4 - date.weekday));
  final isoYear = thursday.year;
  final jan4 = DateTime(isoYear, 1, 4);
  final week1Monday = jan4.subtract(Duration(days: jan4.weekday - DateTime.monday));
  final week = 1 + date.difference(week1Monday).inDays ~/ 7;
  return (isoYear, week);
}
