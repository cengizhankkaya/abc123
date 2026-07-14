import 'dart:ui' as ui;

import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/application/usecases/recognize_number.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/domain/sequential_drawing.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:flutter/material.dart';

/// Çizim ekranı state yöneticisi.
///
/// Refactor (Hexagonal Architecture): TFLite model yükleme ve inference kodu
/// `NumberRecognitionRepositoryImpl` (infrastructure) ve `RecognizeNumber`
/// (application) katmanlarına taşındı. Bu Provider yalnızca UI state yönetir.
class DrawScreenProvider extends ChangeNotifier implements ProgressSource {

  DrawScreenProvider({
    required RecognizeNumber recognizeNumberUseCase,
    this.context,
    this.language = AppLanguage.turkish,
  }) : _recognizeNumberUseCase = recognizeNumberUseCase {
    volume = getIt<IAudioService>().currentVolume;
    sequentialManager.isLetterMode = false;
    sequentialManager.toggleSequentialMode(true);
    activeGuide = DrawingContentProvider.activeGuide;
    strokeWidth = 25.0;
  }
  final RecognizeNumber _recognizeNumberUseCase;
  final GlobalKey drawingAreaKey = GlobalKey();

  // Çizim kontrolleri
  Color selectedColor = Colors.black;
  double strokeWidth = 25;
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  // CustomPainter için veri
  final List<DrawingPoint?> points = [];
  bool eraseMode = false;

  String tanima = 'Bir rakam çizin';
  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = '';
  ui.Image? drawingImage;

  // Sıralı çizim yöneticisi
  final SequentialDrawingManager sequentialManager = SequentialDrawingManager();

  // Aktif rehber
  late DrawingGuide activeGuide;

  // Animasyon için controller dışarıdan alınacak
  AnimationController? animationController;
  Animation<double>? animation;

  BuildContext? context;

  double volume = 1;

  AppLanguage language = AppLanguage.turkish;

  void setAnimationController(AnimationController controller) {
    animationController = controller;
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  void toggleSequentialMode(bool enabled) {
    sequentialManager.toggleSequentialMode(enabled);
    if (enabled) {
      sequentialManager.isLetterMode = false;
      sequentialManager.resetProgress();
      activeGuide = sequentialManager.getCurrentGuide();
      tanima = '${sequentialManager.currentTargetNumber} rakamını çizin';
      animationController?.reset();
      animationController?.forward().then((_) => animationController?.reverse());
      clearDrawing();
    } else {
      activeGuide = DrawingContentProvider.activeGuide;
      tanima = 'Lütfen bir rakam çizin';
    }
    notifyListeners();
  }

  void nextDrawingGuide() {
    if (sequentialManager.isSequentialModeActive) return;
    activeGuide = DrawingContentProvider.nextGuide();
    notifyListeners();
  }

  void previousDrawingGuide() {
    if (sequentialManager.isSequentialModeActive) return;
    activeGuide = DrawingContentProvider.previousGuide();
    notifyListeners();
  }

  Future<void> tanimlaRakam(
    Function showResultScreen,
    Function goToInfoScreen,
  ) async {
    if (sequentialManager.isLetterMode) {
      sequentialManager.isLetterMode = false;
    }
    if (points.isEmpty) {
      tanima = 'Lütfen bir rakam çizin';
      animationController?.forward().then((_) => animationController?.reverse());
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      final image = await _renderToImage();
      if (image == null) {
        tanima = 'Görüntü oluşturulamadı';
        isLoading = false;
        notifyListeners();
        return;
      }
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        tanima = 'Görüntü işlenemedi';
        isLoading = false;
        notifyListeners();
        return;
      }
      final pngBytes = byteData.buffer.asUint8List();

      // ─── Use Case üzerinden tanıma (infrastructure'a direkt erişim yok) ───
      final resultEither = await _recognizeNumberUseCase(pngBytes);
      final recognizedNumber = resultEither.fold(
        (_) {
          tanima = 'Tanıma başarısız';
          return -1;
        },
        (number) => number,
      );

      if (recognizedNumber == -1) {
        isLoading = false;
        notifyListeners();
        return;
      }

      drawingImage = image;
      animationController?.forward();
      recognitionResult = recognizedNumber.toString();
      isLoading = false;
      notifyListeners();

      if (sequentialManager.isSequentialModeActive) {
        final isCorrect =
            sequentialManager.evaluateRecognitionResult(recognitionResult);
        showResultScreen(isCorrect);
        if (!isCorrect) {
          _recordProgressAttempt(false);
        }
        if (isCorrect) {
          updateAfterContinue(true);
        }
      } else {
        goToInfoScreen(drawingImage, recognizedNumber.toString());
      }
    } catch (e) {
      tanima = 'Hata oluştu: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ui.Image?> _renderToImage() async {
    try {
      if (context == null) return null;
      final responsive = ResponsiveSize(context!);
      final drawingSize = responsive.drawingAreaSize;
      final scaleRatio = drawingSize / 280.0;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, drawingSize, drawingSize);
      canvas.drawRect(rect, Paint()..color = Colors.white);
      canvas.scale(scaleRatio, scaleRatio);
      final painter = DrawingPainter(pointsList: points);
      painter.paint(canvas, const Size(280, 280));
      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Image render failed',
        tag: 'DrawScreen',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  void clearDrawing() {
    points.clear();
    showResult = false;
    if (sequentialManager.isSequentialModeActive) {
      tanima = '${sequentialManager.currentTargetNumber} rakamını çizin';
    } else {
      tanima = 'Lütfen bir rakam çizin';
    }
    drawingImage = null;
    animationController?.reset();
    animationController?.forward().then((_) => animationController?.reverse());
    notifyListeners();
  }

  void toggleEraseMode(bool enabled) {
    eraseMode = enabled;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    strokeWidth = width;
    notifyListeners();
  }

  void setColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void addPoint(DrawingPoint? point) {
    points.add(point);
    notifyListeners();
  }

  void endDrawing() {
    points.add(null);
    notifyListeners();
  }

  void updateAfterContinue(bool isCorrect) {
    _recordProgressAttempt(isCorrect);
    sequentialManager.isLetterMode = false;
    sequentialManager.moveToNextNumber(isCorrect);
    activeGuide = sequentialManager.getCurrentGuide();
    tanima = '${sequentialManager.currentTargetNumber} rakamını çizin';
    notifyListeners();
  }

  void setVolume(double value) {
    volume = value;
    getIt<IAudioService>().setVolume(value);
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    language = lang;
    notifyListeners();
  }

  // ─────────────────── ProgressSource İmplementasyonu ───────────────────

  DateTime? _lastActivityDate;
  final Map<String, int> _strugglingItemsMap = {};

  void _recordProgressAttempt(bool isCorrect) {
    _lastActivityDate = DateTime.now();
    if (!isCorrect) {
      final key = '${sequentialManager.currentTargetNumber}';
      _strugglingItemsMap[key] = (_strugglingItemsMap[key] ?? 0) + 1;
    }
  }

  @override
  String get moduleName => 'numbers';

  @override
  double get completionPercentage =>
      (sequentialManager.correctlyDrawnCount / 10.0 * 100.0).clamp(0.0, 100.0);

  @override
  double get accuracyRate =>
      sequentialManager.getSuccessRate().clamp(0.0, 100.0);

  @override
  DateTime? get lastActivityDate => _lastActivityDate;

  @override
  List<String> get strugglingItems {
    final entries = _strugglingItemsMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.map((e) => e.key).toList();
  }
}
