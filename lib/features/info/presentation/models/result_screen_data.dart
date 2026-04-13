import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

/// Sonuç ekranına taşınan veri (çizim oyunları ortak modeli).
@immutable
class ResultScreenData {
  ResultScreenData({
    required this.drawingImage,
    required this.recognizedLetter,
    required this.targetLetter,
    required this.isCorrect,
    required this.correctCount,
    required this.totalAttempts,
    required this.onTryAgain,
    required this.onContinue,
  });

  final ui.Image? drawingImage;
  final String recognizedLetter;
  final Object? targetLetter;
  final bool isCorrect;
  final int correctCount;
  final int totalAttempts;
  final VoidCallback onTryAgain;
  final VoidCallback onContinue;
}
