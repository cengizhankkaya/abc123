import 'dart:math' as math;

import 'package:abc123/features/colors/domain/color_vision_palette.dart';
import 'package:abc123/features/colors/domain/color_vision_shape.dart';
import 'package:flutter/material.dart';

/// Nokta düzenli plaka: [palette] eksenine göre arka plan / şekil renkleri değişir.
class ColorVisionPlatePainter extends CustomPainter {
  ColorVisionPlatePainter({
    required this.shape,
    required this.seed,
    required this.palette,
  });

  final ColorVisionShape shape;
  final int seed;
  final ColorVisionPalette palette;

  Path _figurePath(double cx, double cy, double radius) {
    final figure = Path();
    switch (shape) {
      case ColorVisionShape.circle:
        figure.addOval(Rect.fromCircle(center: Offset(cx, cy), radius: radius));
      case ColorVisionShape.square:
        final side = radius * 1.75;
        figure.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx, cy), width: side, height: side),
            const Radius.circular(3),
          ),
        );
      case ColorVisionShape.triangle:
        final r = radius * 1.05;
        figure.moveTo(cx, cy - r);
        figure.lineTo(cx - r * 0.866, cy + r * 0.5);
        figure.lineTo(cx + r * 0.866, cy + r * 0.5);
        figure.close();
      case ColorVisionShape.diamond:
        figure.moveTo(cx, cy - radius);
        figure.lineTo(cx + radius * 0.78, cy);
        figure.lineTo(cx, cy + radius);
        figure.lineTo(cx - radius * 0.78, cy);
        figure.close();
    }
    return figure;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(seed);
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    final radius = math.min(w, h) * 0.34;
    final figure = _figurePath(cx, cy, radius);

    const spacing = 3.4;
    final dotPaint = Paint()..isAntiAlias = true;

    final clip = Path()..addOval(Rect.fromLTWH(0, 0, w, h));
    canvas
      ..save()
      ..clipPath(clip);

    for (var x = 0.0; x < w; x += spacing) {
      for (var y = 0.0; y < h; y += spacing) {
        final ox = rng.nextDouble() * 1.6 - 0.8;
        final oy = rng.nextDouble() * 1.6 - 0.8;
        final p = Offset(x + ox, y + oy);
        if (p.dx < 0 || p.dy < 0 || p.dx >= w || p.dy >= h) {
          continue;
        }
        final inside = figure.contains(p);
        final color = switch (palette) {
          ColorVisionPalette.redGreen => inside ? _rgFigure(rng) : _rgBackground(rng),
          ColorVisionPalette.blueYellow => inside ? _byFigure(rng) : _byBackground(rng),
        };
        dotPaint.color = color;
        canvas.drawCircle(p, 2.05, dotPaint);
      }
    }

    canvas.restore();
  }

  static Color _rgFigure(math.Random rng) {
    final hue = 18 + rng.nextDouble() * 32;
    final sat = 0.52 + rng.nextDouble() * 0.32;
    final val = 0.48 + rng.nextDouble() * 0.28;
    return HSVColor.fromAHSV(1, hue, sat, val).toColor();
  }

  static Color _rgBackground(math.Random rng) {
    if (rng.nextBool()) {
      final hue = rng.nextDouble() * 16;
      return HSVColor.fromAHSV(
              1, hue, 0.62 + rng.nextDouble() * 0.22, 0.38 + rng.nextDouble() * 0.18)
          .toColor();
    }
    final hue = 92 + rng.nextDouble() * 42;
    return HSVColor.fromAHSV(1, hue, 0.52 + rng.nextDouble() * 0.22, 0.36 + rng.nextDouble() * 0.2)
        .toColor();
  }

  static Color _byFigure(math.Random rng) {
    final hue = 44 + rng.nextDouble() * 18;
    final sat = 0.72 + rng.nextDouble() * 0.22;
    final val = 0.72 + rng.nextDouble() * 0.22;
    return HSVColor.fromAHSV(1, hue, sat, val).toColor();
  }

  static Color _byBackground(math.Random rng) {
    if (rng.nextBool()) {
      final hue = 200 + rng.nextDouble() * 55;
      return HSVColor.fromAHSV(
              1, hue, 0.45 + rng.nextDouble() * 0.35, 0.42 + rng.nextDouble() * 0.28)
          .toColor();
    }
    final hue = 265 + rng.nextDouble() * 45;
    return HSVColor.fromAHSV(1, hue, 0.38 + rng.nextDouble() * 0.32, 0.45 + rng.nextDouble() * 0.25)
        .toColor();
  }

  @override
  bool shouldRepaint(covariant ColorVisionPlatePainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.seed != seed || oldDelegate.palette != palette;
  }
}
