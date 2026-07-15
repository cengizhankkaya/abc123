import 'dart:ui' as ui;

import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/application/usecases/recognize_letter.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/domain/sequential_drawing.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LetterDrawingProvider with ChangeNotifier implements ProgressSource {
  LetterDrawingProvider(
    this._recognizeLetterUseCase,
    this._audioService,
    this._appLogger,
  ) {
    // AudioService içindeki kaydedilmiş ses seviyesini başlat
    volume = _audioService.currentVolume;
    sequentialManager.isLetterMode = true;
    activeGuide = DrawingContentProvider.activeLetterGuide;
  }
  final RecognizeLetter _recognizeLetterUseCase;
  final IAudioService _audioService;
  final AppLogger _appLogger;
  final GlobalKey drawingAreaKey = GlobalKey();
  List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 35;

  String tanima = 'Lütfen bir harf çizin';
  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = '';
  ui.Image? drawingImage;

  final SequentialDrawingManager sequentialManager = SequentialDrawingManager();
  late DrawingGuide activeGuide;

  double volume = 1;

  Future<void> tanimlaHarf(BuildContext context) async {
    if (!sequentialManager.isLetterMode) {
      sequentialManager.isLetterMode = true;
    }
    if (points.isEmpty) {
      tanima = 'Lütfen bir harf çizin';
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      final image = await renderToImage(context);
      if (image == null) {
        tanima = 'Görüntü oluşturulamadı';
        isLoading = false;
        notifyListeners();
        return;
      }
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        tanima = 'Görüntü işlenemedi';
        isLoading = false;
        notifyListeners();
        return;
      }
      final pngBytes = byteData.buffer.asUint8List();
      // ─── Use Case üzerinden tanıma (infrastructure'a direkt erişim yok) ───
      final resultEither = await _recognizeLetterUseCase(pngBytes);
      final result = resultEither.fold(
        (_) => '?',
        (letter) => letter,
      );
      // Önceki resmi manuel dispose etme, ResultScreen hâlâ kullanıyor olabilir.
      // GC'ye bırakmak daha güvenli.
      drawingImage = image;
      recognitionResult = result;
      isLoading = false;
      notifyListeners();
    } on Object catch (e) {
      tanima = 'Hata oluştu: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ui.Image?> renderToImage(BuildContext context) async {
    try {
      final responsive = ResponsiveSize(context);
      final drawingSize = responsive.drawingAreaSize;
      final scaleRatio = drawingSize / 280.0;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, drawingSize, drawingSize);
      canvas
        ..drawRect(rect, Paint()..color = Colors.white)
        ..scale(scaleRatio, scaleRatio);
      final painter = DrawingPainter(pointsList: points);
      painter.paint(canvas, const Size(280, 280));
      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } on Object catch (e, st) {
      _appLogger.error(
        'Image render failed',
        tag: 'LetterDraw',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  void addPoint(DrawingPoint? point) {
    points.add(point);
    notifyListeners();
  }

  void endLine() {
    points.add(null);
    notifyListeners();
  }

  void clear() {
    points.clear();
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void setEraseMode(bool value) {
    if (eraseMode == value) return;
    eraseMode = value;
    notifyListeners();
  }

  void setColor(Color color) {
    if (selectedColor == color) return;
    selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    if (strokeWidth == width) return;
    strokeWidth = width;
    notifyListeners();
  }

  void clearDrawing() {
    clear();
    showResult = false;
    if (sequentialManager.isSequentialModeActive) {
      tanima = '${sequentialManager.currentTargetLetter} harfini çizin';
    } else {
      tanima = 'Lütfen bir harf çizin';
    }
    // drawingImage'i manuel dispose etmiyoruz, GC'ye bırakıyoruz.
    drawingImage = null;
    notifyListeners();
  }

  void adjustStrokeWidthForScreenSize(double width) {
    setStrokeWidth(width);
  }

  // Sıralı çizim modunu etkinleştir
  // ignore: avoid_positional_boolean_parameters
  void toggleSequentialMode(bool enabled) {
    sequentialManager.toggleSequentialMode(enabled);
    if (enabled) {
      sequentialManager.resetProgress();
      activeGuide = sequentialManager.getCurrentGuide();
      clearDrawing();
    } else {
      activeGuide = DrawingContentProvider.activeLetterGuide;
    }
    notifyListeners();
  }

  // Sonraki rehbere geç
  void nextDrawingGuide() {
    if (sequentialManager.isSequentialModeActive) return;
    activeGuide = DrawingContentProvider.nextLetterGuide();
    notifyListeners();
  }

  // Önceki rehbere geç
  void previousDrawingGuide() {
    if (sequentialManager.isSequentialModeActive) return;
    activeGuide = DrawingContentProvider.previousLetterGuide();
    notifyListeners();
  }

  // Sıralı mod sonuç ekranı mantığı (ekran açma UI'da kalacak, burada sadece state güncelleme)
  // ignore: avoid_positional_boolean_parameters
  void handleResult(bool isCorrect) {
    _recordProgressAttempt(isCorrect);
    sequentialManager.moveToNextLetter(isCorrect);
    activeGuide = sequentialManager.getCurrentGuide();
    clearDrawing();
    notifyListeners();
  }

  DrawingGuide get currentActiveGuide => activeGuide;

  void updateShowResultAndTanima(bool showResultValue) {
    showResult = showResultValue;
    if (sequentialManager.isSequentialModeActive) {
      tanima = '${sequentialManager.currentTargetLetter} harfini çizin';
    } else {
      tanima = 'Lütfen bir harf çizin';
    }
    notifyListeners();
  }

  /// Sonuç ekranı sonrası yapılacak işlemler (tekrar dene veya devam)
  // ignore: avoid_positional_boolean_parameters
  void onResultScreenAction(bool isCorrect, {required bool tryAgain}) {
    _recordProgressAttempt(isCorrect);
    if (tryAgain) {
      clearDrawing();
    } else {
      handleResult(isCorrect);
      clearDrawing();
    }
    notifyListeners();
  }

  void setVolume(double value) {
    volume = value;
    // ignore: discarded_futures
    _audioService.setVolume(value);
    notifyListeners();
  }

  // ─────────────────── ProgressSource İmplementasyonu ───────────────────

  DateTime? _lastActivityDate;
  final Map<String, int> _strugglingItemsMap = {};

  void _recordProgressAttempt(bool isCorrect) {
    _lastActivityDate = DateTime.now();
    if (!isCorrect) {
      final key = sequentialManager.currentTargetLetter;
      _strugglingItemsMap[key] = (_strugglingItemsMap[key] ?? 0) + 1;
    }
  }

  @override
  String get moduleName => 'letters';

  @override
  double get completionPercentage =>
      (sequentialManager.correctlyDrawnCount / 26.0 * 100.0).clamp(0.0, 100.0);

  @override
  double get accuracyRate => sequentialManager.getSuccessRate().clamp(0.0, 100.0);

  @override
  DateTime? get lastActivityDate => _lastActivityDate;

  @override
  List<String> get strugglingItems {
    final entries = _strugglingItemsMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.map((e) => e.key).toList();
  }
}
