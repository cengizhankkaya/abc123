import 'dart:async';
import 'dart:math';

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/features/colors/application/usecases/get_color_palettes.dart';
import 'package:abc123/features/colors/domain/color_game_stage.dart';
import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/l10n/generated/colors_localizations.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:abc123/features/colors/presentation/extensions/game_palette_color_extension.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

String _colorChapterTitle(ColorsLocalizations l, String titleKey) {
  return switch (titleKey) {
    'basics' => l.colorChapterTitleBasics,
    'wide' => l.colorChapterTitleWide,
    'master' => l.colorChapterTitleMaster,
    _ => titleKey,
  };
}

class ColorGameScreen extends StatefulWidget {
  const ColorGameScreen({super.key});

  @override
  State<ColorGameScreen> createState() => _ColorGameScreenState();
}

class _ColorGameScreenState extends State<ColorGameScreen> with TickerProviderStateMixin {
  final Random _rng = Random();
  GamePaletteColor? _target;
  List<GamePaletteColor> _options = [];
  bool _busy = false;
  bool _starsVisible = false;
  bool _sessionComplete = false;
  double _shakeDx = 0;

  int _levelIndex = 0;
  int _correctInStage = 0;
  int? _secondsLeft;
  Timer? _timer;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;
  late final AnimationController _popController;
  late final Animation<double> _popScale;

  ({ColorGameChapterConfig chapter, int levelInChapter, ColorGameStageConfig stage}) get _level =>
      ColorGameStory.levelAt(_levelIndex);

  ColorGameStageConfig get _stage => _level.stage;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    unawaited(_pulseController.repeat(reverse: true));
    _pulseScale = Tween<double>(begin: 1, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutCubic),
    );

    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _popScale = Tween<double>(begin: 1, end: 1.16).animate(
      CurvedAnimation(parent: _popController, curve: Curves.easeOutBack),
    );

    unawaited(_newRound());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _popController.dispose();
    super.dispose();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _restartTimer() {
    _cancelTimer();
    final sec = _stage.secondsPerRound;
    if (sec == null) {
      if (_secondsLeft != null) {
        setState(() => _secondsLeft = null);
      } else {
        _secondsLeft = null;
      }
      return;
    }
    _secondsLeft = sec;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    setState(() {});
  }

  void _onTimerTick(Timer t) {
    if (!mounted) {
      t.cancel();
      return;
    }
    if (_busy || _sessionComplete) return;
    setState(() {
      if (_secondsLeft == null) return;
      _secondsLeft = _secondsLeft! - 1;
    });
    if (_secondsLeft != null && _secondsLeft! <= 0) {
      t.cancel();
      unawaited(_onTimeout());
    }
  }

  Future<void> _onTimeout() async {
    if (_busy || _sessionComplete || !mounted) return;
    setState(() => _busy = true);
    try {
      await HapticFeedback.heavyImpact();
      await getIt<IAudioService>().playEffect(AppAudios.fail);
      if (!mounted) return;
      unawaited(_runShake());
      final l = context.colorsL10n;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.timer_off_rounded, color: Colors.red.shade800, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l.colorGameTimeUp,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFEBEE),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          duration: const Duration(milliseconds: 1200),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      unawaited(_newRound());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _newRound() async {
    setState(() => _busy = true);
    final stage = _stage;
    final getPalettesUseCase = getIt<GetColorPalettes>();
    final result = await getPalettesUseCase(stage.poolSize);
    
    if (!mounted) return;
    
    result.fold(
      (failure) {
        // Fallback or error state
        if (mounted) setState(() => _busy = false);
      },
      (palette) {
        final pool = List<GamePaletteColor>.from(palette)..shuffle(_rng);
        _target = pool.first;
        final distractors = pool.where((c) => c != _target).take(stage.choices - 1).toList();
        _options = [_target!, ...distractors]..shuffle(_rng);
        _restartTimer();
        if (mounted) setState(() => _busy = false);
      }
    );
  }

  Future<void> _runShake() async {
    const steps = <double>[0, -10, 10, -8, 8, -4, 4, 0];
    for (final dx in steps) {
      if (!mounted) return;
      setState(() => _shakeDx = dx);
      await Future<void>.delayed(const Duration(milliseconds: 42));
    }
  }

  Future<void> _showNextLevelDialog({required bool newChapter}) async {
    final l = context.colorsL10n;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Icon(
                newChapter ? Icons.auto_stories_rounded : Icons.celebration_rounded,
                color: Colors.amber.shade700,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  newChapter ? l.colorGameNextChapterTitle : l.colorGameNextStageTitle,
                ),
              ),
            ],
          ),
          content: Text(
            newChapter ? l.colorGameNextChapterBody : l.colorGameNextStageBody,
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l.colorGameContinue),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPick(GamePaletteColor picked) async {
    if (_busy || _sessionComplete) return;
    final l = context.colorsL10n;
    if (picked == _target) {
      setState(() => _busy = true);
      _cancelTimer();
      try {
        await HapticFeedback.mediumImpact();
        await getIt<IAudioService>().playEffect(AppAudios.success);
        if (!mounted) return;
        setState(() => _starsVisible = true);
        await _popController.forward(from: 0);
        if (!mounted) return;
        await context.read<GamificationProvider>().recordColorRoundSuccess();
        if (!mounted) return;

        _correctInStage++;
        final cfg = _stage;
        final stageDone = _correctInStage >= cfg.requiredCorrect;

        if (stageDone) {
          if (_levelIndex >= ColorGameStory.totalLevels - 1) {
            await _popController.reverse();
            if (!mounted) return;
            setState(() {
              _sessionComplete = true;
              _starsVisible = false;
            });
            return;
          }
          await _popController.reverse();
          if (!mounted) return;
          setState(() => _starsVisible = false);
          final nextIndex = _levelIndex + 1;
          final newChapter = nextIndex < ColorGameStory.totalLevels &&
              ColorGameStory.isFirstLevelOfChapter(nextIndex);
          await _showNextLevelDialog(newChapter: newChapter);
          if (!mounted) return;
          setState(() {
            _levelIndex++;
            _correctInStage = 0;
          });
          _newRound();
          return;
        }

        setState(_newRound);
        await _popController.reverse();
        if (!mounted) return;
        setState(() => _starsVisible = false);
      } finally {
        if (mounted) setState(() => _busy = false);
      }
    } else {
      await HapticFeedback.selectionClick();
      await getIt<IAudioService>().playEffect(AppAudios.fail);
      if (!mounted) return;
      unawaited(_runShake());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.sentiment_neutral_rounded, color: Colors.orange.shade800, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l.colorFeedbackWrong,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade800,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFF3E0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 88),
          duration: const Duration(milliseconds: 1400),
        ),
      );
    }
  }

  void _playAgain() {
    _cancelTimer();
    setState(() {
      _sessionComplete = false;
      _levelIndex = 0;
      _correctInStage = 0;
    });
    _newRound();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.colorsL10n;

    if (_sessionComplete) {
      return Scaffold(
        body: _VictoryOverlay(
          strings: l,
          onPlayAgain: _playAgain,
          onBack: () => context.pop(),
        ),
      );
    }

    if (_target == null || _options.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final levelInfo = _level;
    final chIdx = ColorGameStory.chapters.indexWhere(
      (c) => c.titleKey == levelInfo.chapter.titleKey,
    );

    return _ColorGameView(
      l: l,
      target: _target!,
      options: _options,
      stage: _stage,
      levelInfo: levelInfo,
      chapterIndex: chIdx,
      correctInStage: _correctInStage,
      secondsLeft: _secondsLeft,
      shakeDx: _shakeDx,
      pulseScale: _pulseScale,
      popScale: _popScale,
      starsVisible: _starsVisible,
      busy: _busy,
      onPick: _onPick,
      onBack: () => context.pop(),
    );
  }
}

class _ColorGameView extends StatelessWidget {
  const _ColorGameView({
    required this.l,
    required this.target,
    required this.options,
    required this.stage,
    required this.levelInfo,
    required this.chapterIndex,
    required this.correctInStage,
    required this.secondsLeft,
    required this.shakeDx,
    required this.pulseScale,
    required this.popScale,
    required this.starsVisible,
    required this.busy,
    required this.onPick,
    required this.onBack,
  });

  final ColorsLocalizations l;
  final GamePaletteColor target;
  final List<GamePaletteColor> options;
  final ColorGameStageConfig stage;
  final ({ColorGameChapterConfig chapter, int levelInChapter, ColorGameStageConfig stage}) levelInfo;
  final int chapterIndex;
  final int correctInStage;
  final int? secondsLeft;
  final double shakeDx;
  final Animation<double> pulseScale;
  final Animation<double> popScale;
  final bool starsVisible;
  final bool busy;
  final Future<void> Function(GamePaletteColor) onPick;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final targetDiameter = size.shortestSide * 0.42;
    final r = targetDiameter / 2;
    final need = stage.requiredCorrect;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.25),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          l.colorGameTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            shadows: [
              Shadow(color: Colors.white70, blurRadius: 8, offset: Offset(0, 1)),
            ],
          ),
        ),
        actions: [
          if (secondsLeft != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: secondsLeft! <= 5
                        ? Colors.red.withValues(alpha: 0.9)
                        : const Color(0xFF6C5CE7).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          l.colorGameTimeLeft(secondsLeft!.clamp(0, 999)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: onBack,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE4F3),
              Color(0xFFE8F4FF),
              Color(0xFFFFF9E6),
              Color(0xFFE6F9F0),
            ],
            stops: [0, 0.35, 0.65, 1],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ChapterProgressPanel(
                  chapterTitle: _colorChapterTitle(l, levelInfo.chapter.titleKey),
                  chapterPosition: l.colorGameChapterProgress(chapterIndex + 1, ColorGameStory.totalChapters),
                  levelPosition: l.colorGameLevelProgress(
                    levelInfo.levelInChapter + 1,
                    levelInfo.chapter.levels.length,
                  ),
                  roundLabel: l.colorGameRoundProgress(correctInStage, need),
                  progress: need == 0 ? 0.0 : (correctInStage / need).clamp(0.0, 1.0),
                  chapterIndex: chapterIndex,
                  totalChapters: ColorGameStory.totalChapters,
                ),
                const SizedBox(height: 10),
                _InstructionBubble(text: l.colorGameInstruction),
                const SizedBox(height: 12),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IgnorePointer(
                        child: _DecorativeRings(
                          color: const Color(0xFF6C5CE7),
                          diameter: targetDiameter + 48,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(shakeDx, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            ScaleTransition(
                              scale: pulseScale,
                              child: ScaleTransition(
                                scale: popScale,
                                child: Semantics(
                                  label: target.localizedName(l),
                                  hint: l.colorGameInstruction,
                                  container: true,
                                  child: _TargetWordCard(
                                    word: target.localizedName(l),
                                    maxWidth: size.shortestSide * 0.86,
                                  ),
                                ),
                              ),
                            ),
                            if (starsVisible) ...[
                              Transform.translate(
                                offset: Offset(-r * 0.88, -r * 0.42),
                                child: Icon(
                                  Icons.star_rounded,
                                  size: 36,
                                  color: Colors.amber.shade600,
                                  shadows: const [
                                    Shadow(color: Colors.white, blurRadius: 6),
                                  ],
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(r * 0.78, -r * 0.48),
                                child: Icon(
                                  Icons.star_rounded,
                                  size: 32,
                                  color: Colors.amber.shade400,
                                  shadows: const [
                                    Shadow(color: Colors.white, blurRadius: 6),
                                  ],
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -r * 0.92),
                                child: Icon(
                                  Icons.star_rounded,
                                  size: 34,
                                  color: Colors.amber.shade700,
                                  shadows: const [
                                    Shadow(color: Colors.white, blurRadius: 6),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _ChoiceGrid(
                  rowKey: const ValueKey('color_choice_row'),
                  options: options,
                  labelFor: (c) => c.localizedName(l),
                  enabled: !busy,
                  onPick: onPick,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChapterProgressPanel extends StatelessWidget {
  const _ChapterProgressPanel({
    required this.chapterTitle,
    required this.chapterPosition,
    required this.levelPosition,
    required this.roundLabel,
    required this.progress,
    required this.chapterIndex,
    required this.totalChapters,
  });

  final String chapterTitle;
  final String chapterPosition;
  final String levelPosition;
  final String roundLabel;
  final double progress;
  final int chapterIndex;
  final int totalChapters;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withValues(alpha: 0.92),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < totalChapters; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < chapterIndex
                          ? const Color(0xFF6C5CE7)
                          : i == chapterIndex
                              ? Colors.amber.shade600
                              : Colors.grey.shade300,
                      border: i == chapterIndex
                          ? Border.all(color: const Color(0xFF6C5CE7), width: 2)
                          : null,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              chapterPosition,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.4,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.menu_book_rounded, color: Colors.deepPurple.shade400, size: 26),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chapterTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      height: 1.2,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.layers_rounded, size: 18, color: Colors.blueGrey.shade400),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    levelPosition,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                Text(
                  roundLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(const Color(0xFF6C5CE7), Colors.pinkAccent, progress)!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceGrid extends StatelessWidget {
  const _ChoiceGrid({
    required this.rowKey,
    required this.options,
    required this.labelFor,
    required this.enabled,
    required this.onPick,
  });

  final Key rowKey;
  final List<GamePaletteColor> options;
  final String Function(GamePaletteColor) labelFor;
  final bool enabled;
  final Future<void> Function(GamePaletteColor) onPick;

  @override
  Widget build(BuildContext context) {
    if (options.length == 4) {
      return GridView.count(
        key: rowKey,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.75,
        children: [
          for (final c in options)
            _ColorChoiceButton(
              color: c,
              label: labelFor(c),
              onTap: enabled ? () => unawaited(onPick(c)) : null,
            ),
        ],
      );
    }
    return Row(
      key: rowKey,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final c in options)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _ColorChoiceButton(
                color: c,
                label: labelFor(c),
                onTap: enabled ? () => unawaited(onPick(c)) : null,
              ),
            ),
          ),
      ],
    );
  }
}

class _VictoryOverlay extends StatelessWidget {
  const _VictoryOverlay({
    required this.strings,
    required this.onPlayAgain,
    required this.onBack,
  });

  final ColorsLocalizations strings;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF8E1),
            Color(0xFFE1F5FE),
            Color(0xFFF3E5F5),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events_rounded, size: 100, color: Colors.amber.shade700),
              const SizedBox(height: 24),
              Text(
                strings.colorGameVictoryTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF6C5CE7),
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.colorGameVictoryBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade800,
                      height: 1.35,
                    ),
              ),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: onPlayAgain,
                icon: const Icon(Icons.replay_rounded),
                label: Text(strings.colorGamePlayAgain),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.home_rounded),
                label: Text(strings.colorGameBack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionBubble extends StatelessWidget {
  const _InstructionBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: const Color(0xFF6C5CE7).withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(26),
      color: Colors.white.withValues(alpha: 0.92),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.touch_app_rounded, color: Color(0xFF6C5CE7), size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D3436),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecorativeRings extends StatelessWidget {
  const _DecorativeRings({required this.color, required this.diameter});

  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              width: diameter - i * 28,
              height: diameter - i * 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.12 + i * 0.06),
                  width: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TargetWordCard extends StatelessWidget {
  const _TargetWordCard({required this.word, required this.maxWidth});

  final String word;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Material(
        elevation: 10,
        shadowColor: const Color(0xFF6C5CE7).withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withValues(alpha: 0.96),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              word,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.3,
                color: Color(0xFF2D3436),
                height: 1.08,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorChoiceButton extends StatelessWidget {
  const _ColorChoiceButton({
    required this.color,
    required this.label,
    required this.onTap,
  });

  final GamePaletteColor color;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        elevation: onTap == null ? 2 : 8,
        shadowColor: Color(color.value).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(26),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(26),
          child: Ink(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(Colors.white, Color(color.value), 0.25)!,
                  Color(color.value),
                  Color.lerp(Color(color.value), Colors.black, 0.08)!,
                ],
              ),
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Center(
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white.withValues(alpha: 0.92),
                size: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
