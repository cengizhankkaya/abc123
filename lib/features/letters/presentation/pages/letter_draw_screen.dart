// ignore_for_file: deprecated_member_use

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:provider/provider.dart';

import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/main_content_area.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/info_draw_extra.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:go_router/go_router.dart';

class LetterDrawScreen extends StatefulWidget {
  const LetterDrawScreen({super.key});

  @override
  State<LetterDrawScreen> createState() => _LetterDrawScreenState();
}

class _LetterDrawScreenState extends State<LetterDrawScreen> with SingleTickerProviderStateMixin {
  final GlobalKey _drawingAreaKey = GlobalKey();
  // Animasyon için controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Ekranı yatay (landscape) moduna zorunlu kılma
    unawaited(OrientationHelper.setLandscape());

    // Animasyon controller'ı
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    getIt<IAudioService>().playBackground(AppAudios.happyKids);

    // Tek seferlik bir ölçeklendirme yap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LetterDrawingProvider>(context, listen: false)
          .adjustStrokeWidthForScreenSize(20.0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Ekran yönünü normale döndürme (dikey mod)
    unawaited(OrientationHelper.setPortrait());
    getIt<IAudioService>().stopBackground();
    super.dispose();
  }

  // _showResultScreen fonksiyonunu güncelliyorum
  void _showResultScreenWithModel(ResultScreenData data) {
    // Gamification Integration
    if (data.isCorrect) {
      Provider.of<GamificationProvider>(context, listen: false)
          .incrementTotalDrawings(type: DrawingType.letter, label: data.recognizedLetter);
    }

    try {
      if (data.isCorrect) {
        getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.success, AppAudios.happyKids);
      } else {
        getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.fail, AppAudios.happyKids);
      }
      context.push(
        AppRoutes.result,
        extra: data,
      );
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Result screen navigation failed',
        tag: 'LetterDraw',
        error: e,
        stackTrace: st,
      );
      data.onContinue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawingProvider = Provider.of<LetterDrawingProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF74B9FF).withOpacity(0.2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Başlık ve Kalem kontrol paneli
              ToolControlPanel(
                titleKey: 'letterTitle',
                strokeWidth: drawingProvider.strokeWidth,
                eraseMode: drawingProvider.eraseMode,
                selectedColor: drawingProvider.selectedColor,
                colors: [
                  Colors.black,
                  Colors.red,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green,
                  Colors.purple,
                  Colors.orange,
                ],
                onStrokeWidthChanged: (width) {
                  drawingProvider.setStrokeWidth(width);
                },
                onColorChanged: (color) {
                  drawingProvider.setColor(color);
                },
                onEraseModeChanged: drawingProvider.setEraseMode,
                panelColor: const Color(0xFF74B9FF),
                volume: drawingProvider.volume,
                onVolumeChanged: drawingProvider.setVolume,
              ),

              // Ana İçerik
              Expanded(
                child: MainContentArea(
                  activeGuide: drawingProvider.currentActiveGuide,
                  onNextGuide: drawingProvider.nextDrawingGuide,
                  onPreviousGuide: drawingProvider.previousDrawingGuide,
                  points: drawingProvider.points,
                  eraseMode: drawingProvider.eraseMode,
                  selectedColor: drawingProvider.selectedColor,
                  strokeWidth: drawingProvider.strokeWidth,
                  showResult: drawingProvider.showResult,
                  isLoading: drawingProvider.isLoading,
                  recognitionResult: drawingProvider.recognitionResult,
                  animation: _animation,
                  tanima: drawingProvider.tanima,
                  drawingAreaKey: _drawingAreaKey,
                  onClear: drawingProvider.clear,
                  onDrawPoint: (point) {
                    drawingProvider.addPoint(point);
                  },
                  onEndDrawing: () {
                    drawingProvider.endLine();
                  },
                  isSequentialModeActive: drawingProvider.sequentialManager.isSequentialModeActive,
                  correctlyDrawnCount: drawingProvider.sequentialManager.correctlyDrawnCount,
                ),
              ),
              // Alt araç çubuğu
              ActionToolbarWidget(
                onClear: drawingProvider.clear,
                onPenMode: () {
                  drawingProvider.setColor(Colors.black);
                  drawingProvider.setStrokeWidth(20.0);
                  drawingProvider.setEraseMode(false);
                },
                onEraseMode: () {
                  drawingProvider.setEraseMode(true);
                  drawingProvider.setStrokeWidth(35.0);
                },
                onRecognize: () async {
                  if (!drawingProvider.showResult && !drawingProvider.isLoading) {
                    await drawingProvider.tanimlaHarf(context);
                    // Sıralı mod aktifse, sonuç ekranını göster
                    if (drawingProvider.sequentialManager.isSequentialModeActive) {
                      final bool isCorrect = drawingProvider.sequentialManager
                          .evaluateRecognitionResult(drawingProvider.recognitionResult);
                      _showResultScreenWithModel(ResultScreenData(
                        drawingImage: drawingProvider.drawingImage,
                        recognizedLetter: drawingProvider.recognitionResult,
                        targetLetter: drawingProvider.sequentialManager.currentTargetLetter,
                        isCorrect: isCorrect,
                        correctCount: drawingProvider.sequentialManager.correctlyDrawnCount,
                        totalAttempts: drawingProvider.sequentialManager.totalAttempts,
                        onTryAgain: () {
                          context.pop();
                          drawingProvider.onResultScreenAction(isCorrect, tryAgain: true);
                        },
                        onContinue: () {
                          context.pop();
                          drawingProvider.onResultScreenAction(isCorrect, tryAgain: false);
                        },
                      ));
                    } else {
                      context.push(
                        AppRoutes.infoDraw,
                        extra: InfoDrawExtra(
                          drawingImage: drawingProvider.drawingImage,
                          recognizedLetter: drawingProvider.recognitionResult,
                        ),
                      );
                    }
                  } else if (drawingProvider.showResult) {
                    drawingProvider.updateShowResultAndTanima(false);
                  }
                },
                eraseMode: drawingProvider.eraseMode,
                selectedColor: drawingProvider.selectedColor,
                showResult: drawingProvider.showResult,
                isLoading: drawingProvider.isLoading,
                isSequentialModeActive: drawingProvider.sequentialManager.isSequentialModeActive,
                onSequentialModeChanged: drawingProvider.toggleSequentialMode,
                correctlyDrawnCount: drawingProvider.sequentialManager.correctlyDrawnCount,
                totalAttempts: drawingProvider.sequentialManager.totalAttempts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
