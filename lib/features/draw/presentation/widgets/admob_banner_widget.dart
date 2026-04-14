import 'package:abc123/core/config/admob_banner_ids.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBannerWidget extends StatefulWidget {
  final bool showTitle;
  final bool isTitleSide;

  const AdmobBannerWidget({
    super.key,
    this.showTitle = true,
    this.isTitleSide = false,
  });

  @override
  State<AdmobBannerWidget> createState() => _AdmobBannerWidgetState();
}

class _AdmobBannerWidgetState extends State<AdmobBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdmobBannerIds.current,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          getIt<AppLogger>().warning(
            'Banner ad failed to load',
            tag: 'AdMobBanner',
            data: {'code': error.code, 'message': error.message},
          );
          ad.dispose();
          if (mounted) {
            setState(() {
              _bannerAd = null;
            });
          }
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null || !_isLoaded) {
      return const SizedBox(height: 50);
    }

    Widget adLabel = Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'Reklam',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );

    Widget adContent = Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade300), color: Colors.white),
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );

    if (widget.isTitleSide) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showTitle) ...[
            RotatedBox(quarterTurns: 3, child: adLabel),
            const SizedBox(width: 4),
          ],
          adContent,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitle) ...[
          adLabel,
          const SizedBox(height: 4),
        ],
        adContent,
      ],
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
