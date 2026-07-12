import 'package:abc123/core/error/failures/failure.dart';

/// Info feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class InfoFailure extends Failure {
  const InfoFailure();

}

final class InfoDataLoadFailed extends InfoFailure {
  const InfoDataLoadFailed();
}
