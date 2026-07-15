import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Paneli: Genel Özet ve İçgörüler Kartı (Summary Overview).
class SummaryOverviewCard extends StatelessWidget {
  const SummaryOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gamification = context.watch<GamificationProvider>();
    final aggregator = context.watch<GetProgressSummary>();

    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<double>(
      future: () async {
        final res = await aggregator.getOverallAccuracyRate();
        return res.fold((l) => 0.0, (r) => r);
      }(),
      builder: (context, snapshot) {
        final accuracy = (snapshot.data ?? 0.0).round();
        final streak = gamification.streak;
        final unlockedBadges = gamification.unlockedBadges.length;
        final totalBadges = gamification.badges.length;

        // Tahmini çalışma süresi: Toplam çizim & görev bazlı (örn. her aktivite ~2 dk)
        final totalDrawings = gamification.totalDrawings;
        final totalMinutes = totalDrawings * 2;
        final hours = totalMinutes ~/ 60;
        final mins = totalMinutes % 60;
        final timeStr = hours > 0
            ? '$hours ${isTr ? "sa" : "hr"} $mins ${isTr ? "dk" : "min"}'
            : '$mins ${isTr ? "dk" : "min"}';

        return Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF28283E), const Color(0xFF1E1E2C)]
                  : [const Color(0xFF6C63FF), const Color(0xFF4834D4)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withValues(alpha: isDark ? 0.2 : 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.analytics_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isTr ? 'Öğrenme ve Başarı Özeti' : 'Learning & Progress Summary',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isTr
                              ? 'Tüm modüllerin canlı istatistikleri'
                              : 'Real-time statistics across all modules',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 2.2,
                children: [
                  _buildStatTile(
                    icon: Icons.timer_rounded,
                    title: isTr ? 'Öğrenme Süresi' : 'Learning Time',
                    value: timeStr,
                    iconColor: const Color(0xFF00E676),
                  ),
                  _buildStatTile(
                    icon: Icons.local_fire_department_rounded,
                    title: isTr ? 'Aktif Seri (Streak)' : 'Active Streak',
                    value: '$streak ${isTr ? "Gün" : "Days"}',
                    iconColor: const Color(0xFFFF9100),
                  ),
                  _buildStatTile(
                    icon: Icons.check_circle_rounded,
                    title: isTr ? 'Genel Doğruluk' : 'Overall Accuracy',
                    value: '%$accuracy',
                    iconColor: const Color(0xFF00B0FF),
                  ),
                  _buildStatTile(
                    icon: Icons.workspace_premium_rounded,
                    title: isTr ? 'Rozetler' : 'Badges Earned',
                    value: '$unlockedBadges / $totalBadges',
                    iconColor: const Color(0xFFFFD600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
