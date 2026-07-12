import 'package:abc123/core/error/failures/failure.dart';

/// Letters feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class LetterFailure extends Failure {
  const LetterFailure();

}

final class LetterRecognitionFailed extends LetterFailure {
  const LetterRecognitionFailed();
}

final class LetterLetterSetLoadFailed extends LetterFailure {
  const LetterLetterSetLoadFailed();
}
