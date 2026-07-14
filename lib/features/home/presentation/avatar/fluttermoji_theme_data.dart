import 'package:flutter/material.dart';

/// Defines the configuration of the overall visual theme for a FluttermojiCustomizer.
class FluttermojiThemeData {

  FluttermojiThemeData({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    this.unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
  })  : primaryBgColor = primaryBgColor ?? const Color(0xFFFFFFFF),
        secondaryBgColor = secondaryBgColor ?? const Color(0xFFF1F1F1),
        iconColor = iconColor ?? const Color(0xFF9C9C9C),
        selectedIconColor = selectedIconColor ?? const Color(0xFF424242),
        unselectedIconColor = unselectedIconColor ?? const Color(0xFF9C9C9C),
        selectedTileDecoration = selectedTileDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00FF00),
                width: 3,
              ),
            ),
        boxDecoration =
            boxDecoration ?? BoxDecoration(borderRadius: BorderRadius.circular(18)),
        labelTextStyle = labelTextStyle ??
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        scrollPhysics = scrollPhysics ?? const ClampingScrollPhysics(),
        tileMargin = tileMargin ?? const EdgeInsets.all(2),
        tilePadding = tilePadding ?? const EdgeInsets.all(2);
  final TextStyle labelTextStyle;
  final Color primaryBgColor;
  final Color secondaryBgColor;
  final Decoration selectedTileDecoration;
  final Decoration? unselectedTileDecoration;
  final Color iconColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Decoration boxDecoration;
  final ScrollPhysics scrollPhysics;
  final EdgeInsetsGeometry tilePadding;
  final EdgeInsetsGeometry tileMargin;

  FluttermojiThemeData copyWith({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    Decoration? unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
  }) {
    return FluttermojiThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      secondaryBgColor: secondaryBgColor ?? this.secondaryBgColor,
      selectedTileDecoration:
          selectedTileDecoration ?? this.selectedTileDecoration,
      unselectedTileDecoration:
          unselectedTileDecoration ?? this.unselectedTileDecoration,
      iconColor: iconColor ?? this.iconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      boxDecoration: boxDecoration ?? this.boxDecoration,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      tilePadding: tilePadding ?? this.tilePadding,
      tileMargin: tileMargin ?? this.tileMargin,
    );
  }

  static FluttermojiThemeData standard = FluttermojiThemeData(
    primaryBgColor: const Color(0xFFFFFFFF),
    secondaryBgColor: const Color(0xFFF1F1F1),
    iconColor: const Color(0xFF9C9C9C),
    selectedIconColor: const Color(0xFF424242),
    selectedTileDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xFF00FF00),
        width: 3,
      ),
    ),
    boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
    labelTextStyle:
        const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    scrollPhysics: const ClampingScrollPhysics(),
    tileMargin: const EdgeInsets.all(2),
    tilePadding: const EdgeInsets.all(2),
  );
}
