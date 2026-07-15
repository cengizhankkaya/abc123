import 'dart:typed_data';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:image/image.dart' as img;
import 'package:synchronized/synchronized.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// A–Z Latin harf tanıma (TFLite) — harf çizim ve kelime modülü ortak kullanır.
final class LetterRecognitionService {
  LetterRecognitionService._();

  static final LetterRecognitionService instance = LetterRecognitionService._();

  static const List<String> labels = [
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
    'Z',
  ];

  final Lock _loadLock = Lock();
  Interpreter? _interpreter;

  Future<void> _ensureLoaded() async {
    if (_interpreter != null) return;
    await _loadLock.synchronized(() async {
      if (_interpreter != null) return;
      _interpreter = await Interpreter.fromAsset('assets/models/final_combined_model-2.tflite');
    });
  }

  /// PNG bytes → tanınan harf (A–Z).
  Future<String> recognizePngBytes(Uint8List pngBytes) async {
    await _ensureLoaded();

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
    final output = [List<double>.filled(26, 0)];

    try {
      _interpreter!.run(inputData, output);
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Inference failed',
        tag: 'LetterRecognition',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }

    final probs = output[0];
    var maxIndex = 0;
    var maxValue = probs[0];
    for (var i = 1; i < probs.length; i++) {
      final v = probs[i];
      if (v > maxValue) {
        maxValue = v;
        maxIndex = i;
      }
    }
    return labels[maxIndex];
  }

  /// Model girişi: [1][28][28][1] float.
  List<List<List<List<double>>>> _toModelInput(img.Image resized) {
    final buffer = Float32List(28 * 28);
    var pixelIndex = 0;
    for (var y = 0; y < 28; y++) {
      for (var x = 0; x < 28; x++) {
        final pixel = resized.getPixel(x, y);
        var gray = img.getLuminance(pixel) / 255.0;
        gray = 1.0 - gray;
        buffer[pixelIndex++] = gray;
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
