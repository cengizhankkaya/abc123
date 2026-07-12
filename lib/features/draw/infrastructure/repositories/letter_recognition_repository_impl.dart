import 'dart:typed_data';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/draw/domain/repositories/i_recognition_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// [IRecognitionRepository] implementasyonu — EMNIST tabanlı A–Z harf tanıma.
///
/// Eski `LetterRecognitionService` singleton mantığı bu adapter sınıfına taşındı.
/// DI ile `@LazySingleton` olarak kaydedilir, Singleton pattern korunur.
@LazySingleton(as: IRecognitionRepository)
final class LetterRecognitionRepositoryImpl implements IRecognitionRepository {
  static const List<String> _labels = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  final Lock _loadLock = Lock();
  Interpreter? _interpreter;

  Future<void> _ensureLoaded() async {
    if (_interpreter != null) return;
    await _loadLock.synchronized(() async {
      if (_interpreter != null) return;
      _interpreter = await Interpreter.fromAsset(
        'assets/models/final_combined_model-2.tflite',
      );
    });
  }

  @override
  FutureResult<String> recognizeLetter(Uint8List imageBytes) async {
    try {
      await _ensureLoaded();

      final decoded = img.decodeImage(imageBytes);
      if (decoded == null) {
        return Left(_RecognitionFailure('Görüntü decode edilemedi'));
      }

      final resized = img.copyResize(
        decoded,
        width: 28,
        height: 28,
        interpolation: img.Interpolation.average,
      );

      final inputData = _toModelInput(resized);
      final output = [List<double>.filled(26, 0)];

      _interpreter!.run(inputData, output);

      final probs = output[0];
      var maxIndex = 0;
      var maxValue = probs[0];
      for (var i = 1; i < probs.length; i++) {
        if (probs[i] > maxValue) {
          maxValue = probs[i];
          maxIndex = i;
        }
      }

      return Right(_labels[maxIndex]);
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Letter inference failed',
        tag: 'LetterRecognitionRepositoryImpl',
        error: e,
        stackTrace: st,
      );
      return Left(_RecognitionFailure(e.toString()));
    }
  }

  /// Model girişi: [1][28][28][1] float.
  List<List<List<List<double>>>> _toModelInput(img.Image resized) {
    final buffer = Float32List(28 * 28);
    var pixelIndex = 0;
    for (var y = 0; y < 28; y++) {
      for (var x = 0; x < 28; x++) {
        final pixel = resized.getPixel(x, y);
        var gray = img.getLuminance(pixel) / 255.0;
        gray = 1.0 - gray; // invert: beyaz zemin → siyah arka plan
        buffer[pixelIndex++] = gray;
      }
    }
    return [
      List.generate(
        28,
        (y) => List.generate(28, (x) => [buffer[y * 28 + x]]),
      ),
    ];
  }
}

/// Bu sınıfa özgü failure — `DrawFailure` hiyerarşisini şişirmemek için iç tip.
final class _RecognitionFailure extends Failure {
  final String message;
  const _RecognitionFailure(this.message);
}
