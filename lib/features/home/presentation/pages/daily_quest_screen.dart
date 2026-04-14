import 'package:abc123/core/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/presentation/widgets/daily_quest_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';

class DailyQuestScreen extends StatefulWidget {
  const DailyQuestScreen({super.key});

  @override
  State<DailyQuestScreen> createState() => _DailyQuestScreenState();
}

class _DailyQuestScreenState extends State<DailyQuestScreen> {
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
    if (_gamification != null) {
      _gamification!.removeListener(_onGamificationTick);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rocket_launch_rounded, color: Color(0xFF6C5CE7), size: 32),
                  SizedBox(width: 12),
                  Text(
                    h.myQuestsTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6C5CE7),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            // const AdmobBannerWidget(), // Removed top banner to avoid clutter
            const SizedBox(height: 8),
            Expanded(
              child: Selector<GamificationProvider, int>(
                selector: (_, p) => questListLayoutSignature(p.quests),
                builder: (context, _, __) {
                  final provider = context.read<GamificationProvider>();
                  if (provider.quests.isEmpty) {
                    return Center(child: Text(h.loadingQuests));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    itemCount: provider.quests.length + 1,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      if (index == provider.quests.length) {
                        return const Center(child: AdmobBannerWidget());
                      }
                      final quest = provider.quests[index];
                      return DailyQuestWidget(
                        key: ValueKey<String>('quest-${quest.id}'),
                        quest: quest,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
