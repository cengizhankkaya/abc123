import 'dart:math';

import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/domain/repositories/i_color_game_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IColorGameRepository)
class ColorGameRepositoryImpl extends BaseRepository implements IColorGameRepository {
  ColorGameRepositoryImpl(
    super.exceptionHandler,
    super.failureMapper,
  );

  @override
  FutureResult<List<GamePaletteColor>> getPalette(int poolSize) => execute(() async {
    final values = GamePaletteColor.values.toList();
    return values.take(min(poolSize, values.length)).toList();
  });
}
