// ignore_for_file: unused_import
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Colors feature rota tanımlamaları (`01_project_structure.md` — Feature Routes).
///
/// Rotalar merkezi [AppRouter] içinde tanımlıdır; bu dosya feature-owned
/// route sabitleri için yedek noktasıdır.
///
/// İleride `part of` pattern'ine geçildiğinde burası ana rota dosyası olacaktır.
abstract final class ColorRoutePaths {
  static const colorGame = AppRoutes.colorGame;
  static const colorVisionGame = AppRoutes.colorVisionGame;
}
