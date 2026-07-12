import 'package:abc123/core/domain/types/feature_flag.dart';
import 'package:abc123/core/domain/ports/i_feature_flag_service.dart';
import 'package:injectable/injectable.dart';

/// Öncelik: `_overrides` → `_remoteValues` → [FeatureFlagX.defaultValue].
@LazySingleton(as: IFeatureFlagService)
final class FeatureFlagService implements IFeatureFlagService {
  final Map<FeatureFlag, bool> _overrides = {};
  final Map<FeatureFlag, bool> _remoteValues = {};

  @override
  bool isEnabled(FeatureFlag flag) {
    if (_overrides.containsKey(flag)) {
      return _overrides[flag]!;
    }
    if (_remoteValues.containsKey(flag)) {
      return _remoteValues[flag]!;
    }
    return flag.defaultValue;
  }

  @override
  void setOverride(FeatureFlag flag, {required bool value}) {
    assert(() {
      _overrides[flag] = value;
      return true;
    }());
  }

  @override
  void setRemoteValue(FeatureFlag flag, bool? value) {
    if (value == null) {
      _remoteValues.remove(flag);
    } else {
      _remoteValues[flag] = value;
    }
  }
}
