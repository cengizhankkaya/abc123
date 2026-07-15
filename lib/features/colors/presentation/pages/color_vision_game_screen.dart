import 'dart:async';
import 'dart:math' as math;

import 'package:abc123/features/colors/domain/color_vision_palette.dart';
import 'package:abc123/features/colors/domain/color_vision_profile.dart';
import 'package:abc123/features/colors/domain/color_vision_shape.dart';
import 'package:abc123/features/colors/l10n/generated/colors_localizations.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:abc123/features/colors/presentation/widgets/color_vision_plate_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class _PlateSpec {
  const _PlateSpec(this.shape, this.seed, this.palette);

  final ColorVisionShape shape;
  final int seed;
  final ColorVisionPalette palette;
}

/// Çocuklar için renk plakası oyunu; sonunda yalnızca **eğitici** eksen tahmini (tanı değildir).
class ColorVisionGameScreen extends StatefulWidget {
  const ColorVisionGameScreen({super.key});

  static const int totalPlates = 10;
  static const int rgPlateCount = 6;
  static const int byPlateCount = 4;

  @override
  State<ColorVisionGameScreen> createState() => _ColorVisionGameScreenState();
}

class _ColorVisionGameScreenState extends State<ColorVisionGameScreen> {
  static const List<_PlateSpec> _rgLibrary = [
    _PlateSpec(ColorVisionShape.circle, 41001, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.square, 41002, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.triangle, 41003, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.diamond, 41004, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.circle, 41114, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.triangle, 41225, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.square, 41336, ColorVisionPalette.redGreen),
    _PlateSpec(ColorVisionShape.diamond, 41447, ColorVisionPalette.redGreen),
  ];

  static const List<_PlateSpec> _byLibrary = [
    _PlateSpec(ColorVisionShape.circle, 52001, ColorVisionPalette.blueYellow),
    _PlateSpec(ColorVisionShape.square, 52002, ColorVisionPalette.blueYellow),
    _PlateSpec(ColorVisionShape.triangle, 52003, ColorVisionPalette.blueYellow),
    _PlateSpec(ColorVisionShape.diamond, 52004, ColorVisionPalette.blueYellow),
    _PlateSpec(ColorVisionShape.circle, 52115, ColorVisionPalette.blueYellow),
    _PlateSpec(ColorVisionShape.triangle, 52226, ColorVisionPalette.blueYellow),
  ];

  late List<_PlateSpec> _rounds;
  int _roundIndex = 0;
  int _correct = 0;
  int _rgCorrect = 0;
  int _byCorrect = 0;
  bool _intro = true;
  bool _finished = false;
  bool _awaitingAdvance = false;

  @override
  void initState() {
    super.initState();
    _shuffleRounds();
  }

  void _shuffleRounds() {
    final rnd = math.Random();
    final rg = List<_PlateSpec>.from(_rgLibrary)..shuffle(rnd);
    final by = List<_PlateSpec>.from(_byLibrary)..shuffle(rnd);
    final deck = <_PlateSpec>[
      ...rg.take(ColorVisionGameScreen.rgPlateCount),
      ...by.take(ColorVisionGameScreen.byPlateCount),
    ]..shuffle(rnd);
    _rounds = deck;
  }

  Future<void> _onPick(ColorVisionShape? choice) async {
    if (_intro || _finished || _awaitingAdvance) {
      return;
    }
    final spec = _rounds[_roundIndex];
    final ok = choice == spec.shape;
    if (!mounted) {
      return;
    }
    setState(() {
      if (ok) {
        _correct++;
        if (spec.palette == ColorVisionPalette.redGreen) {
          _rgCorrect++;
        } else {
          _byCorrect++;
        }
      }
      _awaitingAdvance = true;
    });
    final l10n = context.colorsL10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.colorFeedbackCorrect : l10n.colorFeedbackWrong),
        duration: const Duration(milliseconds: 850),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
    if (ok) {
      unawaited(HapticFeedback.lightImpact());
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    setState(() {
      _awaitingAdvance = false;
      if (_roundIndex + 1 >= _rounds.length) {
        _finished = true;
      } else {
        _roundIndex++;
      }
    });
  }

  void _restart() {
    setState(() {
      _shuffleRounds();
      _roundIndex = 0;
      _correct = 0;
      _rgCorrect = 0;
      _byCorrect = 0;
      _intro = true;
      _finished = false;
      _awaitingAdvance = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ColorVisionGameView(
      intro: _intro,
      finished: _finished,
      correct: _correct,
      rgCorrect: _rgCorrect,
      byCorrect: _byCorrect,
      roundIndex: _roundIndex,
      rounds: _rounds,
      awaitingAdvance: _awaitingAdvance,
      onStart: () => setState(() => _intro = false),
      onRestart: _restart,
      onPick: _onPick,
      onBack: () => context.pop(),
    );
  }
}

class _ColorVisionGameView extends StatelessWidget {
  const _ColorVisionGameView({
    required this.intro,
    required this.finished,
    required this.correct,
    required this.rgCorrect,
    required this.byCorrect,
    required this.roundIndex,
    required this.rounds,
    required this.awaitingAdvance,
    required this.onStart,
    required this.onRestart,
    required this.onPick,
    required this.onBack,
  });

  final bool intro;
  final bool finished;
  final int correct;
  final int rgCorrect;
  final int byCorrect;
  final int roundIndex;
  final List<_PlateSpec> rounds;
  final bool awaitingAdvance;
  final VoidCallback onStart;
  final VoidCallback onRestart;
  final void Function(ColorVisionShape?) onPick;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.colorsL10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.colorVisionHomeTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: onBack,
          tooltip: l10n.colorGameBack,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.primaryContainer.withValues(alpha: 0.55),
              cs.tertiaryContainer.withValues(alpha: 0.45),
              cs.surface,
            ],
            stops: const [0, 0.38, 1],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 72, 20, 16),
            child: intro
                ? _IntroBody(onStart: onStart)
                : finished
                    ? _ResultsBody(
                        correct: correct,
                        total: rounds.length,
                        rgCorrect: rgCorrect,
                        byCorrect: byCorrect,
                        onPlayAgain: onRestart,
                      )
                    : _RoundBody(
                        plate: rounds[roundIndex],
                        roundIndex: roundIndex,
                        totalRounds: rounds.length,
                        busy: awaitingAdvance,
                        onPick: onPick,
                      ),
          ),
        ),
      ),
    );
  }
}

String _profileLine(ColorsLocalizations l, ColorVisionHeuristicProfile p) {
  return switch (p) {
    ColorVisionHeuristicProfile.typical => l.colorVisionProfileTypical,
    ColorVisionHeuristicProfile.redGreenAxisLikely => l.colorVisionProfileRedGreenAxis,
    ColorVisionHeuristicProfile.blueYellowAxisLikely => l.colorVisionProfileBlueYellowAxis,
    ColorVisionHeuristicProfile.mixedDifficulty => l.colorVisionProfileMixed,
    ColorVisionHeuristicProfile.inconclusive => l.colorVisionProfileInconclusive,
  };
}

IconData _shapeIcon(ColorVisionShape s) {
  return switch (s) {
    ColorVisionShape.circle => Icons.circle_outlined,
    ColorVisionShape.square => Icons.crop_square_rounded,
    ColorVisionShape.triangle => Icons.change_history_rounded,
    ColorVisionShape.diamond => Icons.diamond_outlined,
  };
}

class _IntroBody extends StatelessWidget {
  const _IntroBody({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.colorsL10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 3,
            shadowColor: cs.shadow.withValues(alpha: 0.18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child:
                            Icon(Icons.visibility_rounded, size: 36, color: cs.onPrimaryContainer),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          l10n.colorVisionIntroTitle,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.colorVisionIntroDisclaimer,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.42,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow_rounded, size: 26),
            label: Text(l10n.colorVisionStart),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultsBody extends StatelessWidget {
  const _ResultsBody({
    required this.correct,
    required this.total,
    required this.rgCorrect,
    required this.byCorrect,
    required this.onPlayAgain,
  });

  final int correct;
  final int total;
  final int rgCorrect;
  final int byCorrect;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = context.colorsL10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final profile = resolveColorVisionProfile(
      rgCorrect: rgCorrect,
      rgTotal: ColorVisionGameScreen.rgPlateCount,
      byCorrect: byCorrect,
      byTotal: ColorVisionGameScreen.byPlateCount,
    );
    final profileText = _profileLine(l10n, profile);

    final summary = correct >= 7
        ? l10n.colorVisionResultsGood
        : correct <= 3
            ? l10n.colorVisionResultsLow
            : l10n.colorVisionResultsMixed;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.colorVisionResultsTitle,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.colorVisionScoreLine(correct, total),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.colorVisionScoreRgLine(rgCorrect, ColorVisionGameScreen.rgPlateCount),
            style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          Text(
            l10n.colorVisionScoreByLine(byCorrect, ColorVisionGameScreen.byPlateCount),
            style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          Text(summary, style: theme.textTheme.bodyLarge?.copyWith(height: 1.38)),
          const SizedBox(height: 22),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            color: cs.surfaceContainerHighest.withValues(alpha: 0.65),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.psychology_alt_rounded, color: cs.primary, size: 26),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.colorVisionResultHintTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profileText,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.colorVisionResultsMedicalNote,
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.38,
            ),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onPlayAgain,
            icon: const Icon(Icons.replay_rounded),
            label: Text(l10n.colorVisionPlayAgain),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundBody extends StatelessWidget {
  const _RoundBody({
    required this.plate,
    required this.roundIndex,
    required this.totalRounds,
    required this.busy,
    required this.onPick,
  });

  final _PlateSpec plate;
  final int roundIndex;
  final int totalRounds;
  final bool busy;
  final void Function(ColorVisionShape? choice) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = context.colorsL10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    const plateSize = 272.0;
    final progress = (roundIndex + 1) / totalRounds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.colorVisionProgress(roundIndex + 1, totalRounds),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Chip(
              avatar: Icon(
                plate.palette == ColorVisionPalette.redGreen
                    ? Icons.blur_on
                    : Icons.water_drop_outlined,
                size: 18,
                color: cs.primary,
              ),
              label: Text(
                plate.palette == ColorVisionPalette.redGreen
                    ? l10n.colorVisionPlateBadgeRg
                    : l10n.colorVisionPlateBadgeBy,
                style: theme.textTheme.labelMedium,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          l10n.colorVisionQuestion,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.25),
        ),
        const SizedBox(height: 14),
        Center(
          child: Semantics(
            label: l10n.colorVisionQuestion,
            child: RepaintBoundary(
              child: Container(
                width: plateSize,
                height: plateSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.14),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CustomPaint(
                    size: const Size.square(plateSize),
                    painter: ColorVisionPlatePainter(
                      shape: plate.shape,
                      seed: plate.seed,
                      palette: plate.palette,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _ChoicePad(
            busy: busy,
            onPick: onPick,
          ),
        ),
      ],
    );
  }
}

class _ChoicePad extends StatelessWidget {
  const _ChoicePad({
    required this.busy,
    required this.onPick,
  });

  final bool busy;
  final void Function(ColorVisionShape? choice) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = context.colorsL10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    Widget cell(ColorVisionShape? value, String label, IconData icon) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: busy ? null : () => onPick(value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon,
                      size: 30, color: busy ? cs.onSurface.withValues(alpha: 0.35) : cs.primary),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: busy ? cs.onSurface.withValues(alpha: 0.35) : cs.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: cell(
                  ColorVisionShape.circle,
                  l10n.colorVisionOptionCircle,
                  _shapeIcon(ColorVisionShape.circle),
                ),
              ),
              Expanded(
                child: cell(
                  ColorVisionShape.square,
                  l10n.colorVisionOptionSquare,
                  _shapeIcon(ColorVisionShape.square),
                ),
              ),
              Expanded(
                child: cell(
                  ColorVisionShape.triangle,
                  l10n.colorVisionOptionTriangle,
                  _shapeIcon(ColorVisionShape.triangle),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: cell(
                  ColorVisionShape.diamond,
                  l10n.colorVisionOptionDiamond,
                  _shapeIcon(ColorVisionShape.diamond),
                ),
              ),
              Expanded(
                flex: 3,
                child: cell(null, l10n.colorVisionOptionNothing, Icons.not_interested_outlined),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
