import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

/// [InfoScreen] için [GoRouter] `extra` yükü.
@immutable
class InfoDrawExtra {
  InfoDrawExtra({
    this.drawingImage,
    required this.recognizedLetter,
  });

  final ui.Image? drawingImage;
  final String recognizedLetter;
}
