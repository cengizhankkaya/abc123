import 'package:abc123/features/home/l10n/generated/home_localizations.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ParentPanelScreen extends StatelessWidget {
  const ParentPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ParentPanelView();
  }
}

class _ParentPanelView extends StatelessWidget {
  const _ParentPanelView();

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    final gamificationProvider = context.watch<GamificationProvider>();
    final mathProvider = context.watch<MathProgressProvider>();
    final snapshot = _ParentPanelSnapshot.from(gamificationProvider, mathProvider);

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: Column(
        children: [
          _ParentPanelHeader(
            title: h.parentPanelTitle,
            subtitle: snapshot.childName.isEmpty
                ? h.parentPanelWeeklyProgressNoName
                : h.parentPanelWeeklyProgress(snapshot.childName),
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              children: [
                _StatisticsRow(snapshot: snapshot, h: h),
                const SizedBox(height: 16),
                _ChartCard(
                  title: h.parentPanelChartTitle,
                  bars: snapshot.dailyBars,
                ),
                const SizedBox(height: 16),
                _InsightsList(snapshot: snapshot, h: h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticsRow extends StatelessWidget {
  const _StatisticsRow({
    required this.snapshot,
    required this.h,
  });

  final _ParentPanelSnapshot snapshot;
  final HomeLocalizations h;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: h.parentPanelDurationMinutes(snapshot.durationMinutes),
            label: h.parentPanelStatDuration,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            value: '${snapshot.completedCount}',
            label: h.parentPanelStatCompleted,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            value: h.parentPanelAccuracyPercent(snapshot.accuracyPercent),
            label: h.parentPanelStatAccuracy,
          ),
        ),
      ],
    );
  }
}

class _InsightsList extends StatelessWidget {
  const _InsightsList({
    required this.snapshot,
    required this.h,
  });

  final _ParentPanelSnapshot snapshot;
  final HomeLocalizations h;

  @override
  Widget build(BuildContext context) {
    final insights = snapshot.insights(h);
    return Column(
      children: insights.map((insight) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _InsightTile(
            icon: insight.icon,
            iconColor: insight.iconColor,
            text: insight.text,
            when: insight.when,
          ),
        );
      }).toList(),
    );
  }
}

final class _ParentPanelSnapshot {
  const _ParentPanelSnapshot({
    required this.childName,
    required this.completedCount,
    required this.durationMinutes,
    required this.accuracyPercent,
    required this.dailyBars,
    required this.letterRange,
    required this.strugglingNumber,
    required this.showLetterInsight,
    required this.showNumberInsight,
    required this.showMathInsight,
    required this.strugglingMathCode,
  });

  factory _ParentPanelSnapshot.from(
      GamificationProvider provider, MathProgressProvider mathProvider) {
    final mathCompleted = mathProvider.additionsCompleted +
        mathProvider.subtractionsCompleted +
        mathProvider.tensCompleted +
        mathProvider.visualCompleted +
        mathProvider.freeCompleted;

    final completed = provider.numberDrawings +
        provider.letterDrawings +
        provider.shapeDrawings +
        provider.colorRounds +
        provider.wordsCompleted +
        mathCompleted;

    final durationMinutes = (completed * 2).clamp(0, 999);
    final accuracyPercent =
        completed == 0 ? 0 : (72 + provider.streak * 2 + (completed ~/ 5)).clamp(60, 95);

    var strugglingMathCode = -1;
    final maxWrong = [
      mathProvider.wrongAdditionsCount,
      mathProvider.wrongSubtractionsCount,
      mathProvider.wrongTensCount,
    ].reduce((a, b) => a > b ? a : b);

    if (maxWrong > 0) {
      if (maxWrong == mathProvider.wrongAdditionsCount) {
        strugglingMathCode = 0;
      } else if (maxWrong == mathProvider.wrongSubtractionsCount) {
        strugglingMathCode = 1;
      } else if (maxWrong == mathProvider.wrongTensCount) {
        strugglingMathCode = 2;
      }
    }

    return _ParentPanelSnapshot(
      childName: provider.childName,
      completedCount: completed,
      durationMinutes: durationMinutes,
      accuracyPercent: accuracyPercent,
      dailyBars: _weeklyBars(completed, provider.streak),
      letterRange: _letterRange(provider.letterDrawings),
      strugglingNumber: provider.numberDrawings % 10,
      showLetterInsight: provider.letterDrawings >= 2,
      showNumberInsight: provider.numberDrawings > 0,
      showMathInsight: mathProvider.unlockedLevels.length > 1 || mathCompleted > 0,
      strugglingMathCode: strugglingMathCode,
    );
  }

  final String childName;
  final int completedCount;
  final int durationMinutes;
  final int accuracyPercent;
  final List<double> dailyBars;
  final String letterRange;
  final int strugglingNumber;
  final bool showLetterInsight;
  final bool showNumberInsight;
  final bool showMathInsight;
  final int strugglingMathCode;

  List<_InsightData> insights(HomeLocalizations h) {
    final items = <_InsightData>[];
    if (strugglingMathCode != -1) {
      var text = h.parentPanelInsightMath;
      if (strugglingMathCode == 0) {
        text = h.parentPanelMathStrugglingAddition;
      } else if (strugglingMathCode == 1) {
        text = h.parentPanelMathStrugglingSubtraction;
      } else if (strugglingMathCode == 2) {
        text = h.parentPanelMathStrugglingTens;
      }
      items.add(
        _InsightData(
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.orangeAccent,
          text: text,
          when: h.parentPanelToday,
        ),
      );
    } else if (showMathInsight) {
      items.add(
        _InsightData(
          icon: Icons.calculate_rounded,
          iconColor: const Color(0xFF6C63FF),
          text: h.parentPanelInsightMath,
          when: h.parentPanelToday,
        ),
      );
    }
    if (showLetterInsight) {
      items.add(
        _InsightData(
          icon: Icons.abc_rounded,
          iconColor: HomeDesignTokens.headerBlue,
          text: h.parentPanelInsightLettersLearned(letterRange),
          when: h.parentPanelToday,
        ),
      );
    }
    if (showNumberInsight) {
      items.add(
        _InsightData(
          icon: Icons.edit_rounded,
          iconColor: HomeDesignTokens.colorsCard,
          text: h.parentPanelInsightNumberStruggling(strugglingNumber),
          when: h.parentPanelYesterday,
        ),
      );
    }
    if (items.isEmpty) {
      items.add(
        _InsightData(
          icon: Icons.auto_awesome_rounded,
          iconColor: HomeDesignTokens.parentPanelAccent,
          text: h.parentPanelInsightGettingStarted,
          when: h.parentPanelToday,
        ),
      );
    }
    return items;
  }

  static List<double> _weeklyBars(int total, int streak) {
    if (total <= 0) {
      return List<double>.filled(7, 0);
    }

    final weights = List<double>.generate(7, (index) {
      final daysFromToday = 6 - index;
      return daysFromToday < streak.clamp(1, 7) ? 2.2 : 0.6;
    });
    final weightSum = weights.reduce((a, b) => a + b);
    final raw = weights.map((weight) => total * weight / weightSum).toList();
    final maxValue = raw.reduce((a, b) => a > b ? a : b);
    if (maxValue <= 0) {
      return List<double>.filled(7, 0);
    }
    return raw.map((value) => value / maxValue).toList();
  }

  static String _letterRange(int letterDrawings) {
    if (letterDrawings <= 0) return 'A';
    final end = letterDrawings.clamp(1, 26);
    final start = (end - 2).clamp(1, end);
    final startLetter = String.fromCharCode('A'.codeUnitAt(0) + start - 1);
    final endLetter = String.fromCharCode('A'.codeUnitAt(0) + end - 1);
    return start == end ? startLetter : '$startLetter-$endLetter';
  }
}

final class _InsightData {
  const _InsightData({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.when,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final String when;
}

class _ParentPanelHeader extends StatelessWidget {
  const _ParentPanelHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(HomeDesignTokens.headerBottomRadius),
        bottomRight: Radius.circular(HomeDesignTokens.headerBottomRadius),
      ),
      child: ColoredBox(
        color: HomeDesignTokens.parentPanelHeader,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: HomeDesignTokens.headingLarge(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: HomeDesignTokens.bodyMedium(
                          color: Colors.white.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: HomeDesignTokens.headingSection(color: HomeDesignTokens.parentPanelAccent),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText).copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.bars,
  });

  final String title;
  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: HomeDesignTokens.cardTitle(color: HomeDesignTokens.darkText),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bar in bars) ...[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: bar <= 0 ? 0.08 : bar.clamp(0.08, 1.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: HomeDesignTokens.parentPanelChart,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.when,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final String when;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: HomeDesignTokens.cardTitle(color: HomeDesignTokens.darkText).copyWith(
                fontSize: 15,
              ),
            ),
          ),
          Text(
            when,
            style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText),
          ),
        ],
      ),
    );
  }
}
