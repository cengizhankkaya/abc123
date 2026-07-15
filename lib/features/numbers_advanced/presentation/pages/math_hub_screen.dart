import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/presentation/widgets/game_category_card.dart';
import 'package:abc123/features/numbers_advanced/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc123/core/theme/theme_helper.dart';

class MathHubScreen extends StatelessWidget {
  const MathHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: context.mathColors.purple),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.mathColors.purple.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.mathHubTitle,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.mathHubSubtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                GameCategoryCard(
                  title: l10n.mathHubTensTitle,
                  progressLabel: l10n.mathHubTensSubtitle,
                  progress: 0,
                  image: const FittedBox(
                    child: Icon(Icons.apps, color: Colors.white, size: 56),
                  ),
                  baseColor: context.mathColors.teal, // Teal
                  onTap: () => context.push(AppRoutes.mathTens),
                ),
                const SizedBox(height: 16),
                GameCategoryCard(
                  title: l10n.mathHubFreeTitle,
                  progressLabel: l10n.mathHubFreeSubtitle,
                  progress: 0,
                  image: const FittedBox(
                    child: Icon(Icons.edit, color: Colors.white, size: 56),
                  ),
                  baseColor: context.mathColors.orange, // Orange
                  onTap: () => context.push(AppRoutes.mathFree),
                ),
                const SizedBox(height: 16),
                GameCategoryCard(
                  title: l10n.mathHubVisualTitle,
                  progressLabel: l10n.mathHubVisualSubtitle,
                  progress: 0,
                  image: const FittedBox(
                    child: Icon(Icons.visibility, color: Colors.white, size: 56),
                  ),
                  baseColor: context.mathColors.yellow, // Yellow
                  onTap: () => context.push(AppRoutes.mathVisual),
                ),
                const SizedBox(height: 16),
                GameCategoryCard(
                  title: l10n.mathHubSymbolicTitle,
                  progressLabel: l10n.mathHubSymbolicSubtitle,
                  progress: 0,
                  image: const FittedBox(
                    child: Icon(Icons.calculate, color: Colors.white, size: 56),
                  ),
                  baseColor: context.mathColors.deepPurple, // Purple
                  onTap: () => context.push(AppRoutes.mathSymbolic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
