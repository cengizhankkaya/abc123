import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/domain/repositories/i_color_game_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetColorPalettes {

  const GetColorPalettes(this._repository);
  final IColorGameRepository _repository;

  FutureResult<List<GamePaletteColor>> call(int poolSize) async {
    return _repository.getPalette(poolSize);
  }
}
