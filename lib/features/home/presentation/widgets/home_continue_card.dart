import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/l10n/generated/home_localizations.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeContinueCard extends StatelessWidget {
  const HomeContinueCard({super.key});

  static const Color _borderColor = Color(0xFFD5DBDB);
  static const double _badgeSize = 52;
  static const double _badgeRadius = 14;

  String _activityLabel(HomeLocalizations h, LastActivityMode mode, int index) {
    return switch (mode) {
      LastActivityMode.number => h.homeContinueNumber(index.toString()),
      LastActivityMode.letter => h.homeContinueLetter(_letterAt(index)),
      LastActivityMode.shape => h.homeContinueShape((index + 1).toString()),
      LastActivityMode.word => h.homeContinueWord,
      LastActivityMode.color => h.homeContinueColor,
      LastActivityMode.colorVision => h.homeContinueColorVision,
    };
  }

  String _letterAt(int index) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return letters[index % letters.length];
  }

  Widget _badgeContent(LastActivityMode mode, int index) {
    final text = switch (mode) {
      LastActivityMode.number => '$index',
      LastActivityMode.letter => _letterAt(index),
      LastActivityMode.shape => '${index + 1}',
      _ => null,
    };
    if (text != null) {
      return Text(text, style: HomeDesignTokens.continueBadgeText());
    }
    final icon = switch (mode) {
      LastActivityMode.word => Icons.spellcheck,
      LastActivityMode.color => Icons.palette,
      _ => Icons.visibility,
    };
    return Icon(icon, color: Colors.white, size: 26);
  }

  String? _routeFor(LastActivityMode mode) {
    return switch (mode) {
      LastActivityMode.number => AppRoutes.draw,
      LastActivityMode.letter => AppRoutes.letters,
      LastActivityMode.shape => AppRoutes.shapes,
      LastActivityMode.word => AppRoutes.words,
      LastActivityMode.color => AppRoutes.colorGame,
      LastActivityMode.colorVision => AppRoutes.colorVisionGame,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => homeContinueSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final h = context.homeL10n!;
        final mode = provider.lastActivityMode;

        if (!provider.hasLastActivity || mode == null) {
          return const SizedBox.shrink();
        }

        final label = _activityLabel(h, mode, provider.lastActivityIndex);
        final route = _routeFor(mode);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: route == null ? null : () => context.push(route),
            borderRadius: BorderRadius.circular(HomeDesignTokens.continueCardRadius),
            child: CustomPaint(
              painter: _DashedBorderPainter(
                color: _borderColor,
                radius: HomeDesignTokens.continueCardRadius,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(HomeDesignTokens.continueCardRadius),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: _badgeSize,
                      height: _badgeSize,
                      decoration: BoxDecoration(
                        color: HomeDesignTokens.continueIconBlue,
                        borderRadius: BorderRadius.circular(_badgeRadius),
                      ),
                      alignment: Alignment.center,
                      child: _badgeContent(mode, provider.lastActivityIndex),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            h.homeWhereYouLeft(label),
                            style: HomeDesignTokens.continueTitle(),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            h.homeStepsRemaining(provider.lastActivityRemaining),
                            style: HomeDesignTokens.continueSubtitle(),
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
      },
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, end.clamp(0, metric.length)), paint);
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
