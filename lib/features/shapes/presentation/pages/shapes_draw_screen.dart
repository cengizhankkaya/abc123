import 'dart:async';
// ignore_for_file: deprecated_member_use

import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/shapes/l10n/l10n_extensions.dart';
import 'package:abc123/features/shapes/l10n/shapes_shape_lookup.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/drawing_area_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/features/letters/presentation/widgets/letter_guide_card.dart';
import 'package:abc123/features/letters/presentation/widgets/letter_right_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:provider/provider.dart';

import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/shapes/presentation/providers/shapes_drawing_provider.dart';
import 'package:go_router/go_router.dart';

class ShapesDrawScreen extends StatefulWidget {
  const ShapesDrawScreen({super.key});

  @override
  State<ShapesDrawScreen> createState() => _ShapesDrawScreenState();
}

class _ShapesDrawScreenState extends State<ShapesDrawScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Ekranı yatay modda tut
    unawaited(OrientationHelper.setLandscape());

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    AudioService().playBackground(AppAudios.happyKids);
  }

  @override
  void dispose() {
    _animationController.dispose();
    AudioService().stopBackground();

    // Dikey moda geri dön
    unawaited(OrientationHelper.setPortrait());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShapesDrawingProvider>.value(
      value: context.read<ShapesDrawingProvider>(),
      child: Consumer<ShapesDrawingProvider>(
        builder: (context, provider, _) {
          final responsive = ResponsiveSize(context);

          // Şekiller için rehber kartı:
          // Serbest modda genel shapes görseli,
          // sıralı modda ise hedef şekle göre daire/üçgen/kare görselleri.
          String shapesImagePath;
          if (provider.isSequentialModeActive) {
            switch (provider.currentTargetShape.toUpperCase()) {
              case 'DAIRE':
                shapesImagePath = ImageConstants.shapeCircleImage;
                break;
              case 'KARE':
                shapesImagePath = ImageConstants.shapeSquareImage;
                break;
              case 'ÜÇGEN':
              case 'UCGEN':
                shapesImagePath = ImageConstants.shapeTriangleImage;
                break;
              default:
                shapesImagePath = ImageConstants.shapesImage;
            }
          } else {
            shapesImagePath = ImageConstants.shapesImage;
          }

          final shapesGuide = DrawingGuide(imagePath: shapesImagePath);

          // Çizim alanı key'i provider içinde tutuluyor
          final drawingAreaKey = provider.drawingAreaKey;

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF55EFC4).withOpacity(0.2),
                    Colors.white,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Üst: Harf ekranındaki gibi araç kontrol paneli
                    ToolControlPanel(
                      titleKey: 'shapeTitle',
                      strokeWidth: provider.strokeWidth,
                      eraseMode: provider.eraseMode,
                      selectedColor: provider.selectedColor,
                      colors: const [
                        Colors.black,
                        Colors.red,
                        Colors.blue,
                        Colors.yellow,
                        Colors.green,
                        Colors.purple,
                        Colors.orange,
                      ],
                      onStrokeWidthChanged: provider.setStrokeWidth,
                      onColorChanged: provider.setColor,
                      onEraseModeChanged: provider.setEraseMode,
                      panelColor: const Color(0xFF55EFC4),
                      volume: provider.volume,
                      onVolumeChanged: provider.setVolume,
                    ),
                    // Orta: Harf ekranındaki gibi 3 kolonlu yapı
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingSmall(context) * 0.003,
                          vertical: AppSizes.paddingSmall(context) * 0.003,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  // Sol: Şekil rehber kartı
                                  Expanded(
                                    flex: responsive.isLargeScreen ? 2 : 3,
                                    child: LetterGuideCard(
                                      guide: shapesGuide,
                                      onNext: () {},
                                      onPrevious: () {},
                                    ),
                                  ),
                                  // Orta: Çizim alanı
                                  Expanded(
                                    flex: responsive.isLargeScreen ? 6 : 6,
                                    child: DrawingAreaWidget(
                                      points: provider.points,
                                      eraseMode: provider.eraseMode,
                                      selectedColor: provider.selectedColor,
                                      strokeWidth: provider.strokeWidth,
                                      showResult: false,
                                      isLoading: provider.isLoading,
                                      recognitionResult: '',
                                      animation: _animation,
                                      tanima: provider.tanima,
                                      drawingAreaKey: drawingAreaKey,
                                      onClear: provider.clear,
                                      onDrawPoint: provider.addPoint,
                                      onEndDrawing: () {
                                        provider.endLine();
                                      },
                                    ),
                                  ),
                                  // Sağ: Puzzle paneli (ilerleme için)
                                  Expanded(
                                    flex: responsive.isLargeScreen ? 2 : 3,
                                    child: LetterRightPanel(
                                      tanimaText: provider.tanima,
                                      isLoading: provider.isLoading,
                                      isSequentialMode: provider.isSequentialModeActive,
                                      correctlyDrawnCount: provider.correctlyDrawnCount,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Alt araç çubuğu
                    ActionToolbarWidget(
                      onClear: provider.clear,
                      onPenMode: () {
                        provider.setColor(Colors.black);
                        provider.setStrokeWidth(20.0);
                        provider.setEraseMode(false);
                      },
                      onEraseMode: () {
                        provider.setEraseMode(true);
                        provider.setStrokeWidth(35.0);
                      },
                      onRecognize: () async {
                        if (provider.isLoading) return;
                        await provider.recognizeShape(context);

                        if (provider.drawingImage != null &&
                            provider.recognitionResult.isNotEmpty) {
                          _animationController.reset();
                          _animationController.forward();

                          // Sıralı modda: harf ekranındaki ResultScreen tasarımını kullan
                          if (provider.isSequentialModeActive) {
                            final sl = context.shapesL10n!;
                            final bool isCorrect = provider.evaluateSequentialRecognition();
                            final String targetShapeCode = provider.currentTargetShape;
                            final String localizedTargetShape =
                                shapesLabelForCode(sl, targetShapeCode);

                            // İç mantık için provider.recognitionResult hala
                            // 'DAIRE'/'KARE'/'ÜÇGEN' kodlarını tutuyor; sadece
                            // ekranda gösterirken çevrili halini kullanalım.
                            final String localizedRecognizedShape =
                                shapesLabelForCode(sl, provider.recognitionResult);

                            // Gamification Integration
                            Provider.of<GamificationProvider>(context, listen: false)
                                .incrementTotalDrawings(type: DrawingType.shape);

                            // ignore: use_build_context_synchronously
                            await context.push(
                              AppRoutes.result,
                              extra: ResultScreenData(
                                drawingImage: provider.drawingImage,
                                recognizedLetter: localizedRecognizedShape,
                                targetLetter: localizedTargetShape,
                                isCorrect: isCorrect,
                                correctCount: provider.correctlyDrawnCount,
                                totalAttempts: provider.totalAttempts,
                                onTryAgain: () {
                                  context.pop();
                                  provider.onResultScreenAction(isCorrect, tryAgain: true);
                                },
                                onContinue: () {
                                  context.pop();
                                  provider.onResultScreenAction(isCorrect, tryAgain: false);
                                },
                              ),
                            );
                          } else {
                            // Gamification Integration
                            // Serbest modda da çizim tanındıysa puan ver
                            Provider.of<GamificationProvider>(context, listen: false)
                                .incrementTotalDrawings(type: DrawingType.shape);
                            // Serbest modda da aynı tasarımı, basit bir akışla kullan
                            const bool isCorrect = true;
                            final sl = context.shapesL10n!;
                            final String recognizedCode = provider.recognitionResult;
                            final String localizedShape = shapesLabelForCode(sl, recognizedCode);

                            // ignore: use_build_context_synchronously
                            await context.push(
                              AppRoutes.result,
                              extra: ResultScreenData(
                                drawingImage: provider.drawingImage,
                                recognizedLetter: localizedShape,
                                targetLetter: localizedShape,
                                isCorrect: isCorrect,
                                correctCount: 0,
                                totalAttempts: 0,
                                onTryAgain: () {
                                  context.pop();
                                  provider.clear();
                                },
                                onContinue: () {
                                  context.pop();
                                  provider.clear();
                                },
                              ),
                            );
                          }
                        }
                      },
                      eraseMode: provider.eraseMode,
                      selectedColor: provider.selectedColor,
                      showResult: provider.showResult,
                      isLoading: provider.isLoading,
                      isSequentialModeActive: provider.isSequentialModeActive,
                      onSequentialModeChanged: provider.toggleSequentialMode,
                      correctlyDrawnCount: provider.correctlyDrawnCount,
                      totalAttempts: provider.totalAttempts,
                      panelColor: const Color(0xFF55EFC4),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
