
import 'dart:async';

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/main_content_area.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/info_draw_extra.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/letters/presentation/providers/letter_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LetterDrawScreen extends StatefulWidget {
  const LetterDrawScreen({super.key});

  @override
  State<LetterDrawScreen> createState() => _LetterDrawScreenState();
}

class _LetterDrawScreenState extends State<LetterDrawScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    unawaited(OrientationHelper.setLandscape());

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    unawaited(getIt<IAudioService>().playBackground(AppAudios.happyKids));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<LetterDrawingProvider>(context, listen: false)
          .adjustStrokeWidthForScreenSize(20);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    unawaited(OrientationHelper.setPortrait());
    unawaited(getIt<IAudioService>().stopBackground());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawingProvider = Provider.of<LetterDrawingProvider>(context);

    return _LetterDrawView(
      provider: drawingProvider,
      animation: _animation,
    );
  }
}

class _LetterDrawView extends StatelessWidget {
  const _LetterDrawView({
    required this.provider,
    required this.animation,
  });

  final LetterDrawingProvider provider;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF74B9FF).withValues(alpha: 0.2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _ControlPanel(provider: provider),
              _MainContent(provider: provider, animation: animation),
              _BottomToolbar(provider: provider),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({required this.provider});

  final LetterDrawingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ToolControlPanel(
      titleKey: 'letterTitle',
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
      panelColor: const Color(0xFF74B9FF),
      volume: provider.volume,
      onVolumeChanged: provider.setVolume,
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.provider,
    required this.animation,
  });

  final LetterDrawingProvider provider;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MainContentArea(
        activeGuide: provider.currentActiveGuide,
        onNextGuide: provider.nextDrawingGuide,
        onPreviousGuide: provider.previousDrawingGuide,
        points: provider.points,
        eraseMode: provider.eraseMode,
        selectedColor: provider.selectedColor,
        strokeWidth: provider.strokeWidth,
        showResult: provider.showResult,
        isLoading: provider.isLoading,
        recognitionResult: provider.recognitionResult,
        animation: animation,
        tanima: provider.tanima,
        drawingAreaKey: provider.drawingAreaKey,
        onClear: provider.clear,
        onDrawPoint: provider.addPoint,
        onEndDrawing: provider.endLine,
        isSequentialModeActive: provider.sequentialManager.isSequentialModeActive,
        correctlyDrawnCount: provider.sequentialManager.correctlyDrawnCount,
      ),
    );
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({required this.provider});

  final LetterDrawingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ActionToolbarWidget(
      onClear: provider.clear,
      onPenMode: () {
        provider
          ..setColor(Colors.black)
          ..setStrokeWidth(20)
          ..setEraseMode(false);
      },
      onEraseMode: () {
        provider
          ..setEraseMode(true)
          ..setStrokeWidth(35);
      },
      onRecognize: () => _handleRecognize(context),
      eraseMode: provider.eraseMode,
      selectedColor: provider.selectedColor,
      showResult: provider.showResult,
      isLoading: provider.isLoading,
      isSequentialModeActive: provider.sequentialManager.isSequentialModeActive,
      onSequentialModeChanged: provider.toggleSequentialMode,
      correctlyDrawnCount: provider.sequentialManager.correctlyDrawnCount,
      totalAttempts: provider.sequentialManager.totalAttempts,
    );
  }

  Future<void> _handleRecognize(BuildContext context) async {
    if (!provider.showResult && !provider.isLoading) {
      await provider.tanimlaHarf(context);

      if (context.mounted) {
        if (provider.sequentialManager.isSequentialModeActive) {
          final isCorrect = provider.sequentialManager
              .evaluateRecognitionResult(provider.recognitionResult);
          
          await _showResultScreenWithModel(
            context,
            ResultScreenData(
              drawingImage: provider.drawingImage,
              recognizedLetter: provider.recognitionResult,
              targetLetter: provider.sequentialManager.currentTargetLetter,
              isCorrect: isCorrect,
              correctCount: provider.sequentialManager.correctlyDrawnCount,
              totalAttempts: provider.sequentialManager.totalAttempts,
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
          await context.push(
            AppRoutes.infoDraw,
            extra: InfoDrawExtra(
              drawingImage: provider.drawingImage,
              recognizedLetter: provider.recognitionResult,
            ),
          );
        }
      }
    } else if (provider.showResult) {
      provider.updateShowResultAndTanima(false);
    }
  }

  Future<void> _showResultScreenWithModel(BuildContext context, ResultScreenData data) async {
    if (data.isCorrect) {
      unawaited(Provider.of<GamificationProvider>(context, listen: false)
          .incrementTotalDrawings(type: DrawingType.letter, label: data.recognizedLetter),);
    }

    try {
      if (data.isCorrect) {
        unawaited(getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.success, AppAudios.happyKids));
      } else {
        unawaited(getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.fail, AppAudios.happyKids));
      }
      await context.push(AppRoutes.result, extra: data);
    } on Object catch (e, st) {
      getIt<AppLogger>().error(
        'Result screen navigation failed',
        tag: 'LetterDraw',
        error: e,
        stackTrace: st,
      );
      data.onContinue();
    }
  }
}
