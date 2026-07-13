import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/l10n/generated/colors_localizations.dart';

extension GamePaletteColorExtension on GamePaletteColor {
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
