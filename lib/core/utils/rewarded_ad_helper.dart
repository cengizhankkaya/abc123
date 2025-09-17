import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../shared/counter_provider.dart';

mixin RewardedAdHelper<T extends StatefulWidget> on State<T> {
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoaded = false;

  void loadRewardedAd(BuildContext context) {
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

  void showRewardedAd(BuildContext context) {
    if (_isRewardedAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) async {
          await Provider.of<CounterProvider>(context, listen: false)
              .increment(1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tebrikler! 1 puan kazandınız.')),
          );
        },
      );
      _rewardedAd = null;
      _isRewardedAdLoaded = false;
      loadRewardedAd(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reklam yüklenemedi, lütfen tekrar deneyin.')),
      );
      loadRewardedAd(context);
    }
  }
}
