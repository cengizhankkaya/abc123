import 'package:flutter/material.dart';

/// Ebeveyn Paneli'nde gösterilecek akıllı öneri modeli.
class Recommendation {
  final String title;
  final String description;
  final String targetModule;
  final String routePath;
  final IconData icon;
  final Color accentColor;

  const Recommendation({
    required this.title,
    required this.description,
    required this.targetModule,
    required this.routePath,
    required this.icon,
    required this.accentColor,
  });
}
