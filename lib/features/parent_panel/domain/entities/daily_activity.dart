/// Ebeveyn Paneli'ndeki haftalık ve günlük çalışma/aktivite grafiği için veri modeli.
class DailyActivity {

  const DailyActivity({
    required this.date,
    required this.durationMinutes,
    required this.completedActivitiesCount,
  });
  final DateTime date;
  final int durationMinutes;
  final int completedActivitiesCount;

  /// Günün adını kısa olarak döndürür (örn. Pzt, Sal / Mon, Tue).
  String getShortDayName(bool isTurkish) {
    switch (date.weekday) {
      case DateTime.monday:
        return isTurkish ? 'Pzt' : 'Mon';
      case DateTime.tuesday:
        return isTurkish ? 'Sal' : 'Tue';
      case DateTime.wednesday:
        return isTurkish ? 'Çar' : 'Wed';
      case DateTime.thursday:
        return isTurkish ? 'Per' : 'Thu';
      case DateTime.friday:
        return isTurkish ? 'Cum' : 'Fri';
      case DateTime.saturday:
        return isTurkish ? 'Cmt' : 'Sat';
      case DateTime.sunday:
        return isTurkish ? 'Paz' : 'Sun';
      default:
        return '';
    }
  }
}
