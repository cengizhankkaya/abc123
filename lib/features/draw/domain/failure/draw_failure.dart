import 'package:abc123/core/error/failures/failure.dart';

/// Draw feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class DrawFailure extends Failure {
  const DrawFailure();
}

final class DrawRecognitionFailed extends DrawFailure {
  const DrawRecognitionFailed();
}

final class DrawExportFailed extends DrawFailure {
  const DrawExportFailed();
}
