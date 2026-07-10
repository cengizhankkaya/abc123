import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/infrastructure/ads/rewarded_ad_helper.dart';
import 'package:abc123/core/infrastructure/images/image_manager.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/core/presentation/widgets/fade_in_slide.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/home_continue_card.dart';
import 'package:abc123/features/home/presentation/widgets/home_header_widget.dart';
import 'package:abc123/features/home/presentation/widgets/home_learning_mode_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with RewardedAdHelper<HomeTab> {
  /// [CustomBottomNavigationBar] alt navigasyon çubuğu için alt boşluk.
  static const double _bottomNavClearance = 100;

  @override
  void initState() {
    super.initState();
    loadRewardedAd(context);
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    final cv = context.colorsL10n;

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: Column(
        children: [
          const HomeHeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, _bottomNavClearance),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h.homeLearningModes,
                    style: HomeDesignTokens.headingSection(),
                  ),
                  const SizedBox(height: 16),
                  Selector<GamificationProvider, int>(
                    selector: (_, p) => homeCategoryProgressSignature(p),
                    builder: (context, _, __) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.05,
                        children: [
                          FadeInSlide(
                            delay: const Duration(milliseconds: 100),
                            child: HomeLearningModeCard(
                              title: h.numbersTitleShort,
                              subtitle: h.numbersSubtitle,
                              baseColor: HomeDesignTokens.numbersCard,
                              image: ImageManager.getImage(
                                ImageConstants.numberImage,
                                fit: BoxFit.cover,
                              ),
                              onTap: () => context.push(AppRoutes.draw),
                            ),
                          ),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 150),
                            child: HomeLearningModeCard(
                              title: h.lettersTitleShort,
                              subtitle: h.lettersSubtitle,
                              baseColor: HomeDesignTokens.lettersCard,
                              image: ImageManager.getImage(
                                ImageConstants.abcImage,
                                fit: BoxFit.cover,
                              ),
                              onTap: () => context.push(AppRoutes.letters),
                            ),
                          ),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 200),
                            child: HomeLearningModeCard(
                              title: h.shapesTitleShort,
                              subtitle: h.shapesSubtitle,
                              baseColor: HomeDesignTokens.shapesCard,
                              image: ImageManager.getImage(
                                ImageConstants.shapesImage,
                                fit: BoxFit.cover,
                              ),
                              useDarkText: true,
                              onTap: () => context.push(AppRoutes.shapes),
                            ),
                          ),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 250),
                            child: HomeLearningModeCard(
                              title: h.wordsTitleShort,
                              subtitle: h.wordsSubtitle,
                              baseColor: HomeDesignTokens.wordsCard,
                              image: Center(
                                child: Icon(
                                  Icons.spellcheck,
                                  color: Colors.white.withValues(alpha: 0.38),
                                  size: 88,
                                ),
                              ),
                              onTap: () => context.push(AppRoutes.words),
                            ),
                          ),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 300),
                            child: HomeLearningModeCard(
                              title: h.colorsTitleShort,
                              subtitle: h.colorsSubtitle,
                              baseColor: HomeDesignTokens.colorsCard,
                              image: Center(
                                child: Icon(
                                  Icons.palette,
                                  color: Colors.white.withValues(alpha: 0.38),
                                  size: 88,
                                ),
                              ),
                              onTap: () => context.push(AppRoutes.colorGame),
                            ),
                          ),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 350),
                            child: HomeLearningModeCard(
                              title: cv.colorVisionHomeTitle,
                              subtitle: cv.colorVisionHomeSubtitle,
                              baseColor: HomeDesignTokens.colorVisionCard,
                              image: Center(
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.white.withValues(alpha: 0.38),
                                  size: 88,
                                ),
                              ),
                              onTap: () => context.push(AppRoutes.colorVisionGame),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const FadeInSlide(
                    delay: Duration(milliseconds: 380),
                    child: AdmobBannerWidget(),
                  ),
                  const SizedBox(height: 20),
                  const FadeInSlide(
                    delay: Duration(milliseconds: 400),
                    child: HomeContinueCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
