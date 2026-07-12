import 'package:abc123/features/colors/domain/game_palette_color.dart';
import 'package:abc123/features/colors/domain/repositories/i_color_game_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetColorPalettesUseCase {
  final IColorGameRepository _repository;

  const GetColorPalettesUseCase(this._repository);

  List<GamePaletteColor> call(int poolSize) {
    return _repository.getPalette(poolSize);
  }
}
