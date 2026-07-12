import 'package:abc123/core/error/failures/failure.dart';

/// Parent Panel feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class ParentPanelFailure extends Failure {
  const ParentPanelFailure();

}

final class ParentPanelAuthFailed extends ParentPanelFailure {
  const ParentPanelAuthFailed();
}

final class ParentPanelProgressLoadFailed extends ParentPanelFailure {
  const ParentPanelProgressLoadFailed();
}

final class ParentPanelScreenTimeSaveFailed extends ParentPanelFailure {
  const ParentPanelScreenTimeSaveFailed();
}
