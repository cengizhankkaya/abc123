import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Paneli: Haftalık Aktivite Grafiği (Weekly Activity Bar Chart).
class WeeklyActivityChart extends StatelessWidget {
  const WeeklyActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyData = context.watch<ScreenTimeProvider>().getWeeklyActivityData();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    double maxY = 0;
    for (final d in weeklyData) {
      if (d.durationMinutes > maxY) maxY = d.durationMinutes.toDouble();
    }
    if (maxY < 30) maxY = 30;
    maxY += 10; // Üst boşluk

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTr
                          ? 'Haftalık Aktivite & Çalışma Süresi'
                          : 'Weekly Activity & Practice Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isTr
                          ? 'Son 7 günlük pratik dakikaları'
                          : 'Practice minutes over the last 7 days',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.show_chart_rounded, color: Color(0xFF6C63FF), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      isTr ? 'Canlı Takip' : 'Live Tracking',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) =>
                        isDark ? const Color(0xFF2C2C38) : const Color(0xFF333333),
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final item = weeklyData[group.x];
                      return BarTooltipItem(
                        '${item.durationMinutes} ${isTr ? "dk" : "min"}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${item.completedActivitiesCount} ${isTr ? "görev tamamlandı" : "tasks completed"}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= weeklyData.length) return const SizedBox();
                        final d = weeklyData[idx];
                        final isToday = idx == weeklyData.length - 1;
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            d.getShortDayName(isTr),
                            style: TextStyle(
                              color: isToday
                                  ? const Color(0xFF6C63FF)
                                  : (isDark ? Colors.white70 : Colors.black87),
                              fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(weeklyData.length, (index) {
                  final item = weeklyData[index];
                  final isToday = index == weeklyData.length - 1;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: item.durationMinutes.toDouble(),
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                        color: isToday
                            ? const Color(0xFF6C63FF)
                            : (isDark ? const Color(0xFF3F3F54) : const Color(0xFFC5CAE9)),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color:
                              isDark ? Colors.white.withValues(alpha: 0.04) : Colors.grey.shade100,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
