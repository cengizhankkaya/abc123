import 'package:abc123/core/error/failures/failure.dart';

/// Home feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class HomeFailure extends Failure {
  const HomeFailure();

}

final class HomeQuestLoadFailed extends HomeFailure {
  const HomeQuestLoadFailed();
}

final class HomeBadgeFetchFailed extends HomeFailure {
  const HomeBadgeFetchFailed();
}

final class HomeShopLoadFailed extends HomeFailure {
  const HomeShopLoadFailed();
}
