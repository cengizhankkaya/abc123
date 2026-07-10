import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';

/// Bir avatar öğesi satın almak istediğinde gösterilen onay bottom sheet'i.
///
/// `true` döndürür → kullanıcı satın almayı onayladı.
/// `false` / `null` döndürür → iptal etti.
class BuyItemBottomSheet extends StatelessWidget {
  const BuyItemBottomSheet({
    required this.price,
    required this.attributeTitle,
    required this.gamification,
    super.key,
  });

  final int price;
  final String attributeTitle;
  final GamificationProvider gamification;

  /// Statik yardımcı — bottom sheet'i gösterir ve sonucu döndürür.
  static Future<bool?> show(
    BuildContext context, {
    required int price,
    required String attributeTitle,
    required GamificationProvider gamification,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BuyItemBottomSheet(
        price: price,
        attributeTitle: attributeTitle,
        gamification: gamification,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          24,
          16,
          24,
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
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HomeDesignTokens.lettersCard.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Text('⭐️', style: TextStyle(fontSize: 34)),
            ),
            const SizedBox(height: 12),
            Text(
              attributeTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HomeDesignTokens.darkText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Bu harika seçeneği kalıcı olarak açmak için $price Yıldız ⭐️ kullanılsın mı?\n'
              '(Mevcut Yıldızın: ${gamification.points} ⭐️)',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: HomeDesignTokens.mutedText,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Vazgeç',
                      style: TextStyle(
                        color: HomeDesignTokens.mutedText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HomeDesignTokens.lettersCard,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      '$price ⭐️ Satın Al',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
