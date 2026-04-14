import 'package:abc123/features/colors/l10n/generated/colors_localizations.dart';
import 'package:flutter/material.dart';

/// Renk eşleştirme paleti (18 renk) — `poolSize` ile listenin başından kesilir.
enum GamePaletteColor {
  red(Color(0xFFE53935)),
  blue(Color(0xFF1E88E5)),
  green(Color(0xFF43A047)),
  yellow(Color(0xFFFDD835)),
  orange(Color(0xFFFB8C00)),
  purple(Color(0xFF8E24AA)),
  pink(Color(0xFFEC407A)),
  cyan(Color(0xFF00ACC1)),
  brown(Color(0xFF6D4C41)),
  lime(Color(0xFF9E9D24)),
  teal(Color(0xFF00897B)),
  indigo(Color(0xFF3949AB)),
  magenta(Color(0xFFC2185B)),
  navy(Color(0xFF1565C0)),
  coral(Color(0xFFFF6E40)),
  gold(Color(0xFFFFB300)),
  violet(Color(0xFF7E57C2)),
  sky(Color(0xFF039BE5));

  const GamePaletteColor(this.color);
  final Color color;

  String localizedName(ColorsLocalizations l) => switch (this) {
        GamePaletteColor.red => l.colorNameRed,
        GamePaletteColor.blue => l.colorNameBlue,
        GamePaletteColor.green => l.colorNameGreen,
        GamePaletteColor.yellow => l.colorNameYellow,
        GamePaletteColor.orange => l.colorNameOrange,
        GamePaletteColor.purple => l.colorNamePurple,
        GamePaletteColor.pink => l.colorNamePink,
        GamePaletteColor.cyan => l.colorNameCyan,
        GamePaletteColor.brown => l.colorNameBrown,
        GamePaletteColor.lime => l.colorNameLime,
        GamePaletteColor.teal => l.colorNameTeal,
        GamePaletteColor.indigo => l.colorNameIndigo,
        GamePaletteColor.magenta => l.colorNameMagenta,
        GamePaletteColor.navy => l.colorNameNavy,
        GamePaletteColor.coral => l.colorNameCoral,
        GamePaletteColor.gold => l.colorNameGold,
        GamePaletteColor.violet => l.colorNameViolet,
        GamePaletteColor.sky => l.colorNameSky,
      };
}
