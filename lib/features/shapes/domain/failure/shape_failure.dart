import 'package:abc123/core/error/failures/failure.dart';

/// Shapes feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class ShapeFailure extends Failure {
  const ShapeFailure();

}

final class ShapeRecognitionFailed extends ShapeFailure {
  const ShapeRecognitionFailed();
}

final class ShapeShapeSetLoadFailed extends ShapeFailure {
  const ShapeShapeSetLoadFailed();
}
