import 'package:flutter/widgets.dart';

import 'package:abc123/core/presentation/responsive/screen_size.dart';

/// [ScreenSize]’a göre çocuğu yeniden oluşturur (`14_adaptive_ui_strategy.md`).
class AdaptiveLayoutBuilder extends StatelessWidget {
  const AdaptiveLayoutBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, ScreenSize screenSize) builder;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final screenSize = ScreenSize.fromWidth(width);
    return builder(context, screenSize);
  }
}
