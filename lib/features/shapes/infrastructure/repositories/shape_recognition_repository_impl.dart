import 'dart:typed_data';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/shapes/domain/repositories/i_shape_recognition_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

@LazySingleton(as: IShapeRecognitionRepository)
final class ShapeRecognitionRepositoryImpl implements IShapeRecognitionRepository {
  final Lock _loadLock = Lock();
  Interpreter? _interpreter;

  Future<void> _ensureLoaded() async {
    if (_interpreter != null) return;
    await _loadLock.synchronized(() async {
      if (_interpreter != null) return;
      _interpreter = await Interpreter.fromAsset(
        'assets/models/geometric_shapes_model.tflite',
      );
    });
  }

  @override
  FutureResult<String> recognizeShape(Uint8List imageBytes) async {
    try {
      await _ensureLoaded();

      final decoded = img.decodeImage(imageBytes);
      if (decoded == null) {
        return Left(_ShapeRecognitionFailure('Görüntü decode edilemedi'));
      }

      final resized = img.copyResize(
        decoded,
        width: 128,
        height: 128,
        interpolation: img.Interpolation.average,
      );

      final inputBuffer = _preprocessImage(resized);
      final resultLabel = await _runInference(inputBuffer);

      return Right(resultLabel);
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Shape inference failed',
        tag: 'ShapeRecognitionRepositoryImpl',
        error: e,
        stackTrace: st,
      );
      return Left(_ShapeRecognitionFailure(e.toString()));
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
    if (_interpreter == null) {
      throw Exception('Interpreter yüklenmedi');
    }

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

    // Çıkış tensörü: [1, N] -> N sınıf olasılığı
    final outputShape = _interpreter!.getOutputTensor(0).shape;
    final numClasses = outputShape.isNotEmpty ? outputShape.last : 3;
    final output = [List<double>.filled(numClasses, 0)];
    _interpreter!.run(inputData, output);
    final probabilities = output[0];
    
    int maxIndex = 0;
    double maxValue = probabilities[0];

    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > maxValue) {
        maxValue = probabilities[i];
        maxIndex = i;
      }
    }

    const baseClassNames = ['Circle', 'Square', 'Triangle'];
    final classNames = List<String>.generate(
      numClasses,
      (index) => index < baseClassNames.length ? baseClassNames[index] : 'Class $index',
    );
    if (maxIndex < 0 || maxIndex >= classNames.length) {
      return 'Bilinmeyen şekil';
    }

    final predictedLabelEn = classNames[maxIndex];
    final predictedLabelTr = _localizeShapeLabel(predictedLabelEn);

    return predictedLabelTr.toUpperCase();
  }

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
}

final class _ShapeRecognitionFailure extends Failure {
  final String message;
  const _ShapeRecognitionFailure(this.message);
}
