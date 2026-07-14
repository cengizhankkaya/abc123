import 'dart:typed_data';

import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/draw/domain/repositories/i_number_recognition_repository.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// [INumberRecognitionRepository] implementasyonu — 0–9 rakam tanıma.
///
/// `DrawScreenProvider`'daki `_loadModel`, `_preprocessImage`, `_runInference`
/// mantığı bu infrastructure adapter sınıfına taşındı.
@LazySingleton(as: INumberRecognitionRepository)
final class NumberRecognitionRepositoryImpl extends BaseRepository implements INumberRecognitionRepository {
  NumberRecognitionRepositoryImpl(
    super.exceptionHandler,
    super.failureMapper,
  );
  final Lock _loadLock = Lock();
  Interpreter? _interpreter;

  Future<void> _ensureLoaded() async {
    if (_interpreter != null) return;
    await _loadLock.synchronized(() async {
      if (_interpreter != null) return;
      _interpreter = await Interpreter.fromAsset(
        'assets/models/rakam_model.tflite',
      );
    });
  }

  @override
  FutureResult<int> recognizeNumber(Uint8List imageBytes) => execute(() async {
    await _ensureLoaded();

    final decoded = img.decodeImage(imageBytes);
    if (decoded == null) {
      throw Exception('Görüntü decode edilemedi');
    }

    final resized = img.copyResize(
      decoded,
      width: 28,
      height: 28,
      interpolation: img.Interpolation.average,
    );

    final processedData = _preprocessImage(resized);
    final result = await _runInference(processedData);
    return result;
  });

  /// Görüntüyü modele uygun float formatına dönüştürür (28×28, threshold uygulanır).
  Uint8List _preprocessImage(img.Image resizedImage) {
    final buffer = Float32List(28 * 28);
    var pixelIndex = 0;
    const threshold = 0.3;
    for (var y = 0; y < 28; y++) {
      for (var x = 0; x < 28; x++) {
        if (pixelIndex < buffer.length) {
          final pixel = resizedImage.getPixel(x, y);
          var grayValue = img.getLuminance(pixel) / 255.0;
          if (grayValue < threshold) grayValue = 0.0;
          buffer[pixelIndex++] = grayValue;
        }
      }
    }
    return buffer.buffer.asUint8List();
  }

  /// TFLite inference — [1, 28, 28, 1] giriş, 10 sınıflı çıkış.
  Future<int> _runInference(Uint8List imageData) async {
    final inputData = List.generate(
      1,
      (i) => List.generate(
        28,
        (y) => List.generate(
          28,
          (x) => List.generate(1, (c) {
            final index = y * 28 + x;
            if (index < imageData.length ~/ 4) {
              return imageData[index * 4] / 255.0;
            }
            return 0.0;
          }),
        ),
      ),
    );

    final output = [List<double>.filled(10, 0)];
    _interpreter!.run(inputData, output);

    var maxIndex = 0;
    var maxValue = output[0][0];
    for (var i = 1; i < 10; i++) {
      if (output[0][i] > maxValue) {
        maxValue = output[0][i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }
}

final class _NumberRecognitionFailure extends Failure {
  const _NumberRecognitionFailure(this.message);
  final String message;
}
