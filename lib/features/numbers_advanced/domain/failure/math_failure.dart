import 'package:abc123/core/error/failures/failure.dart';

/// Numbers Advanced feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class MathFailure extends Failure {
  const MathFailure();
}

final class MathProgressSaveFailed extends MathFailure {
  const MathProgressSaveFailed();
}

final class MathExerciseLoadFailed extends MathFailure {
  const MathExerciseLoadFailed();
}
