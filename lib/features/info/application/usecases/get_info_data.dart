import 'package:abc123/core/types/result.dart';

/// GetInfoData use case — Info feature (`01_project_structure.md` — Application Layer).
///
/// Bilgi ekranı verilerini domain repository üzerinden getirir.
///
/// TODO: [IInfoRepository] bağımlılığını enjekte et ve implemente et.
abstract interface class GetInfoData {
  FutureResult<void> execute();
}
