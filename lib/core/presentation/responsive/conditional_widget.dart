import 'package:abc123/core/presentation/responsive/adaptive_layout_builder.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// Ekran boyutuna göre farklı widget gösteren yardımcı widget
/// (`14_adaptive_ui_strategy.md` §"Conditional Widget Display").
///
/// - [mobile]: Compact ekranlarda gösterilir (zorunlu).
/// - [tablet]: Medium ekranlarda gösterilir; yoksa [mobile] kullanılır.
/// - [desktop]: Expanded ve üzeri ekranlarda gösterilir; yoksa [tablet] veya [mobile] kullanılır.
///
/// Örnek kullanım:
/// ```dart
/// ConditionalWidget(
///   mobile: const MobileLayout(),
///   tablet: const TabletLayout(),
///   desktop: const DesktopLayout(),
/// )
/// ```
class ConditionalWidget extends StatelessWidget {
  const ConditionalWidget({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  /// Compact ekranlarda gösterilen widget (zorunlu).
  final Widget mobile;

  /// Medium ekranlarda gösterilen widget. Belirtilmezse [mobile] kullanılır.
  final Widget? tablet;

  /// Expanded ve üzeri ekranlarda gösterilen widget.
  /// Belirtilmezse [tablet] veya [mobile] kullanılır.
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutBuilder(
      builder: (context, screenSize) {
        if (screenSize == ScreenSize.compact) return mobile;
        if (screenSize.supportsTwoPane && desktop != null) return desktop!;
        return tablet ?? mobile;
      },
    );
  }
}
