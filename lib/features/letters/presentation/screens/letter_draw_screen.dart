// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/services/audio_service.dart';
import 'package:abc123/features/letters/presentation/screens/letter_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../draw/presentation/widgets/action_toolbar_widget.dart';
import '../../../draw/presentation/widgets/main_content_area.dart';
import '../../../draw/presentation/widgets/tool_control_panel.dart';
import '../../../info/presentation/screens/info_screen.dart';
import '../../../info/presentation/screens/result_screen.dart';

// ResultScreenData modelini ekliyorum
class ResultScreenData {
  final ui.Image? drawingImage;
  final String recognizedLetter;
  final dynamic targetLetter;
  final bool isCorrect;
  final int correctCount;
  final int totalAttempts;
  final VoidCallback onTryAgain;
  final VoidCallback onContinue;

  ResultScreenData({
    required this.drawingImage,
    required this.recognizedLetter,
    required this.targetLetter,
    required this.isCorrect,
    required this.correctCount,
    required this.totalAttempts,
    required this.onTryAgain,
    required this.onContinue,
  });
}

class LetterDrawScreen extends StatefulWidget {
  const LetterDrawScreen({super.key});

  @override
  State<LetterDrawScreen> createState() => _LetterDrawScreenState();
}

class _LetterDrawScreenState extends State<LetterDrawScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _drawingAreaKey = GlobalKey();
  // Animasyon için controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Ekranı yatay (landscape) moduna zorunlu kılma
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Animasyon controller'ı
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    AudioService().playBackground(AppAudios.happyKids);

    // Tek seferlik bir ölçeklendirme yap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DrawingProvider>(context, listen: false)
          .adjustStrokeWidthForScreenSize(20.0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Ekran yönünü normale döndürme (dikey mod)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AudioService().stopBackground();
    super.dispose();
  }

  // _showResultScreen fonksiyonunu güncelliyorum
  void _showResultScreenWithModel(ResultScreenData data) {
    try {
      if (data.isCorrect) {
        AudioService().playEffectAndResumeBackground(
            AppAudios.success, AppAudios.happyKids);
      } else {
        AudioService()
            .playEffectAndResumeBackground(AppAudios.fail, AppAudios.happyKids);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            drawingImage: data.drawingImage,
            recognizedLetter: data.recognizedLetter,
            targetLetter: data.targetLetter,
            isCorrect: data.isCorrect,
            correctCount: data.correctCount,
            totalAttempts: data.totalAttempts,
            onTryAgain: data.onTryAgain,
            onContinue: data.onContinue,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Sonuç ekranı açılamadı: $e');
      data.onContinue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawingProvider = Provider.of<DrawingProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundColor,
              AppColors.backgroundColor.withBlue(220),
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
                  isSequentialModeActive:
                      drawingProvider.sequentialManager.isSequentialModeActive,
                  correctlyDrawnCount:
                      drawingProvider.sequentialManager.correctlyDrawnCount,
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
                  if (!drawingProvider.showResult &&
                      !drawingProvider.isLoading) {
                    await drawingProvider.tanimlaHarf(context);
                    // Sıralı mod aktifse, sonuç ekranını göster
                    if (drawingProvider
                        .sequentialManager.isSequentialModeActive) {
                      final bool isCorrect = drawingProvider.sequentialManager
                          .evaluateRecognitionResult(
                              drawingProvider.recognitionResult);
                      _showResultScreenWithModel(ResultScreenData(
                        drawingImage: drawingProvider.drawingImage,
                        recognizedLetter: drawingProvider.recognitionResult,
                        targetLetter: drawingProvider
                            .sequentialManager.currentTargetLetter,
                        isCorrect: isCorrect,
                        correctCount: drawingProvider
                            .sequentialManager.correctlyDrawnCount,
                        totalAttempts:
                            drawingProvider.sequentialManager.totalAttempts,
                        onTryAgain: () {
                          Navigator.pop(context);
                          drawingProvider.onResultScreenAction(isCorrect,
                              tryAgain: true);
                        },
                        onContinue: () {
                          Navigator.pop(context);
                          drawingProvider.onResultScreenAction(isCorrect,
                              tryAgain: false);
                        },
                      ));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoScreen(
                            drawingImage: drawingProvider.drawingImage,
                            recognizedLetter: drawingProvider.recognitionResult,
                          ),
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
                isSequentialModeActive:
                    drawingProvider.sequentialManager.isSequentialModeActive,
                onSequentialModeChanged: drawingProvider.toggleSequentialMode,
                correctlyDrawnCount:
                    drawingProvider.sequentialManager.correctlyDrawnCount,
                totalAttempts: drawingProvider.sequentialManager.totalAttempts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
