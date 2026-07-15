import 'dart:async';

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_ad_service.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Kullanıcının yeterli yıldızı olmadığında gösterilen bottom sheet.
///
/// Reklam izleyerek ya da görev yaparak yıldız kazanma seçeneklerini sunar.
class EarnStarsBottomSheet extends StatelessWidget {
  const EarnStarsBottomSheet({
    required this.price,
    required this.attributeKey,
    required this.index,
    required this.controller,
    required this.autosave,
    super.key,
  });

  final int price;
  final String attributeKey;
  final int index;
  final FluttermojiController controller;
  final bool autosave;

  /// Statik yardımcı — tek satırda çağırmak için.
  static Future<void> show(
    BuildContext context, {
    required int price,
    required String attributeKey,
    required int index,
    required FluttermojiController controller,
    required bool autosave,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EarnStarsBottomSheet(
        price: price,
        attributeKey: attributeKey,
        index: index,
        controller: controller,
        autosave: autosave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          16,
          20,
          MediaQuery.of(context).padding.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_border_rounded,
                size: 36,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Yetersiz Yıldız! ⭐️',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HomeDesignTokens.darkText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Bu seçeneği açmak için $price Yıldıza ihtiyacın var '
              '(Mevcut: ${context.watch<GamificationProvider>().points} ⭐️).\n\n'
              'Hemen yıldız kazanmak için bir yöntem seç:',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: HomeDesignTokens.mutedText,
              ),
            ),
            const SizedBox(height: 16),
            _WatchAdButton(
              price: price,
              attributeKey: attributeKey,
              index: index,
              controller: controller,
              autosave: autosave,
            ),
            const SizedBox(height: 10),
            _CompleteTasksButton(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Özel alt widget'lar
// ---------------------------------------------------------------------------

class _WatchAdButton extends StatelessWidget {
  const _WatchAdButton({
    required this.price,
    required this.attributeKey,
    required this.index,
    required this.controller,
    required this.autosave,
  });

  final int price;
  final String attributeKey;
  final int index;
  final FluttermojiController controller;
  final bool autosave;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        getIt<IAdService>().showRewardedAd(
          onReward: (amount) async {
            const earned = 5;
            unawaited(context.read<GamificationProvider>().addPoints(earned));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '🎉 +$earned Yıldız kazandın! '
                  '(Yeni bakiye: ${context.read<GamificationProvider>().points} ⭐️)',
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: HomeDesignTokens.lettersCard,
              ),
            );
            final gam = context.read<GamificationProvider>();
            if (gam.points >= price) {
              final success = await gam.buyAvatarItem(attributeKey, index);
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '✨ Harika! Yeterli yıldıza ulaşıldı ve seçenek otomatik satın alındı!',
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                  ),
                );
                controller.selectedOptions[attributeKey] = index;
                controller.updatePreview();
                if (autosave) unawaited(controller.setFluttermoji());
              }
            }
          },
          onAdNotReady: () {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⏳ Reklam yükleniyor; birkaç saniye sonra tekrar deneyin.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: HomeDesignTokens.lettersCard.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: HomeDesignTokens.lettersCard, width: 2),
        ),
        child: const Row(
          children: [
            Icon(Icons.ondemand_video_rounded, color: HomeDesignTokens.lettersCard, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reklam İzleyerek Kazan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: HomeDesignTokens.darkText,
                    ),
                  ),
                  Text(
                    'Kısa bir video izle, anında +5 ⭐️ kazan',
                    style: TextStyle(fontSize: 12, color: HomeDesignTokens.mutedText),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: HomeDesignTokens.lettersCard),
          ],
        ),
      ),
    );
  }
}

class _CompleteTasksButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '🚀 Ana sayfadaki çizim ve oyun etkinliklerini tamamlayarak bolca Yıldız ⭐️ kazanabilirsin!',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: HomeDesignTokens.headerBlue,
          ),
        );
        if (Navigator.canPop(context)) Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: HomeDesignTokens.continueIconBlue.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: HomeDesignTokens.continueIconBlue, width: 2),
        ),
        child: const Row(
          children: [
            Icon(Icons.rocket_launch_rounded, color: HomeDesignTokens.continueIconBlue, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Görevleri Tamamla & Oyun Oyna',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: HomeDesignTokens.darkText,
                    ),
                  ),
                  Text(
                    'Ana sayfada çizim ve görev yaparak yıldız topla',
                    style: TextStyle(fontSize: 12, color: HomeDesignTokens.mutedText),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: HomeDesignTokens.continueIconBlue),
          ],
        ),
      ),
    );
  }
}
