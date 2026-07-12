import 'package:abc123/features/colors/domain/game_palette_color.dart';

/// Renk oyunu için domain portu.
///
/// Implementation: `infrastructure/repositories/color_game_repository_impl.dart`
abstract interface class IColorGameRepository {
  /// Verilen havuz büyüklüğü (poolSize) için mevcut renk paletini döndürür.
  List<GamePaletteColor> getPalette(int poolSize);
}
