import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitBoxWidget extends StatelessWidget {
  const DigitBoxWidget({
    required this.boxKey,
    required this.boxIndex,
    required this.label,
    required this.isActive,
    required this.points,
    required this.onTap,
    this.hintText,
    this.size = 140.0,
    super.key,
  });

  final GlobalKey boxKey;
  final int boxIndex; // 0 = onlar, 1 = birler, 2 = yüzler
  final String label;
  final bool isActive;
  final List<DrawingPointMath?> points;
  final VoidCallback onTap;
  final String? hintText;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: size < 120 ? 12 : 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            key: boxKey,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
                width: isActive ? 4 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  if (hintText != null && points.isEmpty)
                    Center(
                      child: Text(
                        hintText!,
                        style: TextStyle(
                          fontSize: size * 0.57,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onPanStart: (details) => _addPoint(context, details.globalPosition),
                    onPanUpdate: (details) => _addPoint(context, details.globalPosition),
                    onPanEnd: (_) {
                      final provider = context.read<MathProgressProvider>();
                      provider.endStroke();
                    },
                    child: CustomPaint(
                      size: Size(size, size),
                      painter: _DigitBoxPainter(points: points),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addPoint(BuildContext context, Offset globalPosition) {
    final provider = context.read<MathProgressProvider>();
    if (provider.activeBox != boxIndex) {
      provider.setActiveBox(boxIndex);
    }
    final renderBox = boxKey.currentContext!.findRenderObject()! as RenderBox;
    final localPosition = renderBox.globalToLocal(globalPosition);
    // Normalize position to 280x280 which the model expects
    final normalizedPosition = localPosition * (280 / size);
    provider.addPoint(
      DrawingPointMath(
        point: normalizedPosition,
        paint: Paint()
          ..color = Colors.black
          ..strokeWidth = 34.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      ),
    );
  }
}

class _DigitBoxPainter extends CustomPainter {
  const _DigitBoxPainter({required this.points});

  final List<DrawingPointMath?> points;

  @override
  void paint(Canvas canvas, Size size) {
    // Normalizasyon ölçeği: Model 280x280'e göre kaydedildi, burada widget 140x140.
    final scale = size.width / 280.0;
    canvas.scale(scale, scale);

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      if (current != null && next != null) {
        canvas.drawLine(current.point, next.point, current.paint);
      } else if (current != null && next == null) {
        canvas.drawCircle(
          current.point,
          current.paint.strokeWidth / 2,
          current.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DigitBoxPainter oldDelegate) {
    return true; // Performans için optimize edilebilir ama şimdilik her eklemede yeniler.
  }
}
