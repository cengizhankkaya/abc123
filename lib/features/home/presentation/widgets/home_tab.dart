import 'package:abc123/core/presentation/mixins/rewarded_ad_helper.dart';
import 'package:abc123/features/home/presentation/widgets/island_map_widget.dart';
import 'package:flutter/material.dart';

/// Ana sayfa sekmesi — ada haritası deneyimi.
///
/// `abc123-v7.html` mockup'ından uyarlanan tam ekran yatay kaydırmalı
/// ada haritasını gösterir. Eski grid düzeni `IslandMapWidget` ile
/// değiştirilmiştir.
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with RewardedAdHelper<HomeTab> {
  @override
  void initState() {
    super.initState();
    loadRewardedAd(context);
  }

  @override
  Widget build(BuildContext context) {
    return const IslandMapWidget();
  }
}
