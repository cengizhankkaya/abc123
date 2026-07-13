// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/features/words/l10n/word_display_resolver.dart';
import 'package:abc123/features/words/l10n/l10n_extensions.dart';
import 'package:abc123/features/words/l10n/generated/words_localizations.dart';
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
  final GlobalKey _drawingAreaKey = GlobalKey();

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

    getIt<IAudioService>().playBackground(AppAudios.happyKids);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<WordDrawingProvider>(context, listen: false).adjustStrokeWidthForScreenSize(20.0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    unawaited(OrientationHelper.setPortrait());
    getIt<IAudioService>().stopBackground();
    super.dispose();
  }

  Future<void> _showResult(ResultScreenData data) async {
    try {
      if (data.isCorrect) {
        getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.success, AppAudios.happyKids);
      } else {
        getIt<IAudioService>().playEffectAndResumeBackground(AppAudios.fail, AppAudios.happyKids);
      }
      context.push(AppRoutes.result, extra: data);
    } catch (e, st) {
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
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().language;
    final locale = Locale(_languageToLocaleCode(lang));

    final p = context.watch<WordDrawingProvider>();
    p.ensureSessionForLocale(locale);

    final wl = context.wordsL10n;
    final displayText = wl == null ? p.hintSpelling : _wordDisplayText(wl, p.hintDisplayKey);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF00B894).withOpacity(0.18),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ToolControlPanel(
                titleKey: 'wordTitle',
                strokeWidth: p.strokeWidth,
                eraseMode: p.eraseMode,
                selectedColor: p.selectedColor,
                colors: const [
                  Colors.black,
                  Colors.red,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green,
                  Colors.purple,
                  Colors.orange,
                ],
                onStrokeWidthChanged: p.setStrokeWidth,
                onColorChanged: p.setColor,
                onEraseModeChanged: p.setEraseMode,
                panelColor: const Color(0xFF00B894),
                volume: p.volume,
                onVolumeChanged: p.setVolume,
              ),
              Expanded(
                child: WordMainContentArea(
                  activeGuide: p.currentActiveGuide,
                  emoji: p.hintEmoji,
                  displayText: displayText,
                  spelling: p.hintSpelling,
                  activeLetterIndex: p.session.currentLetterIndex,
                  targetLetter: p.targetLetter,
                  points: p.points,
                  eraseMode: p.eraseMode,
                  selectedColor: p.selectedColor,
                  strokeWidth: p.strokeWidth,
                  showResult: p.showResult,
                  isLoading: p.isLoading,
                  recognitionResult: p.recognitionResult,
                  animation: _animation,
                  tanima: '${p.targetLetter} harfini çizin',
                  drawingAreaKey: _drawingAreaKey,
                  onClear: p.clear,
                  onDrawPoint: p.addPoint,
                  onEndDrawing: p.endLine,
                ),
              ),
              ActionToolbarWidget(
                onClear: p.clear,
                onPenMode: () {
                  p.setColor(Colors.black);
                  p.setStrokeWidth(20.0);
                  p.setEraseMode(false);
                },
                onEraseMode: () {
                  p.setEraseMode(true);
                  p.setStrokeWidth(35.0);
                },
                onRecognize: () async {
                  if (p.isLoading) return;
                  await p.recognize(context);
                  if (!mounted) return;

                  final isCorrect = p.evaluateRecognitionResult();
                  await _showResult(
                    ResultScreenData(
                      drawingImage: p.drawingImage,
                      recognizedLetter: p.recognitionResult,
                      targetLetter: p.targetLetter,
                      isCorrect: isCorrect,
                      correctCount: p.session.correctLetters,
                      totalAttempts: p.session.totalAttempts,
                      onTryAgain: () {
                        context.pop();
                        p.onResultAction(isCorrect: isCorrect, tryAgain: true);
                      },
                      onContinue: () async {
                        context.pop();
                        final completed = p.onResultAction(isCorrect: isCorrect, tryAgain: false);
                        if (completed) {
                          await context.read<GamificationProvider>().recordWordCompleted();
                          if (mounted) {
                            final l10n = context.wordsL10n;
                            if (l10n != null) {
                              await _showWordCompleteOverlay(
                                context,
                                l10n: l10n,
                                displayText: displayText,
                              );
                            }
                          }
                        }
                      },
                    ),
                  );
                },
                eraseMode: p.eraseMode,
                selectedColor: p.selectedColor,
                showResult: p.showResult,
                isLoading: p.isLoading,
                isSequentialModeActive: false,
                onSequentialModeChanged: (_) {},
                correctlyDrawnCount: p.session.correctLetters,
                totalAttempts: p.session.totalAttempts,
                showSequentialControls: false,
                panelColor: const Color(0xFF00B894),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _wordDisplayText(WordsLocalizations l, String key) => wordDisplayText(l, key);

  String _languageToLocaleCode(AppLanguage lang) {
    return switch (lang) {
      AppLanguage.turkish => 'tr',
      AppLanguage.english => 'en',
      _ => 'en',
    };
  }
}

