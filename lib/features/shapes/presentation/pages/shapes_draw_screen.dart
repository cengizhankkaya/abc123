import 'dart:async';

import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/drawing_area_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/letters/presentation/widgets/letter_guide_card.dart';
import 'package:abc123/features/letters/presentation/widgets/letter_right_panel_widget.dart';
import 'package:abc123/features/shapes/l10n/l10n_extensions.dart';
import 'package:abc123/features/shapes/l10n/shapes_shape_lookup.dart';
import 'package:abc123/features/shapes/presentation/providers/shapes_drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    unawaited(getIt<IAudioService>().stopBackground());
    unawaited(OrientationHelper.setPortrait());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShapesDrawingProvider>.value(
      value: context.read<ShapesDrawingProvider>(),
      child: Consumer<ShapesDrawingProvider>(
        builder: (context, provider, _) {
          return _ShapesDrawView(
            provider: provider,
            animation: _animation,
            animationController: _animationController,
          );
        },
      ),
    );
  }
}

class _ShapesDrawView extends StatelessWidget {
  const _ShapesDrawView({
    required this.provider,
    required this.animation,
    required this.animationController,
  });

  final ShapesDrawingProvider provider;
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF55EFC4).withValues(alpha: 0.2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _ControlPanel(provider: provider),
              _MainContentArea(provider: provider, animation: animation),
              _BottomToolbar(
                provider: provider,
                animationController: animationController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({required this.provider});

  final ShapesDrawingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ToolControlPanel(
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
    );
  }
}

class _MainContentArea extends StatelessWidget {
  const _MainContentArea({
    required this.provider,
    required this.animation,
  });

  final ShapesDrawingProvider provider;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final shapesImagePath = _getShapesImagePath(provider);
    final shapesGuide = DrawingGuide(imagePath: shapesImagePath);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingSmall(context) * 0.003,
          vertical: AppSizes.paddingSmall(context) * 0.003,
        ),
        child: Row(
          children: [
            Expanded(
              flex: responsive.isLargeScreen ? 2 : 3,
              child: LetterGuideCard(
                guide: shapesGuide,
                onNext: () {},
                onPrevious: () {},
              ),
            ),
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
                animation: animation,
                tanima: provider.tanima,
                drawingAreaKey: provider.drawingAreaKey,
                onClear: provider.clear,
                onDrawPoint: provider.addPoint,
                onEndDrawing: provider.endLine,
              ),
            ),
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
    );
  }

  String _getShapesImagePath(ShapesDrawingProvider provider) {
    if (!provider.isSequentialModeActive) {
      return ImageConstants.shapesImage;
    }
    switch (provider.currentTargetShape.toUpperCase()) {
      case 'DAIRE':
        return ImageConstants.shapeCircleImage;
      case 'KARE':
        return ImageConstants.shapeSquareImage;
      case 'ÜÇGEN':
      case 'UCGEN':
        return ImageConstants.shapeTriangleImage;
      default:
        return ImageConstants.shapesImage;
    }
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    required this.provider,
    required this.animationController,
  });

  final ShapesDrawingProvider provider;
  final AnimationController animationController;

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
      isSequentialModeActive: provider.isSequentialModeActive,
      onSequentialModeChanged: provider.toggleSequentialMode,
      correctlyDrawnCount: provider.correctlyDrawnCount,
      totalAttempts: provider.totalAttempts,
      panelColor: const Color(0xFF55EFC4),
    );
  }

  Future<void> _handleRecognize(BuildContext context) async {
    if (provider.isLoading) return;
    await provider.recognizeShape(context);

    if (provider.drawingImage != null && provider.recognitionResult.isNotEmpty) {
      animationController.reset();
      unawaited(animationController.forward());

      // Gamification Integration
      if (context.mounted) {
        unawaited(
          context.read<GamificationProvider>().incrementTotalDrawings(type: DrawingType.shape),
        );
      }

      if (context.mounted) {
        if (provider.isSequentialModeActive) {
          unawaited(_navigateSequentialResult(context));
        } else {
          unawaited(_navigateFreeModeResult(context));
        }
      }
    }
  }

  Future<void> _navigateSequentialResult(BuildContext context) async {
    final sl = context.shapesL10n!;
    final isCorrect = provider.evaluateSequentialRecognition();
    final targetShapeCode = provider.currentTargetShape;
    final localizedTargetShape = shapesLabelForCode(sl, targetShapeCode);
    final localizedRecognizedShape = shapesLabelForCode(sl, provider.recognitionResult);

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
  }

  Future<void> _navigateFreeModeResult(BuildContext context) async {
    final sl = context.shapesL10n!;
    final recognizedCode = provider.recognitionResult;
    final localizedShape = shapesLabelForCode(sl, recognizedCode);

    await context.push(
      AppRoutes.result,
      extra: ResultScreenData(
        drawingImage: provider.drawingImage,
        recognizedLetter: localizedShape,
        targetLetter: localizedShape,
        isCorrect: true,
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
