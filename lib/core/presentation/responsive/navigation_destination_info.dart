import 'package:flutter/material.dart';

/// Gezinme hedefini tanımlayan sade veri sınıfı (`14_adaptive_ui_strategy.md`).
///
/// [AdaptiveNavigationScaffold] veya benzeri widget'larda navigasyon
/// destinasyonlarını tip-güvenli biçimde taşımak için kullanılır.
class NavigationDestinationInfo {
  const NavigationDestinationInfo({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.builder,
  });

  /// Destinasyonun görünen etiketi.
  final String label;

  /// Seçili olmayan ikon.
  final IconData icon;

  /// Seçili ikon.
  final IconData selectedIcon;

  /// Destinasyona ait içerik widget'ını oluşturan fonksiyon.
  final Widget Function(BuildContext) builder;
}
