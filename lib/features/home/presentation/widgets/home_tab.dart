import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/utils/image_manager.dart';
import 'package:abc123/core/utils/rewarded_ad_helper.dart';
import 'package:abc123/features/draw/presentation/screens/draw_screen.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/tutorial/tutorial_screen.dart';
import 'package:abc123/features/home/presentation/widgets/game_category_card.dart';
import 'package:abc123/features/home/presentation/widgets/home_badges_widget.dart';
import 'package:abc123/features/home/presentation/widgets/home_header_widget.dart';
import 'package:abc123/features/letters/presentation/screens/letter_draw_screen.dart';
import 'package:abc123/features/shapes/presentation/screens/shapes_draw_screen.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:abc123/shared/widgets/fade_in_slide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../language/language_selector.dart';

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
    final lang = context.watch<LanguageProvider>().language;

    return Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.abc, size: 40, color: const Color(0xFF6C5CE7)),
                      const SizedBox(width: 4),
                      const Text(
                        "123",
                        style: TextStyle(
                          fontFamily:
                              'Roboto', // Using default font but ensuring clean look
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6C5CE7),
                        ),
                      ),
                    ],
                  ),
                  const LanguageSelector(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    16.0, 0, 16.0, 100.0), // Extra padding at bottom for navbar
                child: Column(
                  children: [
                    // DASHBOARD HEADER (Greeting + Stats)
                    const FadeInSlide(
                      delay: Duration(milliseconds: 100),
                      child: HomeHeaderWidget(),
                    ),

                    const SizedBox(height: 16),

                    // BADGES SHELF
                    const SizedBox(height: 16),

                    // BADGES SHELF
                    const FadeInSlide(
                      delay: Duration(milliseconds: 300),
                      child: HomeBadgesWidget(),
                    ),

                    const SizedBox(height: 16),

                    // GAME CATEGORIES
                    Consumer<GamificationProvider>(
                      builder: (context, provider, _) {
                        return Column(
                          children: [
                            FadeInSlide(
                              delay: const Duration(milliseconds: 400),
                              child: GameCategoryCard(
                                title: getLocalizedText('numbersTitle', lang),
                                progressLabel:
                                    "${provider.numberDrawings} / 50",
                                progress: provider.numberDrawings / 50,
                                image: ImageManager.getImage(
                                    ImageConstants.numberImage,
                                    fit: BoxFit.cover),
                                baseColor: const Color(0xFFFF7675), // Soft Red
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const DrawScreen())),
                              ),
                            ),
                            FadeInSlide(
                              delay: const Duration(milliseconds: 400),
                              child: GameCategoryCard(
                                title: getLocalizedText('lettersTitle', lang),
                                progressLabel:
                                    "${provider.letterDrawings} / 50",
                                progress: provider.letterDrawings / 50,
                                image: ImageManager.getImage(
                                    ImageConstants.abcImage,
                                    fit: BoxFit.cover),
                                baseColor: const Color(0xFF74B9FF), // Soft Blue
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const LetterDrawScreen())),
                              ),
                            ),
                            FadeInSlide(
                              delay: const Duration(milliseconds: 500),
                              child: GameCategoryCard(
                                title: getLocalizedText('shapesTitle', lang),
                                progressLabel: "${provider.shapeDrawings} / 50",
                                progress: provider.shapeDrawings / 50,
                                image: ImageManager.getImage(
                                    ImageConstants.shapesImage,
                                    fit: BoxFit.cover),
                                baseColor: const Color(0xFF55EFC4), // Soft Mint
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const ShapesDrawScreen())),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // TUTORIAL LINK
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => YoutubeVideoScreen())),
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
                            const Icon(Icons.play_circle_fill,
                                color: Colors.redAccent, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                getLocalizedText('tutorial', lang),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    // No bottom space here needed as padding is on ScrollView
                  ],
                ),
              ),
            ),
            // Bottom Banner Ad
            const SizedBox(
              height: 60,
              child: AdmobBannerWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
