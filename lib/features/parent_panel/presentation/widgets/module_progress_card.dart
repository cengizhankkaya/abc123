import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:flutter/material.dart';
import 'package:abc123/core/theme/theme_helper.dart';

/// Ebeveyn Paneli: Tekil Modül İlerleme ve Detay Kartı.
class ModuleProgressCard extends StatelessWidget {
  const ModuleProgressCard({required this.progress, super.key});
  final ModuleProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    final moduleInfo = _getModuleInfo(context, progress.moduleName, isTr);

    final accStr = '%${progress.accuracyRate.round()}';
    final compStr = '%${progress.completionPercentage.round()}';

    var dateStr = isTr ? 'Henüz aktivite yok' : 'No activity yet';
    if (progress.lastActivityDate != null) {
      final d = progress.lastActivityDate!;
      dateStr =
          '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.appColorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white10 : context.appColorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık satırı
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: moduleInfo.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(moduleInfo.icon, color: moduleInfo.color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moduleInfo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${isTr ? "Son Çalışma:" : "Last Activity:"} $dateStr',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : context.appColorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    accStr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: moduleInfo.color,
                    ),
                  ),
                  Text(
                    isTr ? 'Doğruluk' : 'Accuracy',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white54 : context.appColorScheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // İlerleme Barı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isTr ? 'Modül Tamamlanma Oranı' : 'Module Completion Rate',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                compStr,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress.completionPercentage / 100.0,
              backgroundColor: isDark ? Colors.white12 : context.appColorScheme.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(moduleInfo.color),
              minHeight: 8,
            ),
          ),

          // Zorlanılan / Hata Yapılan Öğeler Listesi
          if (progress.strugglingItems.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: context.appColorScheme.error.withValues(alpha: isDark ? 0.12 : 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.appColorScheme.error.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline_rounded, color: context.appColorScheme.error, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${isTr ? "En çok hata yapılanlar:" : "Most struggled with:"} ${progress.strugglingItems.take(4).join(", ")}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? context.appColorScheme.error : context.appColorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  ({String title, IconData icon, Color color}) _getModuleInfo(
      BuildContext context, String name, bool isTr) {
    switch (name) {
      case 'numbers':
        return (
          title: isTr ? 'Rakamlar Modülü' : 'Numbers Module',
          icon: Icons.numbers_rounded,
          color: context.mathColors.purple,
        );
      case 'letters':
        return (
          title: isTr ? 'Harfler Modülü' : 'Letters Module',
          icon: Icons.abc_rounded,
          color: const Color(0xFF2196F3),
        );
      case 'shapes':
        return (
          title: isTr ? 'Geometrik Şekiller' : 'Shapes Module',
          icon: Icons.category_rounded,
          color: context.semanticColors.warning,
        );
      case 'words':
        return (
          title: isTr ? 'Kelimeler & Yazma' : 'Words & Spelling',
          icon: Icons.spellcheck_rounded,
          color: const Color(0xFF00B0FF),
        );
      case 'math_advanced':
        return (
          title: isTr ? 'Sayılar (10-100) & Matematik' : 'Numbers (10-100) & Math',
          icon: Icons.calculate_rounded,
          color: const Color(0xFFE91E63),
        );
      default:
        return (
          title: isTr ? 'Öğrenme Modülü' : 'Learning Module',
          icon: Icons.extension_rounded,
          color: const Color(0xFF00C853),
        );
    }
  }
}
