import 'dart:async';

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/words/l10n/generated/words_localizations.dart';
import 'package:abc123/features/words/l10n/l10n_extensions.dart';
import 'package:abc123/features/words/l10n/word_display_resolver.dart';
import 'package:abc123/features/words/presentation/providers/word_drawing_provider.dart';
import 'package:abc123/features/words/presentation/widgets/word_main_content_area.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WordDrawScreen extends StatefulWidget {
  const WordDrawScreen({super.key});

  @override
  State<WordDrawScreen> createState() => _WordDrawScreenState();
}

class _WordDrawScreenState extends State<WordDrawScreen> with SingleTickerProviderStateMixin {
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
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    unawaited(getIt<IAudioService>().playBackground(AppAudios.happyKids));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<WordDrawingProvider>().adjustStrokeWidthForScreenSize(20);
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
    final lang = context.watch<LanguageProvider>().language;
    final locale = Locale(_languageToLocaleCode(lang));

    final provider = context.watch<WordDrawingProvider>()..ensureSessionForLocale(locale);

    return _WordDrawView(
      provider: provider,
      animation: _animation,
    );
  }

  String _languageToLocaleCode(AppLanguage lang) {
    return switch (lang) {
      AppLanguage.turkish => 'tr',
      AppLanguage.english => 'en',
      _ => 'en',
    };
  }
}

class _WordDrawView extends StatelessWidget {
  const _WordDrawView({
    required this.provider,
    required this.animation,
  });

  final WordDrawingProvider provider;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final wl = context.wordsL10n;
    final displayText =
        wl == null ? provider.hintSpelling : wordDisplayText(wl, provider.hintDisplayKey);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF00B894).withValues(alpha: 0.18),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _ControlPanel(provider: provider),
              _MainContent(
                provider: provider,
                animation: animation,
                displayText: displayText,
              ),
              _BottomToolbar(
                provider: provider,
                displayText: displayText,
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

  final WordDrawingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ToolControlPanel(
      titleKey: 'wordTitle',
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
      panelColor: const Color(0xFF00B894),
      volume: provider.volume,
      onVolumeChanged: provider.setVolume,
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.provider,
    required this.animation,
    required this.displayText,
  });

  final WordDrawingProvider provider;
  final Animation<double> animation;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WordMainContentArea(
        activeGuide: provider.currentActiveGuide,
        emoji: provider.hintEmoji,
        displayText: displayText,
        spelling: provider.hintSpelling,
        activeLetterIndex: provider.session.currentLetterIndex,
        targetLetter: provider.targetLetter,
        points: provider.points,
        eraseMode: provider.eraseMode,
        selectedColor: provider.selectedColor,
        strokeWidth: provider.strokeWidth,
        showResult: provider.showResult,
        isLoading: provider.isLoading,
        recognitionResult: provider.recognitionResult,
        animation: animation,
        tanima: '${provider.targetLetter} harfini çizin',
        drawingAreaKey: GlobalKey(),
        onClear: provider.clear,
        onDrawPoint: provider.addPoint,
        onEndDrawing: provider.endLine,
      ),
    );
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    required this.provider,
    required this.displayText,
  });

  final WordDrawingProvider provider;
  final String displayText;

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
      isSequentialModeActive: false,
      onSequentialModeChanged: (_) {},
      correctlyDrawnCount: provider.session.correctLetters,
      totalAttempts: provider.session.totalAttempts,
      showSequentialControls: false,
      panelColor: const Color(0xFF00B894),
    );
  }

  Future<void> _handleRecognize(BuildContext context) async {
    if (provider.isLoading) return;
    await provider.recognize(context);

    if (context.mounted) {
      final isCorrect = provider.evaluateRecognitionResult();
      await _showResult(
        context,
        ResultScreenData(
          drawingImage: provider.drawingImage,
          recognizedLetter: provider.recognitionResult,
          targetLetter: provider.targetLetter,
          isCorrect: isCorrect,
          correctCount: provider.session.correctLetters,
          totalAttempts: provider.session.totalAttempts,
          onTryAgain: () {
            context.pop();
            provider.onResultAction(isCorrect: isCorrect, tryAgain: true);
          },
          onContinue: () async {
            context.pop();
            final completed = provider.onResultAction(isCorrect: isCorrect, tryAgain: false);
            if (completed) {
              await context.read<GamificationProvider>().recordWordCompleted();
              if (context.mounted) {
                final l10n = context.wordsL10n;
                if (l10n != null) {
                  await _showWordCompleteOverlay(context, l10n: l10n, displayText: displayText);
                }
              }
            }
          },
        ),
      );
    }
  }

  Future<void> _showResult(BuildContext context, ResultScreenData data) async {
    try {
      if (data.isCorrect) {
        unawaited(getIt<IAudioService>()
            .playEffectAndResumeBackground(AppAudios.success, AppAudios.happyKids));
      } else {
        unawaited(getIt<IAudioService>()
            .playEffectAndResumeBackground(AppAudios.fail, AppAudios.happyKids));
      }
      await context.push(AppRoutes.result, extra: data);
    } on Object catch (e, st) {
      getIt<AppLogger>().error(
        'Result screen navigation failed',
        tag: 'WordDraw',
        error: e,
        stackTrace: st,
      );
      data.onContinue();
    }
  }

  Future<void> _showWordCompleteOverlay(
    BuildContext context, {
    required WordsLocalizations l10n,
    required String displayText,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 44)),
                const SizedBox(height: 10),
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.wordComplete,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.wordsContinue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
