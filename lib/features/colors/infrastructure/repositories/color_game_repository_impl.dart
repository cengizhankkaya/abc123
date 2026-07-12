import 'dart:math';

import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/domain/repositories/i_color_game_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IColorGameRepository)
class ColorGameRepositoryImpl implements IColorGameRepository {
  @override
  List<GamePaletteColor> getPalette(int poolSize) {
    final values = GamePaletteColor.values.toList();
    return values.take(min(poolSize, values.length)).toList();
  }
}
