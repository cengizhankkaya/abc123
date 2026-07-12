import 'package:abc123/core/error/failures/failure.dart';

/// Colors feature'a özgü failure tipleri (`01_project_structure.md`).
sealed class ColorFailure extends Failure {
  const ColorFailure();

}

final class ColorGameLoadFailed extends ColorFailure {
  const ColorGameLoadFailed();
}

final class ColorPaletteFetchFailed extends ColorFailure {
  const ColorPaletteFetchFailed();
}
