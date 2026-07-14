import 'dart:async';

import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/domain/entities/badge.dart';
import 'package:abc123/features/home/l10n/home_string_lookup.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/gamification_icon_catalog.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Mockup renkleri (Rozetlerim ekranı).
abstract final class _BadgeColors {
  static const streakCard = Color(0xFF6A3DC8);
  static const dayDone = Color(0xFF4CC26A);
  static const dayPending = Color(0xFFEEEBF4);
  static const earnedTop = Color(0xFFFFCE55);
  static const earnedBottom = Color(0xFFF5A623);
  static const lockedCard = Color(0xFFF1F0F4);
}

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key, this.isTab = false});

  final bool isTab;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final h = context.homeL10n!;

    final badges = provider.badges;
    final unlockedCount = badges.where((b) => !b.isLocked).length;
    final totalCount = badges.length;

    return Scaffold(
      backgroundColor: HomeDesignTokens.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isTab)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: IconButton(
                        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: HomeDesignTokens.darkText,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  Text(
                    h.badgesScreenTitle,
                    style: GoogleFonts.nunito(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: HomeDesignTokens.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    h.badgesEarnedOfTotal(unlockedCount, totalCount),
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: HomeDesignTokens.mutedText,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _StreakCard(streak: provider.streak),
                  const SizedBox(height: 20),
                  _WeeklyTracker(streak: provider.streak),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: AdmobBannerWidget(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: badges.length,
                itemBuilder: (context, index) => _BadgeCard(badge: badges[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: _BadgeColors.streakCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _BadgeColors.streakCard.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  h.badgesStreakDayCount(streak),
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  h.badgesStreakSubtitle,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const Text('🔥', style: TextStyle(fontSize: 32)),
        ],
      ),
    );
  }
}

/// Haftalık seri takibi: Pazartesi'den başlayan 7 gün; seri içindeki geçmiş
/// günler yeşil onay işaretiyle gösterilir.
class _WeeklyTracker extends StatelessWidget {
  const _WeeklyTracker({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final streakStart = streak > 0 ? today.subtract(Duration(days: streak - 1)) : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final day = monday.add(Duration(days: i));
        final isDone = streakStart != null && !day.isBefore(streakStart) && !day.isAfter(today);
        return Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDone ? _BadgeColors.dayDone : _BadgeColors.dayPending,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB9B4C7),
                          shape: BoxShape.circle,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat.E(locale).format(day),
              style: GoogleFonts.nunito(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: HomeDesignTokens.mutedText,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final Badge badge;

  @override
  Widget build(BuildContext context) {
    final isLocked = badge.isLocked;

    return GestureDetector(
      key: ValueKey<String>('badge-grid-${badge.id}'),
      onTap: () => _showBadgeDialog(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: isLocked
              ? null
              : const LinearGradient(
                  colors: [_BadgeColors.earnedTop, _BadgeColors.earnedBottom],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          color: isLocked ? _BadgeColors.lockedCard : null,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: _BadgeColors.earnedBottom.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                gamificationIcon(badge.iconKey),
                size: 40,
                color: isLocked ? const Color(0xFFB9B4C7) : Colors.white,
              ),
            ),
            if (isLocked)
              const Positioned(
                right: 10,
                bottom: 10,
                child: Icon(
                  Icons.lock,
                  size: 14,
                  color: Color(0xFF9A94AB),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBadgeDialog(BuildContext context) {
    final h = context.homeL10n!;
    final isLocked = badge.isLocked;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: isLocked
                        ? null
                        : const LinearGradient(
                            colors: [
                              _BadgeColors.earnedTop,
                              _BadgeColors.earnedBottom,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                    color: isLocked ? _BadgeColors.lockedCard : null,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    isLocked ? Icons.lock : gamificationIcon(badge.iconKey),
                    size: 44,
                    color: isLocked ? const Color(0xFFB9B4C7) : Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  homeBadgeLine(h, badge.nameKey),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: HomeDesignTokens.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  homeBadgeLine(h, badge.descriptionKey),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: HomeDesignTokens.mutedText,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => dialogContext.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _BadgeColors.streakCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    MaterialLocalizations.of(context).closeButtonLabel,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
