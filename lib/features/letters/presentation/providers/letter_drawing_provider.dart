import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/infrastructure/letter_recognition_service.dart';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/domain/sequential_drawing.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';

class LetterDrawingProvider with ChangeNotifier {
  List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 35.0;

  String tanima = 'Lütfen bir harf çizin';
  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = "";
  ui.Image? drawingImage;

  final SequentialDrawingManager sequentialManager = SequentialDrawingManager();
  late DrawingGuide activeGuide;

  double volume = 1.0;

  LetterDrawingProvider() {
    // AudioService içindeki kaydedilmiş ses seviyesini başlat
    volume = AudioService().currentVolume;
    sequentialManager.isLetterMode = true;
    activeGuide = DrawingContentProvider.activeLetterGuide;
  }

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
      final ui.Image? image = await renderToImage(context);
      if (image == null) {
        tanima = 'Görüntü oluşturulamadı';
        isLoading = false;
        notifyListeners();
        return;
      }
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        tanima = 'Görüntü işlenemedi';
        isLoading = false;
        notifyListeners();
        return;
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final result = await LetterRecognitionService.instance.recognizePngBytes(pngBytes);
      // Önceki resmi manuel dispose etme, ResultScreen hâlâ kullanıyor olabilir.
      // GC'ye bırakmak daha güvenli.
      drawingImage = image;
      recognitionResult = result;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      tanima = 'Hata oluştu: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ui.Image?> renderToImage(BuildContext context) async {
    try {
      final responsive = ResponsiveSize(context);
      final double drawingSize = responsive.drawingAreaSize;
      final scaleRatio = drawingSize / 280.0;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, drawingSize, drawingSize);
      canvas.drawRect(rect, Paint()..color = Colors.white);
      canvas.scale(scaleRatio, scaleRatio);
      final painter = DrawingPainter(pointsList: points);
      painter.paint(canvas, Size(280, 280));
      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } catch (e, st) {
      getIt<AppLogger>().error(
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

  void setEraseMode(bool value) {
    eraseMode = value;
    notifyListeners();
  }

  void setColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
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
  void handleResult(bool isCorrect) {
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
  void onResultScreenAction(bool isCorrect, {required bool tryAgain}) {
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
    AudioService().setVolume(value);
    notifyListeners();
  }
}
