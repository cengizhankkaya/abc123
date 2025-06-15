import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

class LetterRightPanel extends StatefulWidget {
  final String tanimaText;
  final bool isLoading;
  final bool isSequentialMode;
  final int correctlyDrawnCount;

  const LetterRightPanel({
    super.key,
    required this.tanimaText,
    required this.isLoading,
    this.isSequentialMode = false,
    required this.correctlyDrawnCount,
  });

  @override
  State<LetterRightPanel> createState() => _LetterRightPanelState();
}

class _LetterRightPanelState extends State<LetterRightPanel> {
  // Puzzle parça sayısı
  final int puzzleRows = 13;
  final int puzzleCols = 2;

  // Açılan parça sayısı (ör: doğru harf sayısı)
  int openedParts = 0;

  final List<Color> puzzlePieceColors = [
    Colors.cyan,
    Colors.purpleAccent,
    Colors.green,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void didUpdateWidget(covariant LetterRightPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAndUpdatePuzzle();
  }

  @override
  void initState() {
    super.initState();
    _checkAndUpdatePuzzle();
  }

  void _checkAndUpdatePuzzle() {
    if (widget.isLoading) return;
    // Tüm parçaları aç
    setState(() {
      openedParts = widget.correctlyDrawnCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);

    // Panel boyutunu daha büyük ve dinamik yap
    final double panelWidth = responsive.width * 0.55;
    final double panelHeight = responsive.height * 0.75;
    return Container(
      margin: EdgeInsets.only(
        right: responsive.sidePadding / 2, // kenar boşluğunu azalt
        top: responsive.height * 0.01,
        bottom: responsive.height * 0.01,
      ),
      width: panelWidth,
      height: panelHeight,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: widget.isLoading
                        ? _buildLoadingContent(responsive)
                        : _buildPuzzleImage(panelWidth, panelHeight),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent(ResponsiveSize responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 4,
        ),
        SizedBox(height: responsive.height * 0.015),
        Text(
          "Puzzle hazırlanıyor...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.subtitleFontSize * 1.1,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPuzzleImage(double panelWidth, double panelHeight) {
    List<Widget> rows = [];
    for (int row = 0; row < puzzleRows; row++) {
      List<Widget> rowPieces = [];
      for (int col = 0; col < puzzleCols; col++) {
        int i = row * puzzleCols + col;
        bool isOpened = i < widget.correctlyDrawnCount;
        rowPieces.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: isOpened
                  ? Image.asset(
                      ImageConstants.puzzlePieceAssets[row * puzzleCols + col],
                      fit: BoxFit.cover,
                    )
                  : ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Image.asset(
                        ImageConstants
                            .puzzlePieceAssets[row * puzzleCols + col],
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        );
      }
      rows.add(
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowPieces,
          ),
        ),
      );
    }
    return Center(
      child: SizedBox(
        width: panelWidth,
        height: panelHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        ),
      ),
    );
  }
}
