import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:flutter/material.dart';

class DrawingAreaWidget extends StatelessWidget {
  const DrawingAreaWidget({
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
    super.key,
  });

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
  final void Function(DrawingPoint?) onDrawPoint;
  final VoidCallback onEndDrawing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.paddingSmall(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
      ),
      child: Column(
        children: [
          // Çizim alanı — DrawingArea kendi içinde RepaintBoundary barındırıyor.
          Expanded(
            child: Center(
              child: FittedBox(
                // ✅ buildDrawingArea() fonksiyonu yerine DrawingArea widget'ı
                // (16_performance.md §"Extract Widgets Instead of Methods")
                child: DrawingArea(
                  drawingAreaKey: drawingAreaKey,
                  points: points,
                  eraseMode: eraseMode,
                  selectedColor: selectedColor,
                  strokeWidth: strokeWidth,
                  showResult: showResult,
                  isLoading: isLoading,
                  recognitionResult: recognitionResult,
                  animation: animation,
                  tanima: tanima,
                  onClear: onClear,
                  onAddPoint: onDrawPoint,
                  onEndLine: onEndDrawing,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
