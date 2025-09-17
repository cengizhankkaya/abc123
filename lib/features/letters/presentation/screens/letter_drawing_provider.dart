import 'package:abc123/core/services/audio_service.dart';
import 'package:abc123/core/utils/responsive_size.dart';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

import '../../../draw/data/models/drawing_content.dart';
import '../../../draw/data/models/sequential_drawing.dart';
import '../../../draw/presentation/widgets/build_drawing_area.dart';

class DrawingProvider with ChangeNotifier {
  List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 35.0;

  String tanima = 'Lütfen bir harf çizin';
  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = "";
  Interpreter? interpreter;
  ui.Image? drawingImage;

  final SequentialDrawingManager sequentialManager = SequentialDrawingManager();
  late DrawingGuide activeGuide;

  final List<String> letterLabels = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  double volume = 1.0;

  DrawingProvider() {
    sequentialManager.isLetterMode = true;
    _loadModel();
    activeGuide = DrawingContentProvider.activeLetterGuide;
  }

  Future<void> _loadModel() async {
    try {
      final loadedInterpreter = await Interpreter.fromAsset(
          'assets/models/final_combined_model-2.tflite');
      interpreter = loadedInterpreter;
      notifyListeners();
    } catch (e) {
      tanima = 'Model yüklenemedi: $e';
      notifyListeners();
    }
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
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        tanima = 'Görüntü işlenemedi';
        isLoading = false;
        notifyListeners();
        return;
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final decodedImage = img.decodeImage(pngBytes);
      if (decodedImage == null) {
        tanima = 'Görüntü işlenemedi';
        isLoading = false;
        notifyListeners();
        return;
      }
      final resizedImage = img.copyResize(decodedImage,
          width: 28, height: 28, interpolation: img.Interpolation.average);
      final Uint8List processedData = preprocessImage(resizedImage);
      final result = await runInference(processedData);
      drawingImage?.dispose();
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
    } catch (e) {
      print("Görüntü oluşturma hatası: $e");
      return null;
    }
  }

  Uint8List preprocessImage(img.Image resizedImage) {
    final buffer = Float32List(28 * 28);
    int pixelIndex = 0;
    for (int y = 0; y < 28; y++) {
      for (int x = 0; x < 28; x++) {
        if (pixelIndex < buffer.length) {
          final pixel = resizedImage.getPixel(x, y);
          double grayValue = img.getLuminance(pixel) / 255.0;
          grayValue = 1.0 - grayValue;
          buffer[pixelIndex++] = grayValue;
        }
      }
    }
    return buffer.buffer.asUint8List();
  }

  Future<String> runInference(Uint8List imageData) async {
    if (interpreter == null) {
      throw Exception('Interpreter yüklenmedi');
    }
    try {
      var inputBuffer = Float32List.view(imageData.buffer);
      var inputData = List.generate(
        1,
        (i) => List.generate(
          28,
          (y) => List.generate(
            28,
            (x) {
              final index = y * 28 + x;
              return [inputBuffer[index]];
            },
          ),
        ),
      );
      var output = [List<double>.filled(26, 0)];
      interpreter!.run(inputData, output);
      List<double> probabilities = output[0];
      int maxIndex = 0;
      double maxValue = probabilities[0];
      for (int i = 1; i < probabilities.length; i++) {
        if (probabilities[i] > maxValue) {
          maxValue = probabilities[i];
          maxIndex = i;
        }
      }
      return letterLabels[maxIndex];
    } catch (e) {
      print('Inference hatası: $e');
      throw Exception('Tahmin hatası: $e');
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
    drawingImage?.dispose();
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
