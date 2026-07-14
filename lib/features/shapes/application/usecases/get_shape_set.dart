import 'package:abc123/core/types/result.dart';

/// GetShapeSet use case — Shapes feature (`01_project_structure.md` — Application Layer).
///
/// Şekil setini domain repository üzerinden getirir.
///
/// TODO: [IShapeRepository] bağımlılığını enjekte et ve implemente et.
abstract interface class GetShapeSet {
  FutureResult<void> execute();
}
