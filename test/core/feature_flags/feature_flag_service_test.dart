@TestOn('vm')
library;

import 'package:abc123/core/feature_flags/feature_flag.dart';
import 'package:abc123/core/feature_flags/feature_flag_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeatureFlagService', () {
    test('varsayılan: rewardedAdsEnabled true', () {
      final svc = FeatureFlagService();
      expect(svc.isEnabled(FeatureFlag.rewardedAdsEnabled), isTrue);
    });

    test('uzak değer varsayılanın üstüne yazar', () {
      final svc = FeatureFlagService();
      svc.setRemoteValue(FeatureFlag.rewardedAdsEnabled, false);
      expect(svc.isEnabled(FeatureFlag.rewardedAdsEnabled), isFalse);
    });

    test('override uzak değerin üstündedir', () {
      final svc = FeatureFlagService();
      svc.setRemoteValue(FeatureFlag.rewardedAdsEnabled, false);
      svc.setOverride(FeatureFlag.rewardedAdsEnabled, value: true);
      expect(svc.isEnabled(FeatureFlag.rewardedAdsEnabled), isTrue);
    });

    test('remoteConfigKey tutarlı', () {
      expect(
        FeatureFlag.rewardedAdsEnabled.remoteConfigKey,
        'feature_rewardedAdsEnabled',
      );
    });

    test('setRemoteValue null uzak değeri kaldırır', () {
      final svc = FeatureFlagService();
      svc.setRemoteValue(FeatureFlag.rewardedAdsEnabled, false);
      svc.setRemoteValue(FeatureFlag.rewardedAdsEnabled, null);
      expect(svc.isEnabled(FeatureFlag.rewardedAdsEnabled), isTrue);
    });
  });
}
