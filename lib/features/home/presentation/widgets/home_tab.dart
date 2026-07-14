import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/mixins/rewarded_ad_helper.dart';
import 'package:abc123/core/presentation/services/image_service.dart';
import 'package:abc123/core/presentation/widgets/fade_in_slide.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
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
  @override
  void initState() {
    super.initState();
    loadRewardedAd(context);
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeTabView();
  }
}

class _HomeTabView extends StatelessWidget {
  const _HomeTabView();

  /// Alt navigasyon çubuğu için alt boşluk.
  static const double _bottomNavClearance = 100;

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

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
                  // ─── 1. Kaldığın Yerden Devam Et ───────────────────────
                  const FadeInSlide(
                    delay: Duration(milliseconds: 50),
                    child: _GlowingContinueCard(),
                  ),
                  Selector<GamificationProvider, int>(
                    selector: (_, p) => homeContinueSignature(p),
                    builder: (context, _, __) {
                      final provider = context.read<GamificationProvider>();
                      if (!provider.hasLastActivity) return const SizedBox.shrink();
                      return const SizedBox(height: 20);
                    },
                  ),

                  // ─── 2. Öğrenme Modları Başlığı ─────────────────────────
                  FadeInSlide(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      h.homeLearningModes,
                      style: HomeDesignTokens.headingSection(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ─── 3. Responsive Kategori Grid'i ──────────────────────
                  const _LearningModesGrid(),

                  // ─── 4. Reklam Bandı — En Altta ─────────────────────────
                  const SizedBox(height: 24),
                  const FadeInSlide(
                    delay: Duration(milliseconds: 500),
                    child: AdmobBannerWidget(),
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

class _LearningModesGrid extends StatelessWidget {
  const _LearningModesGrid();

  /// Ekran genişliğine göre grid sütun sayısını hesaplar.
  static int _homeGridColumnCount(double width) {
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  Widget _richIcon({
    required IconData icon,
    required IconData? secondaryIcon,
  }) {
    return Stack(
      children: [
        Positioned.fill(
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.12),
            size: 104,
          ),
        ),
        if (secondaryIcon != null)
          Positioned(
            bottom: 12,
            right: 12,
            child: Icon(
              secondaryIcon,
              color: Colors.white.withValues(alpha: 0.18),
              size: 44,
            ),
          ),
        Center(
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.82),
            size: 52,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    final cv = context.colorsL10n;

    return Selector<GamificationProvider, int>(
      selector: (_, p) => homeCategoryProgressSignature(p),
      builder: (context, _, __) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final columns = _homeGridColumnCount(constraints.maxWidth);
            return GridView.count(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.05,
              children: [
                FadeInSlide(
                  delay: const Duration(milliseconds: 150),
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
                  delay: const Duration(milliseconds: 200),
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
                  delay: const Duration(milliseconds: 250),
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
                  delay: const Duration(milliseconds: 300),
                  child: HomeLearningModeCard(
                    title: h.wordsTitleShort,
                    subtitle: h.wordsSubtitle,
                    baseColor: HomeDesignTokens.wordsCard,
                    image: ImageManager.getImage(
                      ImageConstants.wordsImage,
                      fit: BoxFit.cover,
                    ),
                    onTap: () => context.push(AppRoutes.words),
                  ),
                ),
                FadeInSlide(
                  delay: const Duration(milliseconds: 350),
                  child: HomeLearningModeCard(
                    title: h.colorsTitleShort,
                    subtitle: h.colorsSubtitle,
                    baseColor: HomeDesignTokens.colorsCard,
                    image: ImageManager.getImage(
                      ImageConstants.colorsImage,
                      fit: BoxFit.cover,
                    ),
                    onTap: () => context.push(AppRoutes.colorGame),
                  ),
                ),
                FadeInSlide(
                  delay: const Duration(milliseconds: 400),
                  child: HomeLearningModeCard(
                    title: cv.colorVisionHomeTitle,
                    subtitle: cv.colorVisionHomeSubtitle,
                    baseColor: HomeDesignTokens.colorVisionCard,
                    image: _richIcon(
                      icon: Icons.visibility,
                      secondaryIcon: Icons.remove_red_eye,
                    ),
                    onTap: () => context.push(AppRoutes.colorVisionGame),
                  ),
                ),
                FadeInSlide(
                  delay: const Duration(milliseconds: 450),
                  child: HomeLearningModeCard(
                    title: h.mathAdvancedTitle,
                    subtitle: h.mathAdvancedSubtitle,
                    baseColor: HomeDesignTokens.mathCard,
                    image: ImageManager.getImage(
                      ImageConstants.calculateImage,
                      fit: BoxFit.cover,
                    ),
                    onTap: () => context.push(AppRoutes.mathAdvanced),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// HomeContinueCard'ı nabız/glow efektiyle saran widget.
/// Kullanıcının gözü ilk bu karta gitsin diye hafif bir parlaklık animasyonu.
class _GlowingContinueCard extends StatefulWidget {
  const _GlowingContinueCard();

  @override
  State<_GlowingContinueCard> createState() => _GlowingContinueCardState();
}

class _GlowingContinueCardState extends State<_GlowingContinueCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    // ignore: discarded_futures
    _controller.repeat(reverse: true);

    _glow = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kart yoksa animasyonu da çalıştırma — Selector ile kontrol et.
    return Selector<GamificationProvider, int>(
      selector: (_, p) => homeContinueSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        if (!provider.hasLastActivity) return const SizedBox.shrink();

        return AnimatedBuilder(
          animation: _glow,
          builder: (context, child) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HomeDesignTokens.continueCardRadius),
                boxShadow: [
                  BoxShadow(
                    color: HomeDesignTokens.continueIconBlue
                        .withValues(alpha: 0.18 + _glow.value * 0.28),
                    blurRadius: 12 + _glow.value * 16,
                    spreadRadius: _glow.value * 2.0,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: const HomeContinueCard(),
        );
      },
    );
  }
}
