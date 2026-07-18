import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_recommendations.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/entities/recommendation.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/module_progress_card.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/recommendation_tile.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/summary_overview_card.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/weekly_activity_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:abc123/core/theme/theme_helper.dart';

/// Ebeveyn Paneli Ana Ekranı (`ParentDashboardScreen`).
///
/// Profesyonel, veri odaklı ve kapsamlı ebeveyn raporlama arayüzü.
class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ParentDashboardView();
  }
}

class _ParentDashboardView extends StatelessWidget {
  const _ParentDashboardView();

  @override
  Widget build(BuildContext context) {
    final getProgressSummary = context.watch<GetProgressSummary>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return FutureBuilder<Map<String, dynamic>>(
      future: () async {
        final progressRes = await getProgressSummary.getAllModuleProgress();
        final progressList = progressRes.fold((l) => <ModuleProgress>[], (r) => r);
        final getRecommendationsUseCase = getIt<GetRecommendations>();
        final recRes = await getRecommendationsUseCase(
          progressList: progressList,
          isTurkish: isTr,
        );
        final recommendations = recRes.fold((l) => <Recommendation>[], (r) => r);
        return {
          'progress': progressList,
          'recommendations': recommendations,
        };
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final data = snapshot.data ??
            {'progress': <ModuleProgress>[], 'recommendations': <Recommendation>[]};
        final allModuleProgress = data['progress'] as List<ModuleProgress>;
        final recommendations = data['recommendations'] as List<Recommendation>;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF121218) : const Color(0xFFF4F6F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : Colors.black87),
              onPressed: () => context.pop(),
            ),
            title: Text(
              isTr ? 'Ebeveyn Kontrol Paneli' : 'Parent Dashboard',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: isTr ? 'Ekran Süresi Kontrolü' : 'Screen Time Control',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: context.mathColors.purple.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.timer_rounded, color: context.mathColors.purple, size: 22),
                ),
                onPressed: () => context.push(AppRoutes.parentScreenTime),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genel Özet Kartı�zet Kartı
                  const SummaryOverviewCard(),
                  const SizedBox(height: 24),

                  // Haftalık Aktivite Grafiği
                  const WeeklyActivityChart(),
                  const SizedBox(height: 28),

                  // Akıllı Öneriler Bölümü
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          isTr ? 'AKILLI ÖNERİLER & AKSİYONLAR' : 'SMART RECOMMENDATIONS & ACTIONS',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1,
                            color: isDark ? Colors.white60 : context.appColorScheme.outline,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.auto_awesome_rounded, color: Colors.amber.shade600, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (final rec in recommendations) RecommendationTile(recommendation: rec),
                  const SizedBox(height: 20),

                  // Modül Bazlı İlerleme Raporları
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          isTr ? 'MODÜL BAZLI İLERLEME RAPORLARI' : 'MODULE PROGRESS REPORTS',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1,
                            color: isDark ? Colors.white60 : context.appColorScheme.outline,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C853).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${allModuleProgress.length} ${isTr ? "Modül Aktif" : "Modules Active"}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00C853),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (final prog in allModuleProgress) ModuleProgressCard(progress: prog),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

