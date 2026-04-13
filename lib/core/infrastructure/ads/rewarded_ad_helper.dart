import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/feature_flags/feature_flag.dart';
import 'package:abc123/core/feature_flags/i_feature_flag_service.dart';
import 'package:abc123/core/presentation/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

mixin RewardedAdHelper<T extends StatefulWidget> on State<T> {
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoaded = false;

  void loadRewardedAd(BuildContext context) {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    RewardedAd.load(
      adUnitId: 'ca-app-pub-1254894147284178/7964725662',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  void showRewardedAd(BuildContext context) async {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    if (_isRewardedAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) async {
          await Provider.of<CounterProvider>(context, listen: false).increment(1);
          final msg = AppLocalizations.of(context)!.adRewardPointEarned;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        },
      );
      _rewardedAd = null;
      _isRewardedAdLoaded = false;
      loadRewardedAd(context);
    } else {
      final msg = AppLocalizations.of(context)!.adLoadFailedRetry;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
      loadRewardedAd(context);
    }
  }
}
