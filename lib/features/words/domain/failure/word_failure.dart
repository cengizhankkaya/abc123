import 'package:abc123/core/error/failures/failure.dart';

/// Words feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class WordFailure extends Failure {
  const WordFailure();

}

final class WordWordListLoadFailed extends WordFailure {
  const WordWordListLoadFailed();
}

final class WordRecognitionFailed extends WordFailure {
  const WordRecognitionFailed();
}
