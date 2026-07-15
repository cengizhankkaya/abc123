import 'dart:ui' as ui;

import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:abc123/features/shapes/application/usecases/recognize_shape.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Şekiller için sıralı çizim durum yöneticisi
class ShapesSequentialDrawingManager {
  // Sıralı çizim modu aktif mi
  bool _isSequentialModeActive = false;

  // Kullanıcının çizmesi gereken mevcut şeklin indeksi
  int _currentItemIndex = 0;

  // Doğru çizilen şekil sayısı
  int _correctlyDrawnCount = 0;

  // Toplam deneme sayısı
  int _totalAttempts = 0;

  // Hedef şekiller
  final List<String> _targetShapes = ['DAIRE', 'ÜÇGEN', 'KARE'];

  // Getters
  bool get isSequentialModeActive => _isSequentialModeActive;
  int get correctlyDrawnCount => _correctlyDrawnCount;
  int get totalAttempts => _totalAttempts;

  String get currentTargetShape => _targetShapes[_currentItemIndex % _targetShapes.length];

  // ignore: avoid_positional_boolean_parameters
  void toggleSequentialMode(bool isActive) {
    _isSequentialModeActive = isActive;
    if (isActive) {
      resetProgress();
    }
  }

  // İlerlemeyi sıfırla
  void resetProgress() {
    _currentItemIndex = 0;
    _correctlyDrawnCount = 0;
    _totalAttempts = 0;
  }

  // ignore: avoid_positional_boolean_parameters
  void moveToNextShape(bool wasCorrect) {
    if (!_isSequentialModeActive) return;

    _totalAttempts++;

    if (wasCorrect) {
      _correctlyDrawnCount++;
      _currentItemIndex = (_currentItemIndex + 1) % _targetShapes.length;
    }
  }

  // Tanıma sonucunu değerlendir (sadece doğru/yanlış döner, state'i değiştirmez)
  bool evaluateRecognitionResult(String recognizedShape) {
    final normalizedResult = recognizedShape.trim().toUpperCase();
    final normalizedTarget = currentTargetShape.trim().toUpperCase();
    return normalizedResult == normalizedTarget;
  }

  // Başarı oranını hesapla
  double getSuccessRate() {
    if (_totalAttempts == 0) return 0;
    return (_correctlyDrawnCount / _totalAttempts) * 100;
  }
}

@injectable
class ShapesDrawingProvider extends ChangeNotifier implements ProgressSource {
  ShapesDrawingProvider(
    this._recognizeShapeUseCase,
    this._audioService,
    this._appLogger,
  ) {
    // AudioService içindeki kaydedilmiş ses seviyesini başlat
    volume = _audioService.currentVolume;
    // Başlangıçta sıralı çizim modunu açık başlat
    sequentialManager.toggleSequentialMode(true);
    _updateTanima();
  }

  final RecognizeShape _recognizeShapeUseCase;
  final IAudioService _audioService;
  final AppLogger _appLogger;
  final GlobalKey drawingAreaKey = GlobalKey();

  // Çizim verisi
  final List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 25;

  // Metin ve durumlar
  static const String _freeDrawText = 'Bir şekil çizin (daire, kare veya üçgen)';
  String tanima = _freeDrawText;

  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = '';

  // Sıralı mod yöneticisi
  final ShapesSequentialDrawingManager sequentialManager = ShapesSequentialDrawingManager();

  bool get isSequentialModeActive => sequentialManager.isSequentialModeActive;
  String get currentTargetShape => sequentialManager.currentTargetShape;
  int get correctlyDrawnCount => sequentialManager.correctlyDrawnCount;
  int get totalAttempts => sequentialManager.totalAttempts;

  // Son tahmin doğru mu? (özellikle sıralı modda UI için)
  bool lastPredictionCorrect = true;

  // Ses seviyesi
  double volume = 1;

  ui.Image? drawingImage;

  // Ses için harici servis kullanılacak (AudioService) – burada sadece state var

  void _updateTanima() {
    if (isSequentialModeActive) {
      tanima = 'Sıradaki şekil: $currentTargetShape';
    } else {
      tanima = _freeDrawText;
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

    isLoading = true;
    showResult = false;
    notifyListeners();

    try {
      final image = await _renderToImage(context);
      if (image == null) {
        recognitionResult = 'Görüntü oluşturulamadı';
        isLoading = false;
        showResult = true;
        notifyListeners();
        return;
      }

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        recognitionResult = 'Görüntü işlenemedi';
        isLoading = false;
        showResult = true;
        notifyListeners();
        return;
      }

      final pngBytes = byteData.buffer.asUint8List();

      final resultEither = await _recognizeShapeUseCase(pngBytes);
      final resultLabel = resultEither.fold(
        (failure) => 'Hata oluştu',
        (shape) => shape,
      );

      // Önceki resmi manuel dispose etmiyoruz, sonuç ekranı kullanıyor olabilir.
      drawingImage = image;
      recognitionResult = resultLabel;
      lastPredictionCorrect = true; // varsayılan

      isLoading = false;
      showResult = true;
      notifyListeners();
    } on Object catch (e) {
      recognitionResult = 'Hata oluştu: $e';
      lastPredictionCorrect = false;
      isLoading = false;
      showResult = true;
      notifyListeners();
    }
  }

  Future<ui.Image?> _renderToImage(BuildContext context) async {
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

      DrawingPainter(pointsList: points).paint(canvas, const Size(280, 280));

      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } on Object catch (e, st) {
      _appLogger.error(
        'Image render failed',
        tag: 'ShapesDraw',
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
    showResult = false;
    _updateTanima();
    // drawingImage'i manuel dispose etmiyoruz, GC'ye bırakıyoruz.
    drawingImage = null;
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

  void setVolume(double value) {
    volume = value;
    // ignore: discarded_futures
    _audioService.setVolume(value);
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleSequentialMode(bool enabled) {
    sequentialManager.toggleSequentialMode(enabled);
    clear();
  }

  /// Sıralı modda tanıma sonucunu değerlendirir ve doğru/yanlış bilgisini döner
  bool evaluateSequentialRecognition() {
    if (!isSequentialModeActive) return true;
    final isCorrect = sequentialManager.evaluateRecognitionResult(recognitionResult);
    lastPredictionCorrect = isCorrect;
    return isCorrect;
  }

  /// Sonuç ekranı kapatıldıktan sonra sıralı mod ilerlemesini günceller
  // ignore: avoid_positional_boolean_parameters
  void handleSequentialResult(bool isCorrect) {
    _recordProgressAttempt(isCorrect);
    if (!isSequentialModeActive) return;
    sequentialManager.moveToNextShape(isCorrect);
    _updateTanima();
    notifyListeners();
  }

  /// Sonuç ekranı sonrası yapılacak işlemler (tekrar dene veya devam)
  // ignore: avoid_positional_boolean_parameters
  void onResultScreenAction(bool isCorrect, {required bool tryAgain}) {
    _recordProgressAttempt(isCorrect);
    if (tryAgain) {
      // Aynı şekli tekrar dene
      clear();
    } else {
      // Bir sonrakine geç
      handleSequentialResult(isCorrect);
      clear();
    }
    notifyListeners();
  }

  // ─────────────────── ProgressSource İmplementasyonu ───────────────────

  DateTime? _lastActivityDate;
  final Map<String, int> _strugglingItemsMap = {};

  void _recordProgressAttempt(bool isCorrect) {
    _lastActivityDate = DateTime.now();
    if (!isCorrect) {
      final key = currentTargetShape;
      _strugglingItemsMap[key] = (_strugglingItemsMap[key] ?? 0) + 1;
    }
  }

  @override
  String get moduleName => 'shapes';

  @override
  double get completionPercentage =>
      (sequentialManager.correctlyDrawnCount / 3.0 * 100.0).clamp(0.0, 100.0);

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
