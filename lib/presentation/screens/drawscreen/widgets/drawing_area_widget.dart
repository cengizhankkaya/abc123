import 'package:abc123/core/utils/responsive_size.dart';
import 'package:abc123/presentation/screens/drawscreen/widgets/build_drawing_area.dart';
import 'package:flutter/material.dart';

class DrawingAreaWidget extends StatelessWidget {
  final List<DrawingPoint?> points;
  final bool eraseMode;
  final Color selectedColor;
  final double strokeWidth;
  final bool showResult;
  final bool isLoading;
  final String recognitionResult;
  final Animation<double> animation;
  final String tanima;
  final GlobalKey drawingAreaKey;
  final VoidCallback onClear;
  final Function(DrawingPoint?) onDrawPoint;
  final VoidCallback onEndDrawing;

  const DrawingAreaWidget({
    super.key,
    required this.points,
    required this.eraseMode,
    required this.selectedColor,
    required this.strokeWidth,
    required this.showResult,
    required this.isLoading,
    required this.recognitionResult,
    required this.animation,
    required this.tanima,
    required this.drawingAreaKey,
    required this.onClear,
    required this.onDrawPoint,
    required this.onEndDrawing,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);

    return Container(
      margin: EdgeInsets.all(responsive.height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // Çizim alanı
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: buildDrawingArea(
                  Size(responsive.width, responsive.height),
                  drawingAreaKey,
                  points,
                  eraseMode,
                  selectedColor,
                  strokeWidth,
                  showResult,
                  isLoading,
                  recognitionResult,
                  animation,
                  tanima,
                  onClear,
                  onDrawPoint,
                  onEndDrawing,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
