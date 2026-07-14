import 'package:abc123/core/types/result.dart';

/// GetLetterSet use case — Letters feature (`01_project_structure.md` — Application Layer).
///
/// Harf setini domain repository üzerinden getirir.
///
/// TODO: [ILetterRepository] bağımlılığını enjekte et ve implemente et.
abstract interface class GetLetterSet {
  FutureResult<void> execute();
}
