import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../screens/drawscreen/models/drawing_content.dart';
import '../screens/drawscreen/models/sequential_drawing.dart';
import '../../core/utils/responsive_size.dart';
import '../screens/drawscreen/widgets/build_drawing_area.dart';
import '../../core/services/audio_service.dart';
import 'package:abc123/core/constants/language_constants.dart';

class DrawScreenProvider extends ChangeNotifier {
  final GlobalKey drawingAreaKey = GlobalKey();

  // Çizim kontrolleri
  Color selectedColor = Colors.black;
  double strokeWidth = 25.0;
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
  String recognitionResult = "";
  Interpreter? interpreter;
  ui.Image? drawingImage;

  // Sıralı çizim yöneticisi
  final SequentialDrawingManager sequentialManager = SequentialDrawingManager();

  // Aktif rehber
  late DrawingGuide activeGuide;

  // Animasyon için controller dışarıdan alınacak
  AnimationController? animationController;
  Animation<double>? animation;

  BuildContext? context;

  double volume = 1.0;

  AppLanguage language = AppLanguage.turkish;

  DrawScreenProvider({this.context, this.language = AppLanguage.turkish}) {
    sequentialManager.isLetterMode = false;
    _loadModel();
    activeGuide = DrawingContentProvider.activeGuide;
    strokeWidth = 25.0;
  }

  void setAnimationController(AnimationController controller) {
    animationController = controller;
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _loadModel() async {
    try {
      final loadedInterpreter =
          await Interpreter.fromAsset('assets/models/rakam_model.tflite');
      interpreter = loadedInterpreter;
      notifyListeners();
    } catch (e) {
      tanima = 'Model yüklenemedi: $e';
      notifyListeners();
    }
  }

  void toggleSequentialMode(bool enabled) {
    sequentialManager.toggleSequentialMode(enabled);
    if (enabled) {
      sequentialManager.isLetterMode = false;
      sequentialManager.resetProgress();
      activeGuide = sequentialManager.getCurrentGuide();
      tanima = '${sequentialManager.currentTargetNumber} rakamını çizin';
      animationController?.reset();
      animationController
          ?.forward()
          .then((_) => animationController?.reverse());
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
      Function showResultScreen, Function goToInfoScreen) async {
    if (sequentialManager.isLetterMode) {
      sequentialManager.isLetterMode = false;
    }
    if (points.isEmpty) {
      tanima = 'Lütfen bir rakam çizin';
      animationController
          ?.forward()
          .then((_) => animationController?.reverse());
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      final ui.Image? image = await _renderToImage();
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
      final Uint8List processedData = _preprocessImage(resizedImage);
      final result = await _runInference(processedData);
      drawingImage?.dispose();
      drawingImage = image;
      animationController?.forward();
      recognitionResult = result.toString();
      isLoading = false;
      notifyListeners();
      if (sequentialManager.isSequentialModeActive) {
        final bool isCorrect =
            sequentialManager.evaluateRecognitionResult(recognitionResult);
        showResultScreen(isCorrect);
        if (isCorrect) {
          updateAfterContinue(true);
        }
      } else {
        goToInfoScreen(drawingImage, result.toString());
      }
    } catch (e) {
      tanima = 'Hata oluştu: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  void showResultScreenFn(
      bool isCorrect, Function onTryAgain, Function onContinue) {
    // Bu fonksiyon, ekranda ResultScreen açmak için kullanılacak
    // Ekran widget'ında context ile çağrılacak
  }

  Future<ui.Image?> _renderToImage() async {
    try {
      if (context == null) return null;
      final responsive = ResponsiveSize(context!);
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

  Uint8List _preprocessImage(img.Image resizedImage) {
    final buffer = Float32List(28 * 28);
    int pixelIndex = 0;
    final double threshold = 0.3;
    for (int y = 0; y < 28; y++) {
      for (int x = 0; x < 28; x++) {
        if (pixelIndex < buffer.length) {
          final pixel = resizedImage.getPixel(x, y);
          double grayValue = img.getLuminance(pixel) / 255.0;
          if (grayValue < threshold) {
            grayValue = 0.0;
          }
          buffer[pixelIndex++] = grayValue;
        }
      }
    }
    return buffer.buffer.asUint8List();
  }

  Future<int> _runInference(Uint8List imageData) async {
    if (interpreter == null) {
      throw Exception('Interpreter yüklenmedi');
    }
    try {
      List<List<List<List<double>>>> inputData = List.generate(
        1,
        (i) => List.generate(
          28,
          (y) => List.generate(
            28,
            (x) => List.generate(
              1,
              (c) {
                final index = y * 28 + x;
                if (index < imageData.length / 4) {
                  return index < imageData.length / 4
                      ? imageData[index * 4] / 255.0
                      : 0.0;
                }
                return 0.0;
              },
            ),
          ),
        ),
      );
      var output = [List<double>.filled(10, 0)];
      interpreter!.run(inputData, output);
      int maxIndex = 0;
      double maxValue = output[0][0];
      for (int i = 1; i < 10; i++) {
        if (output[0][i] > maxValue) {
          maxValue = output[0][i];
          maxIndex = i;
        }
      }
      return maxIndex;
    } catch (e) {
      print('Inference hatası: $e');
      throw Exception('Tahmin hatası: $e');
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
    drawingImage?.dispose();
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
    sequentialManager.isLetterMode = false;
    sequentialManager.moveToNextNumber(isCorrect);
    activeGuide = sequentialManager.getCurrentGuide();
    tanima = '${sequentialManager.currentTargetNumber} rakamını çizin';
    notifyListeners();
  }

  void setVolume(double value) {
    volume = value;
    AudioService().setVolume(value);
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    language = lang;
    notifyListeners();
  }
}
