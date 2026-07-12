import 'package:abc123/core/types/result.dart';

/// GetMathExercises use case — Numbers Advanced feature (`01_project_structure.md` — Application Layer).
///
/// Matematik alıştırmalarını domain repository üzerinden getirir.
///
/// TODO: [IMathRepository] bağımlılığını enjekte et ve implemente et.
abstract interface class GetMathExercisesUseCase {
  FutureResult<void> execute();
}
