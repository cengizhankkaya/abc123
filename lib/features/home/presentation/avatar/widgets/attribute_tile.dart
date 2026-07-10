import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Grid içindeki tek bir avatar seçenek kartı.
///
/// Sahiplenilmemiş itemlar için kilit + fiyat rozeti gösterir.
/// Seçili item seçili tile dekorasyonuyla vurgulanır.
class AttributeTile extends StatelessWidget {
  const AttributeTile({
    required this.svgString,
    required this.isSelected,
    required this.isOwned,
    required this.price,
    required this.theme,
    required this.onTap,
    super.key,
  });

  final String svgString;
  final bool isSelected;
  final bool isOwned;
  final int price;
  final FluttermojiThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          // Ana tile — SVG önizleme
          Positioned.fill(
            child: Container(
              decoration:
                  isSelected ? theme.selectedTileDecoration : theme.unselectedTileDecoration,
              margin: theme.tileMargin,
              padding: theme.tilePadding,
              child: Center(
                child: Opacity(
                  opacity: isOwned ? 1.0 : 0.55,
                  child: SvgPicture.string(
                    svgString,
                    height: 38,
                    semanticsLabel: 'Avatar seçeneği',
                    placeholderBuilder: (_) =>
                        const Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ),
            ),
          ),

          // Kilit rozeti — sadece sahip olunmamış itemlar için
          if (!isOwned)
            Positioned(
              top: 3,
              right: 3,
              child: _LockBadge(price: price),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Kilit rozeti
// ---------------------------------------------------------------------------

class _LockBadge extends StatelessWidget {
  const _LockBadge({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: HomeDesignTokens.lettersCard,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, size: 10, color: Colors.white),
          const SizedBox(width: 2),
          const Text('⭐️', style: TextStyle(fontSize: 10)),
          const SizedBox(width: 2),
          Text(
            '$price',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
