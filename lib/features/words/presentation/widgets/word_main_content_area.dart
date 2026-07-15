import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:abc123/features/draw/presentation/widgets/drawing_area_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/main_content_area.dart'
    show MainContentArea;
import 'package:abc123/features/words/presentation/widgets/word_guide_card.dart';
import 'package:abc123/features/words/presentation/widgets/word_right_panel.dart';
import 'package:flutter/material.dart';

/// Kelime çizim ana alanı — harf ekranındaki [MainContentArea] düzeni.
class WordMainContentArea extends StatelessWidget {
  const WordMainContentArea({
    required this.activeGuide,
    required this.emoji,
    required this.displayText,
    required this.spelling,
    required this.activeLetterIndex,
    required this.targetLetter,
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

  final DrawingGuide activeGuide;
  final String emoji;
  final String displayText;
  final String spelling;
  final int activeLetterIndex;
  final String targetLetter;
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall(context) * 0.003,
        vertical: AppSizes.paddingSmall(context) * 0.003,
      ),
      child: Row(
        children: [
          Expanded(
            flex: responsive.isLargeScreen ? 2 : 3,
            child: WordGuideCard(
              guide: activeGuide,
              emoji: emoji,
              displayText: displayText,
              spelling: spelling,
              targetLetter: targetLetter,
            ),
          ),
          Expanded(
            flex: responsive.isLargeScreen ? 6 : 6,
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
          Expanded(
            flex: responsive.isLargeScreen ? 2 : 3,
            child: WordRightPanel(
              emoji: emoji,
              displayText: displayText,
              spelling: spelling,
              activeLetterIndex: activeLetterIndex,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
