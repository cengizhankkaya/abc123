import 'package:abc123/core/feature_flags/feature_flag.dart';

/// Öncelik: yerel override → uzak değer → enum varsayılanı (`0013-feature-flags.md`).
abstract class IFeatureFlagService {
  /// Bayrak açık mı?
  bool isEnabled(FeatureFlag flag);

  /// Geliştirici / test override’ı. Yalnızca `assert` içinde etkili; release’de no-op.
  void setOverride(FeatureFlag flag, {required bool value});

  /// Uzak yapılandırmadan gelen değer. [value] null ise uzak girdi silinir.
  void setRemoteValue(FeatureFlag flag, bool? value);
}
