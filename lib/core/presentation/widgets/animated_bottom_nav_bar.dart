import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Renk Paleti ────────────────────────────────────────────────────────────

abstract final class _NavColors {
  static const Color orange = Color(0xFFFFA726);
  static const Color purple = Color(0xFFAB47BC);
  static const Color yellow = Color(0xFFFFEE58);
  static const Color teal = Color(0xFF26C6DA);
  static const Color pink = Color(0xFFEC407A);
  static const Color inactive = Color(0xFFBDBDBD);

  /// Her sekmeye ait canlı renk (5 sekme varsayılan düzen)
  static const List<Color> tabColors = [
    orange,
    purple,
    teal,
    yellow,
    pink,
  ];
}

// ─── Model ──────────────────────────────────────────────────────────────────

/// Tek bir navigasyon sekmesini temsil eden model.
class NavItem {
  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

// ─── Sparkle Particle ────────────────────────────────────────────────────────

class _SparkleParticle {
  _SparkleParticle({
    required this.color,
    required this.angle,
    required this.size,
  });

  final Color color;
  final double angle;
  final double size;

  /// 0.0 → 1.0 (yaşam süresi ilerlemesi)
  double progress = 0;
}

// ─── Sparkle Painter ─────────────────────────────────────────────────────────

class _SparklePainter extends CustomPainter {
  _SparklePainter({required this.particles});

  final List<_SparkleParticle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final p in particles) {
      if (p.progress <= 0 || p.progress >= 1) continue;

      // Son %30'da solar
      final opacity = p.progress < 0.7
          ? 1.0
          : 1.0 - ((p.progress - 0.7) / 0.3);

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      final dist = p.progress * 28.0;
      final dx = math.cos(p.angle) * dist;
      final dy = math.sin(p.angle) * dist;
      final particleSize = p.size * (1 - p.progress * 0.5);

      canvas
        ..save()
        ..translate(center.dx + dx, center.dy + dy)
        ..rotate(p.progress * math.pi);

      final path = Path()
        ..moveTo(0, -particleSize)
        ..lineTo(particleSize * 0.35, -particleSize * 0.35)
        ..lineTo(particleSize, 0)
        ..lineTo(particleSize * 0.35, particleSize * 0.35)
        ..lineTo(0, particleSize)
        ..lineTo(-particleSize * 0.35, particleSize * 0.35)
        ..lineTo(-particleSize, 0)
        ..lineTo(-particleSize * 0.35, -particleSize * 0.35)
        ..close();

      canvas
        ..drawPath(path, paint)
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_SparklePainter old) => true;
}

// ─── Ana Widget ──────────────────────────────────────────────────────────────

/// Çocuk dostu animasyonlu floating bottom navigation bar.
///
/// Özellikler:
/// * Floating pill (kapsül) tasarım — kenarlardan 16 px boşluk, radius 35
/// * Glassmorphism görünümlü pastel gradient arka plan
/// * Mor/pembe tonlu renkli gölge
/// * Sekmeler arası akışkan blob kayma (squash & stretch) animasyonu
/// * Dokunuşta bounce/spring ikon animasyonu
/// * Sparkle/confetti yıldız parçacık efekti (~600 ms)
/// * HapticFeedback.lightImpact entegrasyonu
///
/// Örnek kullanım:
/// ```dart
/// AnimatedBottomNavBar(
///   currentIndex: _index,
///   onTap: (i) => setState(() => _index = i),
///   items: const [
///     NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Ana Sayfa'),
///     ...
///   ],
/// )
/// ```
class AnimatedBottomNavBar extends StatefulWidget {
  const AnimatedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  @override
  State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with TickerProviderStateMixin {
  // ── Blob kayma animasyonu ────────────────────────────────────────────────
  late AnimationController _blobController;
  late Animation<double> _blobPosition;
  late Animation<double> _blobScaleX;
  late Animation<double> _blobScaleY;
  double _fromPosition = 0;
  double _toPosition = 0;

  // ── İkon bounce animasyonları (her sekme için bir adet) ──────────────────
  late List<AnimationController> _bounceControllers;
  late List<Animation<double>> _bounceScales;

  // ── Sparkle parçacık sistemi ─────────────────────────────────────────────
  late AnimationController _sparkleController;
  final List<_SparkleParticle> _particles = [];
  int _sparkleTabIndex = -1;
  final math.Random _rng = math.Random();

  @override
  void initState() {
    super.initState();

    final tabCount = widget.items.length;
    _toPosition = widget.currentIndex.toDouble();
    _fromPosition = _toPosition;

    // Blob controller
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _rebuildBlobAnimations();

    // Bounce controllers (her sekme için)
    _bounceControllers = List.generate(tabCount, (_) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _bounceScales = _bounceControllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.72), weight: 20),
        TweenSequenceItem(tween: Tween(begin: 0.72, end: 1.22), weight: 35),
        TweenSequenceItem(tween: Tween(begin: 1.22, end: 0.92), weight: 20),
        TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.0), weight: 25),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));
    }).toList();

    // Sparkle controller
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )
      ..addListener(_onSparkleUpdate)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          setState(() => _particles.clear());
        }
      });
  }

  void _rebuildBlobAnimations() {
    _blobPosition = Tween<double>(
      begin: _fromPosition,
      end: _toPosition,
    ).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeInOutCubic),
    );

    _blobScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 60),
    ]).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeInOut),
    );

    _blobScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.72), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.72, end: 1.0), weight: 60),
    ]).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeInOut),
    );
  }

  void _onSparkleUpdate() {
    if (!mounted) return;
    final progress = _sparkleController.value;
    for (final p in _particles) {
      p.progress = progress;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(AnimatedBottomNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _animateTo(widget.currentIndex);
    }
  }

  void _animateTo(int index) {
    _fromPosition = _blobPosition.value; // anlık konumdan devam et
    _toPosition = index.toDouble();
    _rebuildBlobAnimations();

    _blobController
      ..reset()
      ..forward();

    _bounceControllers[index]
      ..reset()
      ..forward();

    _triggerSparkle(index);
    HapticFeedback.lightImpact();
  }

  void _triggerSparkle(int index) {
    _sparkleTabIndex = index;
    final activeColor =
        _NavColors.tabColors[index % _NavColors.tabColors.length];
    _particles
      ..clear()
      ..addAll(
        List.generate(12, (_) {
          final palette = [
            activeColor,
            _NavColors.yellow,
            _NavColors.orange,
            Colors.white,
          ];
          return _SparkleParticle(
            color: palette[_rng.nextInt(palette.length)],
            angle: _rng.nextDouble() * 2 * math.pi,
            size: 3.0 + _rng.nextDouble() * 4.0,
          );
        }),
      );
    _sparkleController
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _blobController.dispose();
    for (final c in _bounceControllers) {
      c.dispose();
    }
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final tabCount = widget.items.length;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: math.max(bottomPadding, 12),
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8F0), // krem
              Color(0xFFFDF3FF), // açık lavanta
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            // Birincil renkli gölge
            BoxShadow(
              color: const Color(0xFFAB47BC).withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            // İkincil turuncu ton
            BoxShadow(
              color: const Color(0xFFFFA726).withValues(alpha: 0.14),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 1.5,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / tabCount;
            
            return AnimatedBuilder(
              animation: Listenable.merge([_blobController]),
              builder: (context, _) {
                final blobLeft = _blobPosition.value * itemWidth;
                
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // ── Kayan blob (squash & stretch) ─────────────────────────
                    Positioned(
                      left: blobLeft + itemWidth * 0.12,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.diagonal3Values(
                            _blobScaleX.value,
                            _blobScaleY.value,
                            1.0,
                          ),
                          child: Container(
                            width: itemWidth * 0.76,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _NavColors.tabColors[
                                      widget.currentIndex %
                                          _NavColors.tabColors.length]
                                  .withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),

                // ── Sekme öğeleri ──────────────────────────────────────────
                Row(
                  children: List.generate(tabCount, (index) {
                    return _NavItemTile(
                      item: widget.items[index],
                      isSelected: widget.currentIndex == index,
                      activeColor: _NavColors.tabColors[
                          index % _NavColors.tabColors.length],
                      bounceScale: _bounceScales[index],
                      showSparkle: _sparkleTabIndex == index &&
                          _sparkleController.isAnimating,
                      particles:
                          _sparkleTabIndex == index ? _particles : const [],
                      onTap: () => widget.onTap(index),
                    );
                  }),
                ),
              ],
            );
          }, // end AnimatedBuilder builder
        ); // end AnimatedBuilder
      }, // end LayoutBuilder builder
    ), // end LayoutBuilder
      ),
    );
  }
}

// ─── Tek Sekme Tile ──────────────────────────────────────────────────────────

class _NavItemTile extends StatelessWidget {
  const _NavItemTile({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.bounceScale,
    required this.showSparkle,
    required this.particles,
    required this.onTap,
  });

  final NavItem item;
  final bool isSelected;
  final Color activeColor;
  final Animation<double> bounceScale;
  final bool showSparkle;
  final List<_SparkleParticle> particles;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Sparkle katmanı (ikon etrafına dağılan yıldızcıklar)
              if (showSparkle && particles.isNotEmpty)
                Positioned.fill(
                  child: ClipRect(
                    child: CustomPaint(
                      painter: _SparklePainter(particles: particles),
                    ),
                  ),
                ),

              // İkon + etiket + nokta göstergesi sütunu
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bounce animasyonlu ikon
                  AnimatedBuilder(
                    animation: bounceScale,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: bounceScale.value,
                        child: child,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      width: isSelected ? 38 : 30,
                      height: isSelected ? 38 : 30,
                      child: Icon(
                        isSelected ? item.activeIcon : item.icon,
                        size: isSelected ? 26 : 22,
                        color: isSelected ? activeColor : _NavColors.inactive,
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),

                  // Etiket metni
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    style: GoogleFonts.nunito(
                      fontSize: isSelected ? 10.5 : 9.5,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: isSelected ? activeColor : _NavColors.inactive,
                    ),
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // Aktif sekme nokta göstergesi
                  AnimatedScale(
                    scale: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.elasticOut,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: activeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
