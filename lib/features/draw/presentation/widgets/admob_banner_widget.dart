import 'dart:async';

import 'package:abc123/core/config/admob_banner_ids.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/ads/mobile_ads_gate.dart';
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

  /// Dikey banner + "Reklam" etiketi için sabit yükseklik.
  static const double verticalSlotHeight = 74;

  @override
  State<AdmobBannerWidget> createState() => _AdmobBannerWidgetState();
}

class _AdmobBannerWidgetState extends State<AdmobBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      MobileAdsGate.whenReady.then((_) {
        if (!mounted) {
          return Future<void>.value();
        }
        final ad = BannerAd(
          adUnitId: AdmobBannerIds.current,
          size: AdSize.banner,
          request: const AdRequest(),
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
              unawaited(ad.dispose());
              if (mounted) {
                setState(() {
                  _bannerAd = null;
                });
              }
            },
          ),
        );
        _bannerAd = ad;
        return ad.load();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTitleSide) {
      return _buildSideLayout();
    }

    // AdWidget bir native platform view olduğundan FittedBox/ClipRect gibi
    // dönüşümler iOS'ta reklamın yanlış konumda çizilmesine yol açabiliyor;
    // bu yüzden sabit boyutlu, dönüşümsüz bir slot kullanılır.
    return SizedBox(
      height: AdmobBannerWidget.verticalSlotHeight,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: _bannerAd != null && _isLoaded
            ? _buildVerticalContent()
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildVerticalContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitle) ...[
          _adLabel,
          const SizedBox(height: 4),
        ],
        _adContent,
      ],
    );
  }

  Widget _buildSideLayout() {
    if (_bannerAd == null || !_isLoaded) {
      return const SizedBox(width: 320, height: 50);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitle) ...[
          RotatedBox(quarterTurns: 3, child: _adLabel),
          const SizedBox(width: 4),
        ],
        _adContent,
      ],
    );
  }

  Widget get _adLabel => Container(
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

  Widget get _adContent => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );

  @override
  void dispose() {
    final ad = _bannerAd;
    if (ad != null) {
      unawaited(ad.dispose());
    }
    super.dispose();
  }
}
