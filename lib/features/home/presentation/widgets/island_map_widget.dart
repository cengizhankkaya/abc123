import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/theme/island_colors.dart';
import 'package:abc123/features/home/presentation/widgets/avatar_widget.dart';
import 'package:abc123/features/home/presentation/widgets/home_learning_mode_card.dart';
import 'package:abc123/features/home/presentation/widgets/stat_pill.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Sabitler
// ═══════════════════════════════════════════════════════════════════════════════

/// SVG viewBox ile aynı referans boyutları.
const double _kRefWidth = 2060;
const double _kRefHeight = 800;

// ═══════════════════════════════════════════════════════════════════════════════
// Ada haritası — ana widget
// ═══════════════════════════════════════════════════════════════════════════════

/// Tam ekran yatay kaydırmalı ada haritası.
///
/// `abc123-v7.html` tasarımının Flutter uygulaması.
class IslandMapWidget extends StatefulWidget {
  const IslandMapWidget({super.key});

  @override
  State<IslandMapWidget> createState() => _IslandMapWidgetState();
}

class _IslandMapWidgetState extends State<IslandMapWidget> with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _driftController;
  late final AnimationController _pulseController;
  late final Animation<double> _drift;

  double _scrollRatio = 0;
  bool _hintVisible = true;

  static const int _dotCount = 8;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    // Bulut kayma animasyonu
    _driftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );
    // ignore: discarded_futures
    _driftController.repeat(reverse: true);
    _drift = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _driftController, curve: Curves.easeInOut),
    );

    // Düğüm nabız animasyonu
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    // ignore: discarded_futures
    _pulseController.repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _driftController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final ratio = max > 0 ? _scrollController.offset / max : 0.0;
    if (ratio != _scrollRatio || _hintVisible) {
      setState(() {
        _scrollRatio = ratio;
        _hintVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableH = constraints.maxHeight;
        final scale = availableH / _kRefHeight;
        final mapWidth = _kRefWidth * scale;
        final mapHeight = availableH;

        return Stack(
          children: [
            // ── 1. Deniz gradyanı arka plan ──────────────────────────
            const _SeaBackground(),

            // ── 2. Kaydırılabilir harita ─────────────────────────────
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: mapWidth,
                height: mapHeight,
                child: Stack(
                  children: [
                    // ── Ada blob'ları ────────────────────────────────
                    CustomPaint(
                      size: Size(mapWidth, mapHeight),
                      painter: _IslandBlobPainter(scale: scale),
                    ),

                    // ── Noktalı patika ──────────────────────────────
                    CustomPaint(
                      size: Size(mapWidth, mapHeight),
                      painter: _TrailPainter(scale: scale),
                    ),

                    // ── Bulutlar ─────────────────────────────────────
                    ..._buildClouds(scale),

                    // ── Dekor emojileri ──────────────────────────────
                    ..._buildDecorations(scale),

                    // ── Avatar karşılama ─────────────────────────────
                    _AvatarGreeting(scale: scale),

                    // ── Bölge düğümleri ──────────────────────────────
                    ..._buildRegionNodes(context, scale),
                  ],
                ),
              ),
            ),

            // ── 3. Durum çubuğu — üstte şeffaf overlay ─────────────
            _StatusOverlay(topPad: topPad),
            // ── 5. "Kaydır" ipucu ────────────────────────────────────
            if (_hintVisible) const _SwipeHint(),
          ],
        );
      },
    );
  }

  // ─── Bulut widget'ları ───────────────────────────────────────────────
  List<Widget> _buildClouds(double scale) {
    const clouds = [
      (34.0, 10.0, 90.0, 0.0),
      (150.0, 470.0, 70.0, 1.2),
      (50.0, 930.0, 80.0, 0.6),
      (120.0, 1380.0, 76.0, 1.8),
    ];
    return clouds.map((c) {
      final (top, left, width, delay) = c;
      return _CloudWidget(
        top: top * scale,
        left: left * scale,
        width: width * scale,
        drift: _drift,
        delay: delay,
      );
    }).toList();
  }

  // ─── Dekor emojileri ─────────────────────────────────────────────────
  List<Widget> _buildDecorations(double scale) {
    const decorations = [
      (355.0, 85.0, '🌴', 20.0, false),
      (530.0, 95.0, '🐚', 16.0, false),
      (500.0, 300.0, '🌴', 14.0, false),
      (490.0, 310.0, '🌲', 19.0, false),
      (600.0, 260.0, '⛵', 20.0, false),
      (640.0, 340.0, '🌳', 19.0, false),
      (630.0, 450.0, '🌲', 15.0, false),
      (380.0, 470.0, '🐬', 18.0, false),
      (335.0, 560.0, '🪨', 16.0, true),
      (340.0, 660.0, '⛰️', 22.0, true),
      (500.0, 600.0, '🪨', 16.0, true),
      (620.0, 720.0, '⛵', 19.0, true),
      (500.0, 780.0, '🌾', 16.0, true),
      (640.0, 900.0, '🌾', 16.0, true),
      (620.0, 800.0, '🍃', 14.0, true),
      (390.0, 940.0, '🐚', 16.0, true),
      (340.0, 1010.0, '🌸', 16.0, true),
      (500.0, 1140.0, '🌼', 16.0, true),
      (610.0, 1160.0, '⚓', 17.0, true),
      (490.0, 1230.0, '🌫️', 16.0, true),
      (640.0, 1380.0, '⭐', 16.0, true),
      (400.0, 1390.0, '🐬', 18.0, true),
      (400.0, 1500.0, '🌴', 20.0, true),
      (560.0, 1680.0, '🌴', 20.0, true),
      // 3D Hayvanlar adası çevresi
      (50.0, 430.0, '🌿', 18.0, true),
      (140.0, 470.0, '🦁', 20.0, true),
      (80.0, 620.0, '🌴', 20.0, true),
      (230.0, 500.0, '🐾', 16.0, true),
      (350.0, 600.0, '🌿', 18.0, true),
      (290.0, 450.0, '🦋', 15.0, true),
      (300.0, 670.0, '🌴', 18.0, true),
    ];
    return decorations.map((d) {
      final (top, left, emoji, size, locked) = d;
      return Positioned(
        top: top * scale,
        left: left * scale,
        child: Opacity(
          opacity: 0.95,
          child: Text(
            emoji,
            style: TextStyle(fontSize: size * scale / 1.0),
          ),
        ),
      );
    }).toList();
  }

  // ─── Bölge düğümleri ─────────────────────────────────────────────────
  List<Widget> _buildRegionNodes(BuildContext context, double scale) {
    final h = context.homeL10n!;
    final cv = context.colorsL10n;

    final regions = [
      _RegionInfo(
        x: 150,
        y: 455,
        title: h.numbersTitleShort,
        subtitle: h.numbersSubtitle,
        color: HomeDesignTokens.numbersCard,
        icon: Icons.numbers_rounded,
        imagePath: ImageConstants.numberImage,
        emoji: '🏝️',
        suggested: true,
        route: AppRoutes.draw,
      ),
      _RegionInfo(
        x: 374,
        y: 565,
        title: h.lettersTitleShort,
        subtitle: h.lettersSubtitle,
        color: HomeDesignTokens.lettersCard,
        icon: Icons.abc_rounded,
        imagePath: ImageConstants.abcImage,
        emoji: '🌲',
        route: AppRoutes.letters,
      ),
      _RegionInfo(
        x: 604,
        y: 425,
        title: h.shapesTitleShort,
        subtitle: h.shapesSubtitle,
        color: HomeDesignTokens.shapesCard,
        icon: Icons.change_history_rounded,
        imagePath: ImageConstants.shapesImage,
        emoji: '⛰️',
        route: AppRoutes.shapes,
      ),
      _RegionInfo(
        x: 840,
        y: 565,
        title: h.wordsTitleShort,
        subtitle: h.wordsSubtitle,
        color: HomeDesignTokens.wordsCard,
        icon: Icons.short_text_rounded,
        imagePath: ImageConstants.wordsImage,
        emoji: '🌾',
        route: AppRoutes.words,
      ),
      _RegionInfo(
        x: 1076,
        y: 425,
        title: h.colorsTitleShort,
        subtitle: h.colorsSubtitle,
        color: HomeDesignTokens.colorsCard,
        icon: Icons.water_drop_rounded,
        imagePath: ImageConstants.colorsImage,
        emoji: '🌼',
        route: AppRoutes.colorGame,
      ),
      _RegionInfo(
        x: 1318,
        y: 565,
        title: cv.colorVisionHomeTitle,
        subtitle: cv.colorVisionHomeSubtitle,
        color: HomeDesignTokens.colorVisionCard,
        icon: Icons.remove_red_eye_rounded,
        imagePath: ImageConstants.robotImage,
        emoji: '🌫️',
        route: AppRoutes.colorVisionGame,
      ),
      _RegionInfo(
        x: 1600,
        y: 470,
        title: h.mathAdvancedTitle,
        subtitle: h.mathAdvancedSubtitle,
        color: HomeDesignTokens.mathCard,
        icon: Icons.calculate_rounded,
        imagePath: ImageConstants.calculateImage,
        emoji: '👑',
        route: AppRoutes.mathAdvanced,
      ),
      _RegionInfo(
        x: 550,
        y: 220,
        title: h.animals3dTitle,
        subtitle: h.animals3dSubtitle,
        color: IslandColors.animals,
        icon: Icons.pets_rounded,
        imagePath: null,
        modelPath: 'assets/models/ar/kedi.glb',
        emoji: '🦁',
        suggested: false,
        route: AppRoutes.animals3D,
      ),
    ];

    return regions.map((r) {
      return Positioned(
        left: r.x * scale,
        top: r.y * scale,
        child: FractionalTranslation(
          translation: const Offset(-0.5, -0.5),
          child: HomeLearningModeCard(
            title: r.title,
            subtitle: r.subtitle,
            baseColor: r.color,
            icon: r.icon,
            imagePath: r.imagePath,
            modelPath: r.modelPath,
            emoji: r.emoji,
            suggested: r.suggested,
            locked: r.locked,
            onTap: () => context.push(r.route),
          ),
        ),
      );
    }).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Veri modeli (private)
// ═══════════════════════════════════════════════════════════════════════════════

class _RegionInfo {
  const _RegionInfo({
    required this.x,
    required this.y,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.emoji,
    required this.route,
    this.imagePath,
    this.modelPath,
    this.suggested = false,
    // ignore: unused_element_parameter
    this.locked = false,
  });

  final double x;
  final double y;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String? imagePath;
  final String? modelPath;
  final String emoji;
  final String route;
  final bool suggested;
  final bool locked;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Deniz gradyanı arka planı
// ═══════════════════════════════════════════════════════════════════════════════

class _SeaBackground extends StatelessWidget {
  const _SeaBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            IslandColors.seaTop,
            IslandColors.seaMid,
            Color(0xFFA9E4E0),
            IslandColors.seaBot,
          ],
          stops: [0.0, 0.26, 0.58, 1.0],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Durum çubuğu overlay
// ═══════════════════════════════════════════════════════════════════════════════

class _StatusOverlay extends StatelessWidget {
  const _StatusOverlay({required this.topPad});
  final double topPad;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final h = context.homeL10n!;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, topPad + 8, 16, 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              IslandColors.seaTop.withValues(alpha: .95),
              IslandColors.seaTop.withValues(alpha: 0),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar (Top Status Bar)
            GestureDetector(
              onTap: () => context.push(AppRoutes.shop),
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1F213255),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const ClipOval(
                  child: AvatarWidget(size: 36),
                ),
              ),
            ),
            // Streak & Points
            Row(
              children: [
                StatPill(
                  emoji: '🔥',
                  label: h.homeStreakDays(provider.streak),
                ),
                const SizedBox(width: 8),
                StatPill(
                  emoji: '⭐',
                  label: '${provider.points}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Kaydırma noktaları göstergesi
// ═══════════════════════════════════════════════════════════════════════════════

class _ScrollDots extends StatelessWidget {
  const _ScrollDots({
    required this.topPad,
    required this.ratio,
    required this.dotCount,
  });

  final double topPad;
  final double ratio;
  final int dotCount;

  @override
  Widget build(BuildContext context) {
    final activeIdx = (ratio * (dotCount - 1)).round().clamp(0, dotCount - 1);

    return Positioned(
      top: topPad + 8,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: IslandColors.ink.withValues(alpha: .28),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(dotCount, (i) {
              final isActive = i == activeIdx;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isActive ? 16 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.white.withValues(alpha: .55),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// "Kaydır" ipucu
// ═══════════════════════════════════════════════════════════════════════════════

class _SwipeHint extends StatelessWidget {
  const _SwipeHint();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 18,
      top: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 8),
              duration: const Duration(milliseconds: 1400),
              curve: Curves.easeInOut,
              builder: (_, value, child) => Transform.translate(
                offset: Offset(value, 0),
                child: child,
              ),
              child: const Text(
                '👉',
                style: TextStyle(
                  fontSize: 22,
                  shadows: [
                    Shadow(
                      color: Color(0x59213255),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Kaydır',
              style: HomeDesignTokens.headingSection(
                color: Colors.white,
              ).copyWith(
                fontSize: 11,
                shadows: [
                  const Shadow(
                    color: Color(0x59213255),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tilki karşılama
// ═══════════════════════════════════════════════════════════════════════════════
// Avatar karşılama
// ═══════════════════════════════════════════════════════════════════════════════

class _AvatarGreeting extends StatelessWidget {
  const _AvatarGreeting({required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 145 * scale,
      left: 40 * scale,
      child: Row(
        children: [
          // Projedeki canlı avatar widget'ı — zıplama/nabız animasyonlu
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 6),
            duration: const Duration(milliseconds: 2600),
            curve: Curves.easeInOut,
            builder: (_, value, child) => Transform.translate(
              offset: Offset(0, -value),
              child: child,
            ),
            child: GestureDetector(
              onTap: () => context.push(AppRoutes.shop),
              child: AvatarWidget(
                size: 80 * scale.clamp(0.6, 1.2),
              ),
            ),
          ),
          SizedBox(width: 14 * scale),
          // Konuşma balonu
          Container(
            constraints: BoxConstraints(maxWidth: 240 * scale),
            padding: EdgeInsets.symmetric(
              horizontal: 14 * scale,
              vertical: 12 * scale,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18 * scale),
                topRight: Radius.circular(18 * scale),
                bottomRight: Radius.circular(18 * scale),
                bottomLeft: Radius.circular(4 * scale),
              ),
              boxShadow: [
                BoxShadow(
                  color: IslandColors.ink.withValues(alpha: .14),
                  offset: Offset(0, 6 * scale),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              'Merhaba! Bu bizim büyük adamız — '
              'istediğin bölgeyi seç, hemen keşfe başlayalım! 🗺️✨',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5 * scale.clamp(0.5, 1.0),
                color: IslandColors.ink,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Bulut widget'ı
// ═══════════════════════════════════════════════════════════════════════════════

class _CloudWidget extends StatelessWidget {
  const _CloudWidget({
    required this.top,
    required this.left,
    required this.width,
    required this.drift,
    required this.delay,
  });

  final double top;
  final double left;
  final double width;
  final Animation<double> drift;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: drift,
      builder: (_, __) {
        // Delay'e göre faz kaydırması
        final phase = (drift.value + delay * 3) % 24 - 12;
        return Positioned(
          top: top,
          left: left + phase,
          child: Opacity(
            opacity: 0.9,
            child: CustomPaint(
              size: Size(width, width * 0.38),
              painter: _CloudPainter(),
            ),
          ),
        );
      },
    );
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final w = size.width;
    final h = size.height;
    canvas.drawOval(Rect.fromLTWH(0, h * .3, w * .5, h * .7), paint);
    canvas.drawOval(Rect.fromLTWH(w * .2, 0, w * .55, h), paint);
    canvas.drawOval(Rect.fromLTWH(w * .5, h * .25, w * .45, h * .6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Ada blob çizici
// ═══════════════════════════════════════════════════════════════════════════════

class _IslandBlobPainter extends CustomPainter {
  const _IslandBlobPainter({required this.scale});
  final double scale;

  Path _landBridgesPath() => Path()
    // Koridor 1 -> 2 (Sayılar - Harfler)
    ..moveTo(240, 530)
    ..cubicTo(280, 510, 320, 520, 340, 550)
    ..lineTo(360, 510)
    ..cubicTo(330, 470, 280, 460, 250, 490)
    ..close()
    // Koridor 2 -> 3 (Harfler - Şekiller)
    ..moveTo(460, 540)
    ..cubicTo(500, 520, 530, 490, 550, 480)
    ..lineTo(570, 510)
    ..cubicTo(540, 530, 500, 560, 470, 580)
    ..close()
    // Koridor 3 -> 4 (Şekiller - Kelimeler)
    ..moveTo(700, 470)
    ..cubicTo(740, 480, 770, 520, 790, 540)
    ..lineTo(810, 510)
    ..cubicTo(780, 480, 750, 440, 710, 440)
    ..close()
    // Koridor 4 -> 5 (Kelimeler - Renkler)
    ..moveTo(930, 540)
    ..cubicTo(970, 520, 1000, 490, 1020, 480)
    ..lineTo(1040, 510)
    ..cubicTo(1010, 540, 970, 570, 940, 580)
    ..close()
    // Koridor 5 -> 6 (Renkler - Görüş)
    ..moveTo(1170, 470)
    ..cubicTo(1210, 480, 1240, 520, 1260, 540)
    ..lineTo(1280, 510)
    ..cubicTo(1250, 480, 1220, 440, 1180, 440)
    ..close()
    // Koridor 6 -> 7 (Görüş - Hazine)
    ..moveTo(1410, 540)
    ..cubicTo(1450, 520, 1490, 490, 1520, 480)
    ..lineTo(1540, 510)
    ..cubicTo(1510, 540, 1470, 570, 1430, 580)
    ..close();

  Path _buildConnectedContinent() {
    var base = Path.combine(PathOperation.union, _numbersPath(), _landBridgesPath());
    base = Path.combine(PathOperation.union, base, _lettersPath());
    base = Path.combine(PathOperation.union, base, _shapesPath());
    base = Path.combine(PathOperation.union, base, _wordsPath());
    base = Path.combine(PathOperation.union, base, _colorsPath());
    base = Path.combine(PathOperation.union, base, _visionPath());
    base = Path.combine(PathOperation.union, base, _bossPath());
    // 3D Hayvanlar adası — ana kıtadan ayrı, bağımsız ada
    return base;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(scale);

    // ── 1. Birleşik Kıta Sığ Su Mercan Halesi ve Derin Gölgesi ──────────────
    final continent = _buildConnectedContinent();
    final animalsIsland = _animalsIslandPath();

    // Derin deniz gölgesi
    canvas.save();
    canvas.translate(0, 14);
    canvas.drawPath(
      continent,
      Paint()
        ..color = IslandColors.ink.withValues(alpha: .32)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );
    canvas.restore();

    // Sığ su (Turkuaz mercan sahil kıyısı)
    canvas.drawPath(
      continent,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 26
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0x665FD3DC),
    );

    // ── Hayvanlar adası sığ su çemberi ───────────────────────────────────
    canvas.drawPath(
      animalsIsland,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0x6659D4A0),
    );

    // ── 2. Birleşik Altın Kumsal / Sahil Katmanı ────────────────────────────
    canvas.drawPath(
      continent,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [IslandColors.sand, IslandColors.sandDk],
        ).createShader(continent.getBounds()),
    );
    // Kumsal kenar çizgisi (tatlı kum sarısı çerçeve)
    canvas.drawPath(
      continent,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFFCBAA6A),
    );

    // ── 3. Gizem adası (sol üst) ────────────────────────────────────────
    _drawMysteryIsland(canvas, _mysteryPath1());

    // ── 4. Tematik Bölge Platoları (Kıta üzerindeki renkli tepeler) ──────────
    _drawBiomePlateau(
        canvas, _numbersPath(), IslandColors.tintNumbers, IslandColors.numbersDk, false);
    _drawBiomePlateau(
        canvas, _lettersPath(), IslandColors.tintLetters, IslandColors.lettersDk, false);
    _drawBiomePlateau(canvas, _shapesPath(), IslandColors.tintShapes, IslandColors.shapesDk, false);
    _drawBiomePlateau(canvas, _wordsPath(), IslandColors.tintWords, IslandColors.wordsDk, false);
    _drawBiomePlateau(canvas, _colorsPath(), IslandColors.tintColors, IslandColors.colorsDk, false);
    _drawBiomePlateau(canvas, _visionPath(), IslandColors.tintVision, IslandColors.visionDk, false);
    _drawBiomePlateau(canvas, _bossPath(), IslandColors.tintBoss, IslandColors.bossDk, false);

    // ── 5. Gizem adası (sağ alt) ────────────────────────────────────────
    _drawMysteryIsland(canvas, _mysteryPath2());

    // ── 6. 3D Hayvanlar adası ─────────────────────────────────────────────
    _drawAnimalsIsland(canvas, animalsIsland);

    canvas.restore();
  }

  void _drawAnimalsIsland(Canvas canvas, Path path) {
    final bounds = path.getBounds();

    // Gölge
    canvas.save();
    canvas.translate(0, 10);
    canvas.drawPath(
      path,
      Paint()
        ..color = IslandColors.ink.withValues(alpha: .30)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
    canvas.restore();

    // Sığ su halkası (yeşil mercan)
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 22
        ..color = IslandColors.animals.withValues(alpha: .25),
    );

    // Kum tabanı
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [IslandColors.sand, IslandColors.sandDk],
        ).createShader(bounds),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..color = const Color(0xFFCBAA6A),
    );

    // Yeşil yayla tabakası
    _drawBiomePlateau(canvas, path, IslandColors.tintAnimals, IslandColors.animals, false);

    // Ada ismi
    final center = bounds.center;
    final tp = TextPainter(
      text: TextSpan(
        text: '🦁 3D Hayvanlar',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14,
          color: Color(0xFF1A4731),
          shadows: [Shadow(color: Colors.white54, blurRadius: 3)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  void _drawBiomePlateau(Canvas canvas, Path path, Color topColor, Color bottomColor, bool locked) {
    final bounds = path.getBounds();

    // Plato gölgesi — kum katmanının üstünde 3D yükseltilmiş hissi verir
    canvas.save();
    canvas.translate(0, 6);
    canvas.drawPath(
      path,
      Paint()
        ..color = IslandColors.ink.withValues(alpha: .28)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.restore();

    // Tematik renk gradyanı
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: locked ? [_greyed(topColor), _greyed(bottomColor)] : [topColor, bottomColor],
      ).createShader(bounds);
    if (locked) {
      fillPaint.color = fillPaint.color.withValues(alpha: .72);
    }
    canvas.drawPath(path, fillPaint);

    // Plato iç/dış kenarlık çizgisi
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..color =
            locked ? Colors.white.withValues(alpha: .22) : Colors.white.withValues(alpha: .45),
    );
  }

  void _drawMysteryIsland(Canvas canvas, Path path) {
    final bounds = path.getBounds();

    // Gölge
    canvas.save();
    canvas.translate(0, 10);
    canvas.drawPath(
      path,
      Paint()
        ..color = IslandColors.ink.withValues(alpha: .24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );
    canvas.restore();

    // Dolgu — yarı şeffaf kum rengi
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            IslandColors.sand.withValues(alpha: .5),
            IslandColors.sandDk.withValues(alpha: .5),
          ],
        ).createShader(bounds),
    );

    // Kesikli kenar çizgisi
    _drawDashedPath(canvas, path);

    // "???" yazısı
    final center = bounds.center;
    final textPainter = TextPainter(
      text: TextSpan(
        text: '???',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: Colors.white.withValues(alpha: .8),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawDashedPath(Canvas canvas, Path path) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white.withValues(alpha: .55);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + 7).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + 7;
      }
    }
  }

  Color _greyed(Color c) {
    final r = (c.r * 255).round();
    final g = (c.g * 255).round();
    final b = (c.b * 255).round();
    final a = (c.a * 255).round();
    final grey = (r * 0.3 + g * 0.59 + b * 0.11).round();
    return Color.fromARGB(a, grey, grey, grey).withValues(alpha: .68);
  }

  @override
  bool shouldRepaint(covariant _IslandBlobPainter old) => old.scale != scale;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Patika çizici (Birleşik Kraliyet Yol ve Adım Noktaları)
// ═══════════════════════════════════════════════════════════════════════════════

class _TrailPainter extends CustomPainter {
  const _TrailPainter({required this.scale});
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(150 * scale, 455 * scale)
      ..cubicTo(187.3 * scale, 473.3 * scale, 298.3 * scale, 570 * scale, 374 * scale, 565 * scale)
      ..cubicTo(449.7 * scale, 560 * scale, 526.3 * scale, 425 * scale, 604 * scale, 425 * scale)
      ..cubicTo(681.7 * scale, 425 * scale, 761.3 * scale, 565 * scale, 840 * scale, 565 * scale)
      ..cubicTo(918.7 * scale, 565 * scale, 996.3 * scale, 425 * scale, 1076 * scale, 425 * scale)
      ..cubicTo(
          1155.7 * scale, 425 * scale, 1230.7 * scale, 557.5 * scale, 1318 * scale, 565 * scale)
      ..cubicTo(
          1405.3 * scale, 572.5 * scale, 1553 * scale, 485.8 * scale, 1600 * scale, 470 * scale);

    // 1. Patika Alt Gölgesi
    canvas.save();
    canvas.translate(0, 4 * scale);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14 * scale
        ..strokeCap = StrokeCap.round
        ..color = IslandColors.ink.withValues(alpha: .28)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.restore();

    // 2. Patika Dış Kenarlığı (Altın/Toprak Yol Çerçevesi)
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12 * scale
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xFFC89840),
    );

    // 3. Patika İçi (Parlak Krem/Altın Yürüyüş Yolu)
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7 * scale
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xFFFFF6D8),
    );

    // 4. Adım Noktaları / Taşlar
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position;
        if (pos != null) {
          canvas.drawCircle(pos, 2.2 * scale, dotPaint);
        }
        distance += 22 * scale;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter old) => old.scale != scale;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SVG Path verileri — HTML'den çevrilmiştir
// (tüm koordinatlar 1740×800 referans uzayında)
// ═══════════════════════════════════════════════════════════════════════════════

Path _mysteryPath1() => Path()
  ..moveTo(133.3, 243.3)
  ..cubicTo(120, 256.1, 94.1, 259, 75.9, 259.2)
  ..cubicTo(57.7, 259.4, 36.6, 255.1, 24.1, 244.5)
  ..cubicTo(11.6, 234, 4.8, 214.7, 1, 195.9)
  ..cubicTo(-2.9, 177.1, -9.8, 145.1, 0.7, 131.6)
  ..cubicTo(11.1, 118.2, 46.1, 112.5, 63.6, 115.1)
  ..cubicTo(81.1, 117.8, 90.3, 136.4, 105.6, 147.7)
  ..cubicTo(121, 158.9, 151.2, 166.7, 155.8, 182.7)
  ..cubicTo(160.4, 198.6, 146.6, 230.6, 133.3, 243.3)
  ..close();

Path _numbersPath() => Path()
  ..moveTo(309.8, 504.4)
  ..cubicTo(300.5, 534.8, 273.7, 570.4, 247.4, 585.1)
  ..cubicTo(221.1, 599.8, 182.1, 594.6, 151.9, 592.6)
  ..cubicTo(121.8, 590.6, 86.8, 589.4, 66.7, 573.2)
  ..cubicTo(46.5, 557, 44.6, 523.8, 31, 495.6)
  ..cubicTo(17.3, 467.3, -17.8, 433.9, -15.4, 403.8)
  ..cubicTo(-13, 373.8, 18.2, 330.8, 45.4, 315.2)
  ..cubicTo(72.6, 299.6, 120.2, 301.4, 147.9, 310.1)
  ..cubicTo(175.7, 318.8, 186, 351.7, 211.9, 367.2)
  ..cubicTo(237.8, 382.6, 287.1, 379.9, 303.4, 402.7)
  ..cubicTo(319.7, 425.6, 319.1, 474, 309.8, 504.4)
  ..close();

Path _lettersPath() => Path()
  ..moveTo(442.4, 699.4)
  ..cubicTo(415.1, 709.3, 380.3, 703.7, 353, 697.2)
  ..cubicTo(325.7, 690.7, 296.4, 678.9, 278.7, 660.2)
  ..cubicTo(261, 641.5, 256.9, 614.2, 246.8, 585.1)
  ..cubicTo(236.7, 556, 209.1, 513, 217.9, 485.4)
  ..cubicTo(226.8, 457.8, 270.7, 427, 300, 419.6)
  ..cubicTo(329.3, 412.2, 368.1, 429.8, 393.7, 440.8)
  ..cubicTo(419.3, 451.8, 429.7, 469, 453.6, 485.4)
  ..cubicTo(477.6, 501.8, 526.7, 513.8, 537.2, 539.2)
  ..cubicTo(547.7, 564.6, 532.4, 611, 516.6, 637.7)
  ..cubicTo(500.7, 664.4, 469.6, 689.4, 442.4, 699.4)
  ..close();

Path _shapesPath() => Path()
  ..moveTo(547.9, 547.6)
  ..cubicTo(526.2, 535.6, 515.4, 506.6, 500.5, 483.4)
  ..cubicTo(485.5, 460.1, 461.4, 436.8, 458.1, 408.1)
  ..cubicTo(454.7, 379.4, 460.6, 332.3, 480.1, 311.1)
  ..cubicTo(499.6, 289.9, 547.2, 277.6, 575, 281)
  ..cubicTo(602.7, 284.5, 622.2, 318.8, 646.7, 331.8)
  ..cubicTo(671.1, 344.7, 702.2, 340.2, 721.5, 358.8)
  ..cubicTo(740.8, 377.4, 763.1, 414.9, 762.4, 443.3)
  ..cubicTo(761.8, 471.8, 739.6, 510.8, 717.6, 529.4)
  ..cubicTo(695.6, 548.1, 658.6, 552.4, 630.3, 555.4)
  ..cubicTo(602, 558.5, 569.5, 559.6, 547.9, 547.6)
  ..close();

Path _wordsPath() => Path()
  ..moveTo(729.6, 604.3)
  ..cubicTo(716.6, 578.1, 684, 547.7, 685.8, 519.5)
  ..cubicTo(687.6, 491.4, 715.3, 450.6, 740.4, 435.5)
  ..cubicTo(765.4, 420.4, 810.2, 421, 836.3, 428.8)
  ..cubicTo(862.3, 436.6, 872.3, 468.2, 896.6, 482.5)
  ..cubicTo(920.8, 496.8, 966.1, 493.5, 981.6, 514.7)
  ..cubicTo(997.2, 535.8, 998.1, 580.7, 989.9, 609.2)
  ..cubicTo(981.8, 637.7, 957.1, 671.4, 932.7, 685.5)
  ..cubicTo(908.3, 699.6, 871.7, 695.1, 843.5, 693.6)
  ..cubicTo(815.3, 692.1, 782.6, 691.4, 763.6, 676.5)
  ..cubicTo(744.6, 661.6, 742.5, 630.4, 729.6, 604.3)
  ..close();

Path _colorsPath() => Path()
  ..moveTo(919.2, 347.6)
  ..cubicTo(927.5, 319.9, 970.7, 288.2, 999.9, 280.2)
  ..cubicTo(1029, 272.2, 1068.6, 288.6, 1094.2, 299.4)
  ..cubicTo(1119.9, 310.2, 1129.8, 328.8, 1153.9, 345.1)
  ..cubicTo(1177.9, 361.4, 1227.6, 372, 1238.5, 397.1)
  ..cubicTo(1249.4, 422.2, 1234.9, 468.9, 1219.6, 495.8)
  ..cubicTo(1204.2, 522.8, 1173.6, 548.7, 1146.4, 559)
  ..cubicTo(1119.3, 569.2, 1084.3, 563.4, 1056.8, 557.2)
  ..cubicTo(1029.3, 551.1, 999.4, 540.3, 981.6, 521.8)
  ..cubicTo(963.8, 503.4, 960.3, 475.7, 949.9, 446.6)
  ..cubicTo(939.5, 417.6, 910.9, 375.4, 919.2, 347.6)
  ..close();

Path _visionPath() => Path()
  ..moveTo(1268, 410.1)
  ..cubicTo(1298.6, 409.5, 1328.1, 441.1, 1354.3, 454.1)
  ..cubicTo(1380.4, 467, 1402.2, 469.1, 1424.9, 487.6)
  ..cubicTo(1447.6, 506.2, 1485.9, 536.2, 1490.4, 565.3)
  ..cubicTo(1494.9, 594.5, 1472.9, 639.1, 1451.7, 662.5)
  ..cubicTo(1430.6, 685.9, 1393.1, 699.5, 1363.4, 705.7)
  ..cubicTo(1333.8, 712, 1299.2, 710.6, 1273.9, 700)
  ..cubicTo(1248.5, 689.5, 1228.2, 664.9, 1211.2, 642.3)
  ..cubicTo(1194.1, 619.8, 1178.3, 595.5, 1171.6, 564.7)
  ..cubicTo(1164.8, 533.9, 1154.6, 483.4, 1170.7, 457.6)
  ..cubicTo(1186.8, 431.8, 1237.4, 410.7, 1268, 410.1)
  ..close();

Path _bossPath() => Path()
  ..moveTo(1658.9, 358.9)
  ..cubicTo(1689.4, 375.7, 1735.2, 368.6, 1757.9, 392.8)
  ..cubicTo(1780.6, 417, 1799, 468.3, 1795, 504.2)
  ..cubicTo(1791, 540.1, 1762.5, 586.9, 1733.8, 608.2)
  ..cubicTo(1705.1, 629.6, 1658.5, 630.3, 1623, 632.2)
  ..cubicTo(1587.4, 634.1, 1546.5, 635.9, 1520.7, 619.6)
  ..cubicTo(1494.8, 603.3, 1486, 564.9, 1468.1, 534.5)
  ..cubicTo(1450.1, 504.1, 1415, 472.9, 1412.8, 437.2)
  ..cubicTo(1410.6, 401.5, 1428, 344.4, 1455, 320.2)
  ..cubicTo(1482, 296, 1540.8, 285.7, 1574.8, 292.2)
  ..cubicTo(1608.8, 298.6, 1628.4, 342.2, 1658.9, 358.9)
  ..close();

Path _mysteryPath2() => Path()
  ..moveTo(1636, 749.5)
  ..cubicTo(1623.1, 736.7, 1611.5, 716.4, 1609.8, 696.5)
  ..cubicTo(1608.2, 676.6, 1612, 641.9, 1625.9, 630.1)
  ..cubicTo(1639.8, 618.2, 1674.7, 620.9, 1693.3, 625.3)
  ..cubicTo(1711.8, 629.8, 1722.5, 643.6, 1737.3, 656.7)
  ..cubicTo(1752, 669.8, 1779.7, 686, 1781.7, 704)
  ..cubicTo(1783.7, 722, 1765.1, 753.2, 1749.3, 764.7)
  ..cubicTo(1733.5, 776.2, 1705.7, 775.7, 1686.8, 773.2)
  ..cubicTo(1667.9, 770.7, 1648.8, 762.3, 1636, 749.5)
  ..close();

// ═══════════════════════════════════════════════════════════════════════════════
// 3D Hayvanlar Adası — bağımsız küçük ada (sağ üst)
// ═══════════════════════════════════════════════════════════════════════════════

Path _animalsIslandPath() => Path()
  ..moveTo(550, 90)
  ..cubicTo(590, 60, 650, 65, 680, 100)
  ..cubicTo(710, 135, 710, 185, 700, 220)
  ..cubicTo(690, 255, 670, 285, 645, 310)
  ..cubicTo(620, 335, 585, 365, 550, 360)
  ..cubicTo(515, 355, 480, 320, 460, 285)
  ..cubicTo(440, 250, 430, 200, 440, 165)
  ..cubicTo(450, 130, 510, 120, 550, 90)
  ..close();
