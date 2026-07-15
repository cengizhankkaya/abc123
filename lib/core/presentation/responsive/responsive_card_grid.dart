import 'package:abc123/core/presentation/responsive/adaptive_layout_builder.dart';
import 'package:abc123/core/presentation/responsive/build_context_extension.dart';
import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// [ScreenSize]'a göre sütun sayısını ve en-boy oranını otomatik ayarlayan
/// kart grid'i (`14_adaptive_ui_strategy.md` §"Responsive Card Grid").
///
/// Örnek kullanım:
/// ```dart
/// ResponsiveCardGrid(
///   cards: myCards,
/// )
/// ```
class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({
    required this.cards,
    this.compactColumns = 1,
    this.mediumColumns = 2,
    this.expandedColumns = 3,
    this.largeColumns = 4,
    this.extraLargeColumns = 5,
    this.compactAspectRatio = 1.5,
    this.largeAspectRatio = 1.2,
    super.key,
  });

  /// Grid'e yerleştirilecek kart widget'ları.
  final List<Widget> cards;

  /// Compact ekranlarda sütun sayısı (varsayılan: 1).
  final int compactColumns;

  /// Medium ekranlarda sütun sayısı (varsayılan: 2).
  final int mediumColumns;

  /// Expanded ekranlarda sütun sayısı (varsayılan: 3).
  final int expandedColumns;

  /// Large ekranlarda sütun sayısı (varsayılan: 4).
  final int largeColumns;

  /// ExtraLarge ekranlarda sütun sayısı (varsayılan: 5).
  final int extraLargeColumns;

  /// Compact ekranlarda childAspectRatio (varsayılan: 1.5).
  final double compactAspectRatio;

  /// Large ve üzeri ekranlarda childAspectRatio (varsayılan: 1.2).
  final double largeAspectRatio;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutBuilder(
      builder: (context, screenSize) {
        final columns = switch (screenSize) {
          ScreenSize.compact => compactColumns,
          ScreenSize.medium => mediumColumns,
          ScreenSize.expanded => expandedColumns,
          ScreenSize.large => largeColumns,
          ScreenSize.extraLarge => extraLargeColumns,
        };

        final childAspectRatio =
            screenSize.isMobile ? compactAspectRatio : largeAspectRatio;

        // ✅ GridView.builder: kart listesini lazy oluşturur; sabit children[]
        // yerine itemBuilder kullanılarak gereksiz widget allocation önlenir.
        // (16_performance.md §"List Performance Rules")
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: context.responsiveSpacing,
            mainAxisSpacing: context.responsiveSpacing,
            childAspectRatio: childAspectRatio,
          ),
          padding: context.responsivePadding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          itemBuilder: (_, index) => cards[index],
        );
      },
    );
  }
}
