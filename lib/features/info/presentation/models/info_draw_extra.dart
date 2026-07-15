import 'dart:ui' as ui;

import 'package:abc123/features/info/presentation/pages/info_screen.dart' show InfoScreen;
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart' show GoRouter;

/// [InfoScreen] için [GoRouter] `extra` yükü.
@immutable
class InfoDrawExtra {
  const InfoDrawExtra({
    required this.recognizedLetter,
    this.drawingImage,
  });

  final ui.Image? drawingImage;
  final String recognizedLetter;
}
