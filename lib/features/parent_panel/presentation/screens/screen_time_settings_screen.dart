import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Paneli: Günlük Ekran Süresi & Mola Ayarları Ekranı.
class ScreenTimeSettingsScreen extends StatelessWidget {
  const ScreenTimeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ScreenTimeSettingsView();
  }
}

class _ScreenTimeSettingsView extends StatelessWidget {
  const _ScreenTimeSettingsView();

  @override
  Widget build(BuildContext context) {
    final screenTime = context.watch<ScreenTimeProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    final limitMins = screenTime.dailyLimitMinutes;
    final usedSecs = screenTime.usedSecondsToday;
    final usedMins = usedSecs ~/ 60;

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
          isTr ? 'Ekran Süresi Kontrolü' : 'Screen Time Control',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bilgi Kutusu
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF4834D4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.hourglass_bottom_rounded, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isTr ? 'Sağlıklı Öğrenme Alışkanlığı' : 'Healthy Learning Habits',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isTr
                                ? 'Çocuğunuzun günlük uygulama kullanım süresini sınırlayın. Süre dolduğunda sevimli bir uyarı ile mola zamanı hatırlatılır.'
                                : "Limit your child's daily app usage. When time is up, a gentle friendly prompt reminds them it is time to rest.",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Bugünkü Kullanım Özet Kartı
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isTr ? 'Bugünkü Kullanım Süresi' : "Today's Used Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$usedMins ${isTr ? "Dakika" : "Minutes"}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (limitMins > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isTr ? 'Hedef / Limit' : 'Target / Limit',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$limitMins ${isTr ? "Dakika" : "Minutes"}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Günlük Limit Ayarı Seçenekleri
              Text(
                isTr ? 'GÜNLÜK EKRAN SÜRESİ LİMİTİ SEÇİN' : 'SELECT DAILY SCREEN TIME LIMIT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  color: isDark ? Colors.white60 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.3,
                children: [
                  _OptionCard(
                    title: isTr ? 'Sınırsız / Kapalı' : 'Unlimited / Off',
                    subtitle: isTr ? 'Süre sınırı uygulanmaz' : 'No time limit applied',
                    value: 0,
                    isSelected: limitMins == 0,
                    isDark: isDark,
                  ),
                  _OptionCard(
                    title: '15 ${isTr ? "Dakika" : "Mins"}',
                    subtitle: isTr ? 'Kısa pratik süresi' : 'Short practice time',
                    value: 15,
                    isSelected: limitMins == 15,
                    isDark: isDark,
                  ),
                  _OptionCard(
                    title: '30 ${isTr ? "Dakika" : "Mins"}',
                    subtitle: isTr ? 'Önerilen günlük süre' : 'Recommended daily time',
                    value: 30,
                    isSelected: limitMins == 30,
                    isDark: isDark,
                  ),
                  _OptionCard(
                    title: '45 ${isTr ? "Dakika" : "Mins"}',
                    subtitle: isTr ? 'Geniş pratik süresi' : 'Extended practice time',
                    value: 45,
                    isSelected: limitMins == 45,
                    isDark: isDark,
                  ),
                  _OptionCard(
                    title: '60 ${isTr ? "Dakika" : "Mins"}',
                    subtitle: isTr ? 'Max günlük sınır' : 'Max daily boundary',
                    value: 60,
                    isSelected: limitMins == 60,
                    isDark: isDark,
                  ),
                  _OptionCard(
                    title: '90 ${isTr ? "Dakika" : "Mins"}',
                    subtitle: isTr ? 'Yoğun tekrar süresi' : 'Intensive review time',
                    value: 90,
                    isSelected: limitMins == 90,
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.isSelected,
    required this.isDark,
  });

  final String title;
  final String subtitle;
  final int value;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ScreenTimeProvider>().setDailyLimitMinutes(value);
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : (isDark ? const Color(0xFF1E1E26) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : (isDark ? Colors.white12 : Colors.grey.shade300),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white : Colors.black87),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.85)
                    : (isDark ? Colors.white54 : Colors.grey.shade600),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
