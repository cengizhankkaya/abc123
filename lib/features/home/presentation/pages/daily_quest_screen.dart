import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/core/presentation/widgets/fade_in_slide.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/daily_quest_widget.dart';
import 'package:abc123/features/home/presentation/widgets/quests_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyQuestScreen extends StatefulWidget {
  const DailyQuestScreen({super.key});

  @override
  State<DailyQuestScreen> createState() => _DailyQuestScreenState();
}

class _DailyQuestScreenState extends State<DailyQuestScreen> {
  static const double _bottomNavClearance = 100;

  GamificationProvider? _gamification;
  int _lastShownQuestRolloverGen = -1;
  late final VoidCallback _onGamificationTick = _handleGamificationTick;

  void _handleGamificationTick() {
    if (!mounted) return;
    final p = _gamification;
    if (p == null) return;
    final g = p.questRolloverGeneration;
    if (g > _lastShownQuestRolloverGen && g > 0) {
      final messenger = ScaffoldMessenger.maybeOf(context);
      final h = context.homeL10n;
      if (messenger != null && h != null) {
        messenger.showSnackBar(
          SnackBar(content: Text(h.questsRefreshedMessage)),
        );
      }
    }
    if (g > _lastShownQuestRolloverGen) {
      _lastShownQuestRolloverGen = g;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final p = context.read<GamificationProvider>();
      _gamification = p;
      p.addListener(_onGamificationTick);
      _handleGamificationTick();
    });
  }

  @override
  void dispose() {
    _gamification?.removeListener(_onGamificationTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: Column(
        children: [
          const QuestsHeaderWidget(),
          Expanded(
            child: Selector<GamificationProvider, int>(
              selector: (_, p) => questListLayoutSignature(p.quests),
              builder: (context, _, __) {
                final provider = context.read<GamificationProvider>();
                final quests = provider.quests;

                if (quests.isEmpty) {
                  return Center(
                    child: Text(
                      h.loadingQuests,
                      style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText),
                    ),
                  );
                }

                final daily = quests.where((q) => !q.id.contains('weekly')).toList();
                final weekly = quests.where((q) => q.id.contains('weekly')).toList();

                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, _bottomNavClearance),
                  children: [
                    if (daily.isNotEmpty) ...[
                      FadeInSlide(
                        delay: const Duration(milliseconds: 80),
                        child: Text(
                          h.questsDailySection,
                          style: HomeDesignTokens.headingSection(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (var i = 0; i < daily.length; i++) ...[
                        DailyQuestWidget(
                          key: ValueKey<String>('quest-${daily[i].id}'),
                          quest: daily[i],
                          animationDelay: Duration(milliseconds: 120 + i * 60),
                        ),
                        if (i < daily.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                    if (weekly.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      FadeInSlide(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          h.questsWeeklySection,
                          style: HomeDesignTokens.headingSection(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (var i = 0; i < weekly.length; i++) ...[
                        DailyQuestWidget(
                          key: ValueKey<String>('quest-${weekly[i].id}'),
                          quest: weekly[i],
                          animationDelay: Duration(milliseconds: 240 + i * 60),
                        ),
                        if (i < weekly.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                    const SizedBox(height: 20),
                    const FadeInSlide(
                      delay: Duration(milliseconds: 360),
                      child: AdmobBannerWidget(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
