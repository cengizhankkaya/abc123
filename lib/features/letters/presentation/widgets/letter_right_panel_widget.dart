import 'dart:ui';

import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class LetterRightPanel extends StatefulWidget {

  const LetterRightPanel({
    required this.tanimaText, required this.isLoading, required this.correctlyDrawnCount, super.key,
    this.isSequentialMode = false,
  });
  final String tanimaText;
  final bool isLoading;
  final bool isSequentialMode;
  final int correctlyDrawnCount;

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
    final panelWidth = AppSizes.imageSize(context) * 5.5;
    final panelHeight = AppSizes.imageSize(context) * 7.5;
    return Container(
      margin: EdgeInsets.only(
        right: AppSizes.paddingNormal(context) / 2,
        top: AppSizes.paddingSmall(context),
        bottom: AppSizes.paddingSmall(context),
      ),
      width: panelWidth,
      height: panelHeight,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
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
        const CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 4,
        ),
        SizedBox(height: responsive.height * 0.015),
        Text(
          context.drawL10n!.drawLetterPuzzlePreparing,
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
    final rows = <Widget>[];
    for (var row = 0; row < puzzleRows; row++) {
      final rowPieces = <Widget>[];
      for (var col = 0; col < puzzleCols; col++) {
        final i = row * puzzleCols + col;
        final isOpened = i < widget.correctlyDrawnCount;
        rowPieces.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(width: 0.1),
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
                        ImageConstants.puzzlePieceAssets[row * puzzleCols + col],
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
