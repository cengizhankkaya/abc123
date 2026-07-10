import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:abc123/features/parent_panel/presentation/screens/parental_gate_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Paneli: Ekran Süresi Middleware / Ara Katman Widget'ı.
///
/// Uygulama gövdesini sarmalayarak, günlük limit dolduğunda çocuk dostu uyarı gösterir.
class ScreenTimeMiddleware extends StatelessWidget {
  final Widget child;

  const ScreenTimeMiddleware({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenTimeProvider>(
      builder: (context, screenTime, _) {
        // Limit aşıldığında ve modal henüz gösterilmediyse modalı aç
        if (screenTime.isLimitExceeded && !screenTime.limitModalShown) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!screenTime.limitModalShown && context.mounted) {
              screenTime.markModalShown();
              _showTimeUpModal(context);
            }
          });
        }
        return child;
      },
    );
  }

  void _showTimeUpModal(BuildContext context) {
    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1E1E26) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bedtime_rounded, color: Color(0xFFFF9800), size: 54),
              ),
              const SizedBox(height: 20),
              Text(
                isTr ? 'Bugünkü Öğrenme Zamanı Doldu! 🌙' : 'Today\'s Learning Time is Up! 🌙',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isTr
                    ? 'Gözlerini dinlendirme zamanı geldi. Harika bir iş çıkardın, yarın yeni görevlerle ve çizimlerle devam edelim!'
                    : 'It is time to rest your eyes. You did a fantastic job today, let\'s continue tomorrow with fresh activities!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    isTr ? 'Tamam, Dinlenme Zamanı' : 'OK, Time to Rest',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ParentalGateScreen(
                        isForScreenTimeExtension: true,
                        onSuccess: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
                child: Text(
                  isTr ? 'Ebeveyn Girişi ile Süreyi Uzat (+15 dk)' : 'Parent Login to Extend (+15 mins)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white54 : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
