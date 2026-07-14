import 'package:abc123/core/presentation/responsive/adaptive_layout_builder.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// Geniş ekranda içeriği ortalar ve [maxWidth] ile sınırlar (`14_adaptive_ui_strategy.md`).
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    required this.child,
    this.maxWidth = 1200,
    this.centerOnLarge = true,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final bool centerOnLarge;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutBuilder(
      builder: (context, screenSize) {
        if (!centerOnLarge || screenSize.index < ScreenSize.large.index) {
          return child;
        }
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}
