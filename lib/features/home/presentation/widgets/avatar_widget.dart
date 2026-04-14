import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/presentation/gamification_icon_catalog.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

/// Mağaza önizlemesi için basit avatar; ikonlar hafif gölge ile okunur (açık renkler).
class AvatarWidget extends StatefulWidget {
  final double size;
  final bool showBackground;

  const AvatarWidget({
    super.key,
    this.size = 180,
    this.showBackground = true,
  });

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;
  int? _lastEquippedHash;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.09).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 42,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.09, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 58,
      ),
    ]).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  int _hashEquipped(Map<String, String> equipped) {
    return Object.hash(
      equipped[ShopItemType.hat.toString()],
      equipped[ShopItemType.glasses.toString()],
      equipped[ShopItemType.outfit.toString()],
    );
  }

  void _scheduleEquipPulseIfNeeded(int nextHash) {
    if (_lastEquippedHash == null) {
      _lastEquippedHash = nextHash;
      return;
    }
    if (_lastEquippedHash == nextHash) return;
    _lastEquippedHash = nextHash;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _pulseController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final equipped = provider.equippedItems;
    _scheduleEquipPulseIfNeeded(_hashEquipped(equipped));

    final allItems = provider.shopItems;

    ShopItemModel? getItem(ShopItemType type) {
      final id = equipped[type.toString()];
      if (id == null) return null;
      try {
        return allItems.firstWhere((item) => item.id == id);
      } catch (_) {
        return null;
      }
    }

    final hat = getItem(ShopItemType.hat);
    final glasses = getItem(ShopItemType.glasses);
    final outfit = getItem(ShopItemType.outfit);

    final s = widget.size;

    return AnimatedBuilder(
      animation: _pulseScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseScale.value,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: Container(
        width: s,
        height: s,
        decoration: widget.showBackground
            ? BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              )
            : null,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Body
            Positioned(
              bottom: s * 0.1,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: s * 0.5,
                    height: s * 0.4,
                    decoration: BoxDecoration(
                      color: gamificationColor(outfit?.colorArgb) ?? const Color(0xFFE4BC9D),
                      borderRadius: BorderRadius.circular(s * 0.2),
                    ),
                  ),
                  if (outfit?.iconKey != null)
                    Icon(
                      gamificationIcon(outfit!.iconKey),
                      size: s * 0.25,
                      color: _outfitIconColor(gamificationColor(outfit.colorArgb)),
                      shadows: _shadowsForContrastOnOutfit(gamificationColor(outfit.colorArgb)),
                    ),
                ],
              ),
            ),

            // Head
            Positioned(
              top: s * 0.15,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: s * 0.45,
                    height: s * 0.5,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFCCAA),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Positioned(
                    top: s * 0.2,
                    left: s * 0.1,
                    child: _buildEye(s),
                  ),
                  Positioned(
                    top: s * 0.2,
                    right: s * 0.1,
                    child: _buildEye(s),
                  ),

                  Positioned(
                    bottom: s * 0.12,
                    child: Container(
                      width: s * 0.1,
                      height: s * 0.05,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.brown, width: s * 0.015),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  // Gözlük: tek merkezi "çıkartma" — taşma ve çift ikon kayması yok
                  if (glasses != null)
                    Positioned(
                      top: s * 0.165,
                      child: _GlassesSticker(
                        size: s,
                        icon: gamificationIcon(glasses.iconKey),
                        tint: _glassesIconColor(gamificationColor(glasses.colorArgb)),
                        shadows: _shadowsForContrast(gamificationColor(glasses.colorArgb)),
                      ),
                    ),

                  // Şapka: kafa tepesinde, taç yukarı taşabilir
                  if (hat != null)
                    Positioned(
                      top: -s * 0.06,
                      child: Icon(
                        gamificationIcon(hat.iconKey),
                        size: s * 0.26,
                        color: _hatIconColor(gamificationColor(hat.colorArgb)),
                        shadows: _shadowsForContrast(gamificationColor(hat.colorArgb)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEye(double parentSize) {
    return Container(
      width: parentSize * 0.08,
      height: parentSize * 0.08,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: parentSize * 0.025,
              height: parentSize * 0.025,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassesSticker extends StatelessWidget {
  const _GlassesSticker({
    required this.size,
    required this.icon,
    required this.tint,
    required this.shadows,
  });

  final double size;
  final IconData icon;
  final Color tint;
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.42),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.035),
        child: Icon(
          icon,
          size: size * 0.19,
          color: tint,
          shadows: shadows,
        ),
      ),
    );
  }
}

Color _hatIconColor(Color? c) => c ?? const Color(0xFF5E35B1);

Color _glassesIconColor(Color? c) => (c ?? Colors.black87).withOpacity(0.92);

Color _outfitIconColor(Color? outfitColor) {
  final c = outfitColor ?? const Color(0xFFE4BC9D);
  final lum = c.computeLuminance();
  if (lum > 0.82) {
    return Colors.deepPurple.shade300;
  }
  return Colors.white.withOpacity(0.88);
}

List<Shadow> _shadowsForContrast(Color? c) {
  final color = c ?? Colors.black54;
  final lum = color.computeLuminance();
  if (lum > 0.78) {
    return const [
      Shadow(offset: Offset(0, 1), blurRadius: 2, color: Color(0x8A000000)),
      Shadow(offset: Offset(0, 0), blurRadius: 5, color: Color(0x40000000)),
    ];
  }
  if (lum < 0.12) {
    return const [
      Shadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x55FFFFFF)),
    ];
  }
  return const [
    Shadow(offset: Offset(0, 1), blurRadius: 1.5, color: Color(0x48000000)),
  ];
}

List<Shadow> _shadowsForContrastOnOutfit(Color? outfitColor) {
  final lum = (outfitColor ?? const Color(0xFFE4BC9D)).computeLuminance();
  if (lum > 0.75) {
    return const [
      Shadow(offset: Offset(0, 1), blurRadius: 2, color: Color(0x75000000)),
    ];
  }
  return const [
    Shadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x33000000)),
  ];
}
