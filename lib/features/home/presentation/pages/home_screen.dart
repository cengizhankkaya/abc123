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
import 'package:abc123/features/home/presentation/widgets/game_category_card.dart';
import 'package:abc123/features/home/presentation/widgets/home_badges_widget.dart';
import 'package:abc123/features/home/presentation/widgets/home_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:abc123/features/home/presentation/widgets/language_selector.dart';
import 'package:abc123/features/home/presentation/widgets/theme_mode_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RewardedAdHelper<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadRewardedAd(context);
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER (Top Bar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.abc, size: 40, color: const Color(0xFF6C5CE7)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        ThemeModeSelector(),
                        SizedBox(width: 4),
                        LanguageSelector(),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // DASHBOARD HEADER (Greeting + Stats)
                      const FadeInSlide(
                        delay: Duration(milliseconds: 100),
                        child: HomeHeaderWidget(),
                      ),

                      const SizedBox(height: 16),

                      // BADGES SHELF
                      const FadeInSlide(
                        delay: Duration(milliseconds: 200),
                        child: HomeBadgesWidget(),
                      ),

                      const SizedBox(height: 16),

                      // GAME CATEGORIES
                      Selector<GamificationProvider, int>(
                        selector: (_, p) => homeCategoryProgressSignature(p),
                        builder: (context, _, __) {
                          final provider = context.read<GamificationProvider>();
                          final cv = context.colorsL10n;
                          return Column(
                            children: [
                              FadeInSlide(
                                delay: const Duration(milliseconds: 300),
                                child: GameCategoryCard(
                                  title: h.numbersTitle,
                                  progressLabel: "${provider.numberDrawings} / 50",
                                  progress: provider.numberDrawings / 50,
                                  image: ImageManager.getImage(ImageConstants.numberImage,
                                      fit: BoxFit.cover),
                                  baseColor: const Color(0xFFFF7675), // Soft Red
                                  onTap: () => context.push(AppRoutes.draw),
                                ),
                              ),
                              FadeInSlide(
                                delay: const Duration(milliseconds: 400),
                                child: GameCategoryCard(
                                  title: h.lettersTitle,
                                  progressLabel: "${provider.letterDrawings} / 50",
                                  progress: provider.letterDrawings / 50,
                                  image: ImageManager.getImage(ImageConstants.abcImage,
                                      fit: BoxFit.cover),
                                  baseColor: const Color(0xFF74B9FF), // Soft Blue
                                  onTap: () => context.push(AppRoutes.letters),
                                ),
                              ),
                              FadeInSlide(
                                delay: const Duration(milliseconds: 500),
                                child: GameCategoryCard(
                                  title: h.shapesTitle,
                                  progressLabel: "${provider.shapeDrawings} / 50",
                                  progress: provider.shapeDrawings / 50,
                                  image: ImageManager.getImage(ImageConstants.shapesImage,
                                      fit: BoxFit.cover),
                                  baseColor: const Color(0xFF55EFC4), // Soft Mint
                                  onTap: () => context.push(AppRoutes.shapes),
                                ),
                              ),
                              FadeInSlide(
                                delay: const Duration(milliseconds: 550),
                                child: GameCategoryCard(
                                  title: h.colorsTitle,
                                  progressLabel: "${provider.colorRounds} / 50",
                                  progress: provider.colorRounds / 50,
                                  image: const FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(Icons.palette, color: Colors.white, size: 56),
                                  ),
                                  baseColor: const Color(0xFFFFB74D),
                                  onTap: () => context.push(AppRoutes.colorGame),
                                ),
                              ),
                              FadeInSlide(
                                delay: const Duration(milliseconds: 600),
                                child: GameCategoryCard(
                                  title: cv.colorVisionHomeTitle,
                                  progressLabel: cv.colorVisionHomeSubtitle,
                                  progress: 0,
                                  image: const FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(Icons.visibility, color: Colors.white, size: 56),
                                  ),
                                  baseColor: const Color(0xFF9B59B6),
                                  onTap: () => context.push(AppRoutes.colorVisionGame),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // TUTORIAL LINK
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.tutorial),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.play_circle_fill, color: Colors.redAccent, size: 32),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  h.tutorial,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Banner Ad in ScrollView
                      const AdmobBannerWidget(),
                      const SizedBox(height: 80), // Extra padding for safe scrolling
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
