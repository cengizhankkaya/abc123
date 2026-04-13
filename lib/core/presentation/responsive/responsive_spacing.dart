import 'package:flutter/material.dart';

import 'package:abc123/core/presentation/responsive/build_context_extension.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';

/// [responsivePadding] ile saran çocuk (`14_adaptive_ui_strategy.md`).
class ResponsiveSpacing extends StatelessWidget {
  const ResponsiveSpacing({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsivePadding,
      child: child,
    );
  }
}

/// [ScreenSize]’a göre kare boşluk.
class ResponsiveGap extends StatelessWidget {
  const ResponsiveGap({
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    super.key,
  });

  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final size = switch (screenSize) {
      ScreenSize.compact => mobileSize ?? 8,
      ScreenSize.medium => tabletSize ?? 12,
      _ => desktopSize ?? 16,
    };
    return SizedBox.square(dimension: size);
  }
}
