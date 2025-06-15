import 'package:abc123/core/utils/responsive_size.dart';
import 'package:abc123/presentation/screens/drawscreen/models/drawing_content.dart';
import 'package:abc123/presentation/screens/drawscreen/widgets/build_drawing_area.dart';
import 'package:abc123/presentation/screens/drawscreen/widgets/drawing_area_widget.dart';
import 'package:abc123/presentation/screens/lettersscreen/widgets/letter_guide_card.dart';
import 'package:abc123/presentation/screens/lettersscreen/widgets/letter_right_panel_widget.dart';

import 'package:flutter/material.dart';

class MainContentArea extends StatelessWidget {
  final DrawingGuide activeGuide;
  final VoidCallback onNextGuide;
  final VoidCallback onPreviousGuide;
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
  final bool isSequentialModeActive;
  final int correctlyDrawnCount;

  const MainContentArea({
    super.key,
    required this.activeGuide,
    required this.onNextGuide,
    required this.onPreviousGuide,
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
    required this.isSequentialModeActive,
    required this.correctlyDrawnCount,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);

    return Row(
      children: [
        // Sol Kenar - Harf Kartları
        Expanded(
          flex: responsive.isLargeScreen ? 2 : 3,
          child: LetterGuideCard(
            guide: activeGuide,
            onNext: onNextGuide,
            onPrevious: onPreviousGuide,
          ),
        ),

        // Orta - Çizim Alanı
        Expanded(
          flex: responsive.isLargeScreen ? 6 : 5,
          child: DrawingAreaWidget(
            points: points,
            eraseMode: eraseMode,
            selectedColor: selectedColor,
            strokeWidth: strokeWidth,
            showResult: showResult,
            isLoading: isLoading,
            recognitionResult: recognitionResult,
            animation: animation,
            tanima: tanima,
            drawingAreaKey: drawingAreaKey,
            onClear: onClear,
            onDrawPoint: onDrawPoint,
            onEndDrawing: onEndDrawing,
          ),
        ),

        // Sağ Kenar - Bilgi Paneli
        Expanded(
          flex: responsive.isLargeScreen ? 2 : 3,
          child: LetterRightPanel(
            tanimaText: tanima,
            isLoading: isLoading,
            isSequentialMode: isSequentialModeActive,
            correctlyDrawnCount: correctlyDrawnCount,
          ),
        ),
      ],
    );
  }
}
