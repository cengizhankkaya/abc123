import 'dart:math';

import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/domain/repositories/i_color_game_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IColorGameRepository)
class ColorGameRepositoryImpl implements IColorGameRepository {
  @override
  FutureResult<List<GamePaletteColor>> getPalette(int poolSize) async {
    final values = GamePaletteColor.values.toList();
    return right(values.take(min(poolSize, values.length)).toList());
  }
}
