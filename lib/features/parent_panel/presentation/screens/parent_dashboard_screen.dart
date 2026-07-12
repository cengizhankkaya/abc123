import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_progress_summary_use_case.dart';
import 'package:abc123/features/parent_panel/application/usecases/get_recommendations_use_case.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/features/parent_panel/presentation/providers/premium_provider.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/module_progress_card.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/recommendation_tile.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/summary_overview_card.dart';
import 'package:abc123/features/parent_panel/presentation/widgets/weekly_activity_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Paneli Ana Ekranı (`ParentDashboardScreen`).
///
/// Profesyonel, veri odaklı ve kapsamlı ebeveyn raporlama arayüzü.
class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getProgressSummary = context.watch<GetProgressSummaryUseCase>();
    final premium = context.watch<PremiumProvider>();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    final allModuleProgress = getProgressSummary.getAllModuleProgress();
    final getRecommendationsUseCase = getIt<GetRecommendationsUseCase>();
    final recommendations = getRecommendationsUseCase(
      progressList: allModuleProgress,
      isTurkish: isTr,
    );

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
                color: const Color(0xFF6C63FF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.timer_rounded, color: Color(0xFF6C63FF), size: 22),
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
              // Premium Yönetim ve Durum Banner'ı
              _buildPremiumBanner(context, premium, isDark, isTr),
              const SizedBox(height: 20),

              // Genel Özet Kartı
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
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.auto_awesome_rounded, color: Colors.amber.shade600, size: 18),
                ],
              ),
              const SizedBox(height: 12),
              for (final rec in recommendations)
                RecommendationTile(recommendation: rec),
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
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853).withOpacity(0.12),
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
              for (final prog in allModuleProgress)
                ModuleProgressCard(progress: prog),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBanner(BuildContext context, PremiumProvider premium, bool isDark, bool isTr) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: premium.isPremium
              ? [const Color(0xFF00C853), const Color(0xFF009624)]
              : [const Color(0xFFFF9800), const Color(0xFFE65100)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (premium.isPremium ? const Color(0xFF00C853) : const Color(0xFFFF9800)).withOpacity(0.3),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              premium.isPremium ? Icons.workspace_premium_rounded : Icons.star_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  premium.isPremium
                      ? (isTr ? 'Aktif Premium Abonelik' : 'Active Premium Subscription')
                      : (isTr ? 'ABC123 Premium — Detaylı İstatistikler' : 'ABC123 Premium — Advanced Analytics'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  premium.isPremium
                      ? (isTr ? 'Tüm modül raporları ve sınırsız özellikler açık' : 'Full access to all module reports and limits')
                      : (isTr ? 'Daha kapsamlı analiz ve sınırsız pratik için yükseltin' : 'Upgrade for deep analytical insights and unlimited practice'),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.88),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: premium.isPremium ? const Color(0xFF009624) : const Color(0xFFE65100),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            onPressed: () {
              // Abonelik değiştir / Simülasyon tetikle
              premium.togglePremium();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    premium.isPremium
                        ? (isTr ? 'Premium Abonelik Açıldı! 🎉' : 'Premium Subscription Activated! 🎉')
                        : (isTr ? 'Ücretsiz Plana Geçildi.' : 'Switched to Free Plan.'),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              premium.isPremium
                  ? (isTr ? 'Yönet' : 'Manage')
                  : (isTr ? 'Yükselt' : 'Upgrade'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
