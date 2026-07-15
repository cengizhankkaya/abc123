import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
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
    final responsive = ResponsiveSize(context);

    return Container(
      margin: EdgeInsets.all(AppSizes.paddingSmall(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
      ),
      child: Column(
        children: [
          // Çizim alanı
          Expanded(
            child: RepaintBoundary(
              child: Center(
                child: FittedBox(
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
                    context,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
