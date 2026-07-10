import 'dart:typed_data';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:image/image.dart' as img;
import 'package:synchronized/synchronized.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// Çok basamaklı rakam tanıma orkestrasyon katmanı.
///
/// Mevcut tek basamaklı `rakam_model.tflite` modelini iki kez çalıştırarak
/// onlar ve birler hanelerini ayrı ayrı tanır; sonuçları birleştirir.
/// Yeni bir TFLite modeli **eklenmez** — mevcut model yeniden kullanılır.
final class MultiDigitRecognitionService {
  MultiDigitRecognitionService._();

  static final MultiDigitRecognitionService instance =
      MultiDigitRecognitionService._();

  static const String _modelPath = 'assets/models/rakam_model.tflite';

  final Lock _loadLock = Lock();
  Interpreter? _interpreter;

  AppLogger get _log => getIt<AppLogger>();

  // ────────────────────────────── Public API ──────────────────────────────

  /// Tek basamaklı rakamı PNG bytes'tan tanır (0–9).
  Future<int> recognizeDigit(Uint8List pngBytes) async {
    await _ensureLoaded();
    return _infer(pngBytes);
  }

  /// İki PNG bytes (onlar hanesi + birler hanesi) → tam sayı (0–99 veya 100).
  ///
  /// Örneğin tens=3, units=0 çizilmişse → 30 döner.
  Future<int> recognizeMultiDigit({
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  }) async {
    await _ensureLoaded();
    final tens = await _infer(tensBytes);
    final units = await _infer(unitsBytes);
    return tens * 10 + units;
  }

  /// Üç PNG bytes (yüzler + onlar + birler) → tam sayı (örneğin 100).
  Future<int> recognizeTripleDigit({
    required Uint8List hundredsBytes,
    required Uint8List tensBytes,
    required Uint8List unitsBytes,
  }) async {
    await _ensureLoaded();
    final hundreds = await _infer(hundredsBytes);
    final tens = await _infer(tensBytes);
    final units = await _infer(unitsBytes);
    return hundreds * 100 + tens * 10 + units;
  }

  // ────────────────────────────── Private ──────────────────────────────

  Future<void> _ensureLoaded() async {
    if (_interpreter != null) return;
    await _loadLock.synchronized(() async {
      if (_interpreter != null) return;
      try {
        _interpreter = await Interpreter.fromAsset(_modelPath);
        _log.debug('Model loaded', tag: 'MultiDigitRecognition');
      } catch (e, st) {
        _log.error(
          'Model load failed',
          tag: 'MultiDigitRecognition',
          error: e,
          stackTrace: st,
        );
        rethrow;
      }
    });
  }

  Future<int> _infer(Uint8List pngBytes) async {
    final decoded = img.decodeImage(pngBytes);
    if (decoded == null) {
      throw Exception('Görüntü decode edilemedi');
    }

    final resized = img.copyResize(
      decoded,
      width: 28,
      height: 28,
      interpolation: img.Interpolation.average,
    );

    final inputData = _toModelInput(resized);
    final output = [List<double>.filled(10, 0)];

    try {
      _interpreter!.run(inputData, output);
    } catch (e, st) {
      _log.error(
        'Inference failed',
        tag: 'MultiDigitRecognition',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }

    final probs = output[0];
    var maxIndex = 0;
    var maxValue = probs[0];
    for (var i = 1; i < probs.length; i++) {
      if (probs[i] > maxValue) {
        maxValue = probs[i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  /// Model girişi: [1][28][28][1] float, MNIST tarzı (beyaz arka plan → 0.0, siyah çizgi → 1.0).
  List<List<List<List<double>>>> _toModelInput(img.Image resized) {
    final buffer = Float32List(28 * 28);
    var pixelIndex = 0;
    const double threshold = 0.20;

    for (var y = 0; y < 28; y++) {
      for (var x = 0; x < 28; x++) {
        final pixel = resized.getPixel(x, y);
        // MNIST format: Beyaz arka plan -> 0.0, siyah çizgi -> 1.0 (ters çevirme işlemi)
        var val = (255.0 - img.getLuminance(pixel)) / 255.0;
        if (val < threshold) val = 0.0;
        buffer[pixelIndex++] = val;
      }
    }

    return [
      List.generate(
        28,
        (y) => List.generate(
          28,
          (x) => [buffer[y * 28 + x]],
        ),
      ),
    ];
  }
}
