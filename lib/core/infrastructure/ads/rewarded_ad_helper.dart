import 'dart:async';

import 'package:abc123/app/config/admob_rewarded_ids.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_feature_flag_service.dart';
import 'package:abc123/core/domain/types/feature_flag.dart';
import 'package:abc123/core/infrastructure/ads/mobile_ads_gate.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
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
    unawaited(
      MobileAdsGate.whenReady.then((_) {
        if (!mounted) {
          return Future<void>.value();
        }
        return RewardedAd.load(
          adUnitId: AdmobRewardedIds.current,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              if (!mounted) {
                return;
              }
              setState(() {
                _rewardedAd = ad;
                _isRewardedAdLoaded = true;
              });
            },
            onAdFailedToLoad: (error) {
              if (!mounted) {
                return;
              }
              setState(() {
                _isRewardedAdLoaded = false;
              });
            },
          ),
        );
      }),
    );
  }

  void showRewardedAd(BuildContext context) {
    if (!getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      return;
    }
    if (_isRewardedAdLoaded && _rewardedAd != null) {
      unawaited(
        _rewardedAd!.show(
          onUserEarnedReward: (ad, reward) {
            if (!context.mounted) {
              return;
            }
            unawaited(
              Provider.of<CounterProvider>(context, listen: false).increment().then((_) {
                if (!context.mounted) {
                  return;
                }
                final msg = AppLocalizations.of(context)!.adRewardPointEarned;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                );
              }),
            );
          },
        ),
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
