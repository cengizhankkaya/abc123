import 'dart:async';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/types/feature_flag.dart';
import 'package:abc123/core/domain/ports/i_feature_flag_service.dart';
import 'package:abc123/core/domain/ports/i_ad_service.dart';
import 'package:abc123/core/infrastructure/ads/ad_service.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/presentation/widgets/fade_in_slide.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_customizer.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_save_widget.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
import 'package:abc123/features/home/presentation/widgets/shop_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarShopScreen extends StatefulWidget {
  const AvatarShopScreen({super.key});

  @override
  State<AvatarShopScreen> createState() => _AvatarShopScreenState();
}

class _AvatarShopScreenState extends State<AvatarShopScreen> {
  @override
  void initState() {
    super.initState();
    if (getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled)) {
      getIt<IAdService>().initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rewardedAdsEnabled =
        getIt<IFeatureFlagService>().isEnabled(FeatureFlag.rewardedAdsEnabled);

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: Column(
        children: [
          const ShopHeaderWidget(),
          const SizedBox(height: 8),
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            child: _AvatarDashboardCard(
              rewardedAdsEnabled: rewardedAdsEnabled,
              onWatchAd: () => _watchAdForPoints(context),
              onSave: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Avatarınız başarıyla kaydedildi!"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: HomeDesignTokens.lettersCard,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FadeInSlide(
              delay: const Duration(milliseconds: 150),
              child: LayoutBuilder(
                builder: (context, constraints) => FluttermojiCustomizer(
                  scaffoldHeight: constraints.maxHeight,
                  scaffoldWidth: constraints.maxWidth,
                  autosave: true,
                  theme: FluttermojiThemeData(
                    boxDecoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    primaryBgColor: Colors.white,
                    secondaryBgColor: const Color(0xFFF8F9FB),
                    selectedTileDecoration: BoxDecoration(
                      color: HomeDesignTokens.colorsCard.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: HomeDesignTokens.colorsCard, width: 2),
                    ),
                    unselectedTileDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _watchAdForPoints(BuildContext context) {
    AdService().showRewardedAd(
      onReward: (amount) {
        const earned = 5;
        unawaited(context.read<GamificationProvider>().addPoints(earned));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "🎉 +$earned Yıldız kazandın! (Toplam: ${context.read<GamificationProvider>().points} ⭐️)"),
            backgroundColor: HomeDesignTokens.lettersCard,
          ),
        );
      },
      onAdNotReady: () {
        final msg = AppLocalizations.of(context)?.adLoadFailedRetry ??
            'Reklam yükleniyor; birkaç saniye sonra tekrar deneyin.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      },
    );
  }
}

class _AvatarDashboardCard extends StatelessWidget {
  const _AvatarDashboardCard({
    required this.rewardedAdsEnabled,
    required this.onWatchAd,
    required this.onSave,
  });

  final bool rewardedAdsEnabled;
  final VoidCallback onWatchAd;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: HomeDesignTokens.colorsCard.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              color: HomeDesignTokens.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: AvatarWidget(size: 98, showBackground: false),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Avatarını Tasarla",
                  style: HomeDesignTokens.cardTitle(color: HomeDesignTokens.darkText).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Seçtiğin parça anında uygulanır.",
                  style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText).copyWith(
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (rewardedAdsEnabled) ...[
                      Expanded(
                        child: Material(
                          color: HomeDesignTokens.shapesCard,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: onWatchAd,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.play_circle_fill_rounded,
                                      color: HomeDesignTokens.darkText, size: 16),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      h.freePointsBtn,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: HomeDesignTokens.cardTitle(
                                              color: HomeDesignTokens.darkText)
                                          .copyWith(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    FluttermojiSaveWidget(
                      onTap: onSave,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: HomeDesignTokens.colorsCard,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: HomeDesignTokens.colorsCard.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.save_rounded, color: HomeDesignTokens.darkText, size: 16),
                            SizedBox(width: 5),
                            Text(
                              "Kaydet",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: HomeDesignTokens.darkText,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
