import 'package:abc123/core/types/result.dart';

/// SaveDrawing use case — Draw feature (`01_project_structure.md` — Application Layer).
///
/// Çizimi domain repository üzerinden kaydeder.
///
/// TODO: [IDrawRepository] bağımlılığını enjekte et ve implemente et.
abstract interface class SaveDrawingUseCase {
  FutureResult<void> execute();
}
