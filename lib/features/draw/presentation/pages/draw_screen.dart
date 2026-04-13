import 'dart:ui' as ui;
import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/draw/presentation/providers/draw_screen_provider.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/main_content_area.dart';
import 'package:abc123/features/draw/presentation/widgets/tool_control_panel.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/info/presentation/models/info_draw_extra.dart';
import 'package:abc123/features/info/presentation/models/result_screen_data.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  DrawScreenProvider? _provider;
  AppLanguage? _lastLang;

  @override
  void initState() {
    super.initState();
    // Ekranı yatay (landscape) moduna zorunlu kılma
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    AudioService().playBackground(AppAudios.happyKids);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final lang = context.watch<LanguageProvider>().language;
    if (_provider == null) {
      _provider = DrawScreenProvider(context: context, language: lang);
      _provider!.setAnimationController(_animationController);
      _lastLang = lang;
    } else if (_lastLang != lang) {
      _provider!.setLanguage(lang);
      _lastLang = lang;
    }
  }

  @override
  void dispose() {
    AudioService().stopBackground();
    _animationController.dispose();
    // Ekran yönünü normale döndürme (dikey mod)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageProvider>();
    return ChangeNotifierProvider<DrawScreenProvider>.value(
      value: _provider!,
      child: Consumer<DrawScreenProvider>(
        builder: (context, provider, _) {
          // DİL VE MODA GÖRE TANIMA METNİNİ HESAPLA
          final d = context.drawL10n!;
          final String tanima;
          if (provider.sequentialManager.isSequentialModeActive) {
            tanima = d.drawNumberInstruction(
              provider.sequentialManager.currentTargetNumber.toString(),
            );
          } else {
            tanima = d.drawAnyNumberInstruction;
          }

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFF7675).withOpacity(0.2),
                    Colors.white,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Başlık ve Kalem kontrol paneli
                    ToolControlPanel(
                      titleKey: 'numberTitle',
                      strokeWidth: provider.strokeWidth,
                      eraseMode: provider.eraseMode,
                      selectedColor: provider.selectedColor,
                      colors: provider.colors,
                      onStrokeWidthChanged: provider.setStrokeWidth,
                      onColorChanged: provider.setColor,
                      volume: provider.volume,
                      onVolumeChanged: provider.setVolume,
                      onEraseModeChanged: provider.toggleEraseMode,
                      panelColor: const Color(0xFFFF7675),
                    ),
                    // Ana İçerik
                    Expanded(
                      child: MainContentArea(
                        correctlyDrawnCount: provider.sequentialManager.correctlyDrawnCount,
                        isSequentialModeActive: provider.sequentialManager.isSequentialModeActive,
                        activeGuide: provider.activeGuide,
                        onNextGuide: provider.nextDrawingGuide,
                        onPreviousGuide: provider.previousDrawingGuide,
                        points: provider.points,
                        eraseMode: provider.eraseMode,
                        selectedColor: provider.selectedColor,
                        strokeWidth: provider.strokeWidth,
                        showResult: provider.showResult,
                        isLoading: provider.isLoading,
                        recognitionResult: provider.recognitionResult,
                        animation: provider.animation!,
                        tanima: tanima,
                        drawingAreaKey: provider.drawingAreaKey,
                        onClear: provider.clearDrawing,
                        onDrawPoint: provider.addPoint,
                        onEndDrawing: provider.endDrawing,
                      ),
                    ),
                    // Alt araç çubuğu
                    ActionToolbarWidget(
                      onClear: provider.clearDrawing,
                      onPenMode: () {
                        provider.setColor(Colors.black);
                        provider.setStrokeWidth(15.0);
                        provider.toggleEraseMode(false);
                      },
                      onEraseMode: () {
                        provider.toggleEraseMode(true);
                        provider.setStrokeWidth(40.0);
                      },
                      onRecognize: () {
                        if (!provider.showResult && !provider.isLoading) {
                          provider.tanimlaRakam(
                            (bool isCorrect) {
                              // Doğruysa success, yanlışsa fail sesi çal
                              if (isCorrect) {
                                AudioService().playEffectAndResumeBackground(
                                    AppAudios.success, AppAudios.happyKids);
                                // Gamification: Puan ekle ve çizim sayısını artır
                                context.read<GamificationProvider>().incrementTotalDrawings(
                                    type: DrawingType.number, label: provider.recognitionResult);
                              } else {
                                AudioService().playEffectAndResumeBackground(
                                    AppAudios.fail, AppAudios.happyKids);
                              }
                              // Sıralı mod sonucu
                              final resultData = ResultScreenData(
                                drawingImage: provider.drawingImage,
                                recognizedLetter: provider.recognitionResult,
                                targetLetter: provider.sequentialManager.currentTargetNumber,
                                isCorrect: isCorrect,
                                correctCount: provider.sequentialManager.correctlyDrawnCount,
                                totalAttempts: provider.sequentialManager.totalAttempts,
                                onTryAgain: () {
                                  context.pop();
                                  provider.clearDrawing();
                                },
                                onContinue: () {
                                  context.pop();
                                  provider.clearDrawing();
                                  provider.updateAfterContinue(false);
                                },
                              );
                              context.push(
                                AppRoutes.result,
                                extra: resultData,
                              );
                            },
                            (ui.Image? image, String result) {
                              // Normal mod sonucu
                              context.push(
                                AppRoutes.infoDraw,
                                extra: InfoDrawExtra(
                                  drawingImage: image,
                                  recognizedLetter: result,
                                ),
                              );
                            },
                          );
                        } else if (provider.showResult) {
                          provider.showResult = false;
                          provider.updateAfterContinue(false);
                        }
                      },
                      eraseMode: provider.eraseMode,
                      selectedColor: provider.selectedColor,
                      showResult: provider.showResult,
                      isLoading: provider.isLoading,
                      isSequentialModeActive: provider.sequentialManager.isSequentialModeActive,
                      onSequentialModeChanged: provider.toggleSequentialMode,
                      correctlyDrawnCount: provider.sequentialManager.correctlyDrawnCount,
                      totalAttempts: provider.sequentialManager.totalAttempts,
                      panelColor: const Color(0xFFFF7675),
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
