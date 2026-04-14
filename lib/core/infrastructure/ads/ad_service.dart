import 'dart:io';

import 'package:abc123/core/config/admob_rewarded_ids.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/feature_flags/feature_flag.dart';
import 'package:abc123/core/feature_flags/i_feature_flag_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();

  factory AdService() {
    return _instance;
  }

  AdService._internal();

  AppLogger get _log => getIt<AppLogger>();

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;

  /// Birim kimlikleri: [AdmobRewardedIds] (`ADMOB_REWARDED_ANDROID` / `ADMOB_REWARDED_IOS`).
  String get _rewardedAdUnitId => AdmobRewardedIds.current;

  void initialize() {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    if (kIsWeb) {
      return;
    }
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }
    MobileAds.instance.initialize();
    loadRewardedAd();
  }

  void loadRewardedAd() {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _log.debug('RewardedAd loaded', tag: 'AdService');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _log.warning(
            'RewardedAd failed to load',
            tag: 'AdService',
            data: {'code': error.code, 'message': error.message},
          );
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
            loadRewardedAd();
          }
        },
      ),
    );
  }

  void showRewardedAd({required void Function(int rewardAmount) onReward}) {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    if (_rewardedAd == null) {
      _log.debug('RewardedAd show skipped (not loaded)', tag: 'AdService');
      loadRewardedAd(); // Try loading again for next time
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          _log.debug('RewardedAd showed full screen', tag: 'AdService'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        _log.debug('RewardedAd dismissed', tag: 'AdService');
        ad.dispose();
        loadRewardedAd(); // Load the next one
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        _log.warning(
          'RewardedAd failed to show',
          tag: 'AdService',
          data: {'code': error.code, 'message': error.message},
        );
        ad.dispose();
        loadRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        _log.info(
          'User earned reward',
          tag: 'AdService',
          data: {'amount': reward.amount, 'type': reward.type},
        );
        onReward(reward.amount.toInt());
      },
    );
    _rewardedAd = null;
  }
}
