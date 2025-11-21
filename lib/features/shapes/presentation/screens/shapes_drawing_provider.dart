import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/utils/responsive_size.dart';
import '../../../draw/presentation/widgets/build_drawing_area.dart';

class ShapesDrawingProvider extends ChangeNotifier {
  final GlobalKey drawingAreaKey = GlobalKey();

  // Çizim verisi
  final List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 25.0;

  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = '';

  ui.Image? drawingImage;
  Interpreter? interpreter;

  // Ses için harici servis kullanılacak (AudioService) – burada sadece state var

  ShapesDrawingProvider() {
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      final loadedInterpreter =
          await Interpreter.fromAsset('assets/models/geometric_shapes_model.tflite');
      interpreter = loadedInterpreter;
      notifyListeners();
    } catch (e) {
      recognitionResult = 'Model yüklenemedi: $e';
      notifyListeners();
    }
  }

  Future<void> recognizeShape(BuildContext context) async {
    if (points.isEmpty) {
      // Boş çizim uyarısı
      recognitionResult = 'Lütfen bir şekil çizin';
      showResult = true;
      notifyListeners();
      return;
    }

    if (interpreter == null) {
      recognitionResult = 'Model hazır değil';
      showResult = true;
      notifyListeners();
      return;
    }

    isLoading = true;
    showResult = false;
    notifyListeners();

    try {
      final ui.Image? image = await _renderToImage(context);
      if (image == null) {
        recognitionResult = 'Görüntü oluşturulamadı';
        isLoading = false;
        showResult = true;
        notifyListeners();
        return;
      }

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        recognitionResult = 'Görüntü işlenemedi';
        isLoading = false;
        showResult = true;
        notifyListeners();
        return;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final decodedImage = img.decodeImage(pngBytes);
      if (decodedImage == null) {
        recognitionResult = 'Görüntü işlenemedi';
        isLoading = false;
        showResult = true;
        notifyListeners();
        return;
      }

      // Model girişi: (1, 128, 128, 3) - 0..1 aralığında float32
      final resizedImage = img.copyResize(
        decodedImage,
        width: 128,
        height: 128,
        interpolation: img.Interpolation.average,
      );

      final Float32List inputBuffer = _preprocessImage(resizedImage);
      final String resultLabel = await _runInference(inputBuffer);

      drawingImage?.dispose();
      drawingImage = image;
      recognitionResult = resultLabel;

      isLoading = false;
      showResult = true;
      notifyListeners();
    } catch (e) {
      recognitionResult = 'Hata oluştu: $e';
      isLoading = false;
      showResult = true;
      notifyListeners();
    }
  }

  Future<ui.Image?> _renderToImage(BuildContext context) async {
    try {
      final responsive = ResponsiveSize(context);
      final double drawingSize = responsive.drawingAreaSize;
      final double scaleRatio = drawingSize / 280.0;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final rect = Rect.fromLTWH(0, 0, drawingSize, drawingSize);
      canvas.drawRect(rect, Paint()..color = Colors.white);

      canvas.scale(scaleRatio, scaleRatio);

      final painter = DrawingPainter(pointsList: points);
      painter.paint(canvas, const Size(280, 280));

      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } catch (e) {
      debugPrint('Görüntü oluşturma hatası (şekiller): $e');
      return null;
    }
  }

  /// 128x128 RGB görüntüyü (1, 128, 128, 3) girişine uygun düz Float32 listeye çevir
  Float32List _preprocessImage(img.Image resizedImage) {
    final buffer = Float32List(128 * 128 * 3);
    int i = 0;

    for (int y = 0; y < 128; y++) {
      for (int x = 0; x < 128; x++) {
        final pixel = resizedImage.getPixel(x, y);
        final r = pixel.r / 255.0;
        final g = pixel.g / 255.0;
        final b = pixel.b / 255.0;
        buffer[i++] = r;
        buffer[i++] = g;
        buffer[i++] = b;
      }
    }

    return buffer;
  }

  Future<String> _runInference(Float32List inputBuffer) async {
    if (interpreter == null) {
      throw Exception('Interpreter yüklenmedi');
    }

    try {
      // Girdi tensörü: [1, 128, 128, 3]
      final inputData = List.generate(
        1,
        (_) => List.generate(
          128,
          (y) => List.generate(
            128,
            (x) {
              final base = (y * 128 + x) * 3;
              return [
                inputBuffer[base],
                inputBuffer[base + 1],
                inputBuffer[base + 2],
              ];
            },
          ),
        ),
      );

      // Çıkış tensörü: [1, N] -> N sınıf olasılığı (bazı modellerde N=4 olabilir)
      final outputShape = interpreter!.getOutputTensor(0).shape;
      final numClasses = outputShape.isNotEmpty ? outputShape.last : 3;
      final output = [List<double>.filled(numClasses, 0)];
      interpreter!.run(inputData, output);
      final probabilities = output[0];
      int maxIndex = 0;
      double maxValue = probabilities[0];

      for (int i = 1; i < probabilities.length; i++) {
        if (probabilities[i] > maxValue) {
          maxValue = probabilities[i];
          maxIndex = i;
        }
      }

      // Temel sınıf adları; model daha fazla çıktı veriyorsa kalanları generic adlandır
      const baseClassNames = ['Circle', 'Square', 'Triangle'];
      final classNames = List<String>.generate(
        numClasses,
        (index) =>
            index < baseClassNames.length ? baseClassNames[index] : 'Class $index',
      );
      if (maxIndex < 0 || maxIndex >= classNames.length) {
        return 'Bilinmeyen şekil';
      }

      final predictedLabelEn = classNames[maxIndex];
      final predictedLabelTr = _localizeShapeLabel(predictedLabelEn);

      // Overlay içinde büyük ve net görünsün diye sadece şekil adını dön
      return predictedLabelTr.toUpperCase();
    } catch (e) {
      debugPrint('Şekil tahmin hatası: $e');
      throw Exception('Tahmin hatası: $e');
    }
  }

  /// İngilizce sınıf adını Türkçe kullanıcı dostu etikete çevir
  String _localizeShapeLabel(String label) {
    switch (label) {
      case 'Circle':
        return 'Daire';
      case 'Square':
        return 'Kare';
      case 'Triangle':
        return 'Üçgen';
      default:
        return label;
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
    showResult = false;
    drawingImage?.dispose();
    drawingImage = null;
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
}


