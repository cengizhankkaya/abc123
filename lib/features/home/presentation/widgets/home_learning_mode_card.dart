import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

/// Gri-tonlama matrix'i — kilitli kart ikonunu soluklaştırmak için.
const List<double> _greyscale = [
  0.55, 0.0, 0.0, 0, 40,
  0.0, 0.55, 0.0, 0, 40,
  0.0, 0.0, 0.55, 0, 40,
  0, 0, 0, 1, 0,
];

/// Ana sayfa öğrenme modu kartı — ada haritası düğüm tasarımı.
///
/// Dairesel bir "node" ile ilerleyişi (progress ring), önerilip önerilmediğini
/// (suggested pulse) ve kilitli / açık durumu gösterir.
///
/// `RegionNode` tasarımından uyarlanmıştır; [GridView] içinde kullanılmak
/// üzere Column tabanlı düzene geçirilmiştir.
class HomeLearningModeCard extends StatefulWidget {
  const HomeLearningModeCard({
    required this.title,
    required this.subtitle,
    required this.baseColor,
    required this.icon,
    required this.emoji,
    required this.onTap,
    this.imagePath,
    this.modelPath,
    this.progress,
    this.suggested = false,
    this.locked = false,
    super.key,
  });

  /// Banner'da gösterilen başlık (ör. "Sayılar").
  final String title;

  /// Düğümün altındaki kısa etiket (ör. "Çiz & Öğren").
  final String subtitle;

  /// Düğüm çekirdeğinin ana rengi.
  final Color baseColor;

  /// Düğüm içindeki ikon.
  final IconData icon;

  /// Düğüm içinde daire şeklinde gösterilecek resim yolu (ör. assets/images/number.png).
  final String? imagePath;

  /// Düğüm içinde gösterilecek 3D model yolu (ör. assets/models/ar/kedi.glb).
  final String? modelPath;

  /// Banner'ın solundaki emoji (ör. "🔢").
  final String emoji;

  final VoidCallback onTap;

  /// 0.0 – 1.0 arası ilerleme; `null` ise ring çizilmez.
  final double? progress;

  /// Önerilen kart için altın renkli nabız efekti.
  final bool suggested;

  /// Kilitli kartlar grileştirilir, dokunulamaz.
  final bool locked;

  @override
  State<HomeLearningModeCard> createState() => _HomeLearningModeCardState();
}

class _HomeLearningModeCardState extends State<HomeLearningModeCard>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _tapController;
  late final Animation<double> _pulse;
  late final Animation<double> _tapScale;

  static const double _nodeSize = 80;
  static const double _iconSize = 30;

  @override
  void initState() {
    super.initState();

    // Suggested nabız animasyonu — sürekli tekrar eder.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    // ignore: discarded_futures
    _pulseController.repeat();

    _pulse = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Dokunma sırasındaki küçülme animasyonu.
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _tapScale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  /// baseColor'ın koyulaştırılmış tonu — gölge için kullanılır.
  Color get _darkColor {
    final hsl = HSLColor.fromColor(widget.baseColor);
    return hsl
        .withLightness((hsl.lightness - 0.18).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${widget.title}. ${widget.subtitle}',
      child: GestureDetector(
        onTapDown: (_) => _tapController.forward(),
        onTapUp: (_) {
          // ignore: discarded_futures
          _tapController.reverse();
          if (!widget.locked) widget.onTap();
        },
        // ignore: discarded_futures
        onTapCancel: () => _tapController.reverse(),
        child: ScaleTransition(
          scale: _tapScale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Banner (pill başlık)
              _CardBanner(
                emoji: widget.emoji,
                title: widget.title,
                locked: widget.locked,
              ),
              const SizedBox(height: 4),

              // 2. Tag (Önerilen / Keşfedilmedi)
              _CardTag(
                suggested: widget.suggested,
                locked: widget.locked,
              ),
              const SizedBox(height: 6),

              // 3. Dairesel düğüm
              AnimatedBuilder(
                animation: _pulse,
                builder: (_, __) => _CircleNode(
                  nodeSize: _nodeSize,
                  iconSize: _iconSize,
                  baseColor: widget.baseColor,
                  darkColor: _darkColor,
                  icon: widget.icon,
                  imagePath: widget.imagePath,
                  modelPath: widget.modelPath,
                  pulse: _pulse.value,
                  progress: widget.progress,
                  suggested: widget.suggested,
                  locked: widget.locked,
                ),
              ),
              const SizedBox(height: 6),

              // 4. Alt etiket
              _CardLabel(text: widget.subtitle),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// Dairesel düğüm: nabız halkası + progress ring + çekirdek ikon/resim + kilit.
class _CircleNode extends StatelessWidget {
  const _CircleNode({
    required this.nodeSize,
    required this.iconSize,
    required this.baseColor,
    required this.darkColor,
    required this.icon,
    required this.pulse,
    required this.progress,
    required this.suggested,
    required this.locked,
    this.imagePath,
    this.modelPath,
  });

  final double nodeSize;
  final double iconSize;
  final Color baseColor;
  final Color darkColor;
  final IconData icon;
  final String? imagePath;
  final String? modelPath;
  final double pulse; // 0..1
  final double? progress;
  final bool suggested;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: nodeSize,
      height: nodeSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Suggested nabız halkası (altın rengi yayılan halka)
          if (suggested)
            Container(
              width: nodeSize + 24 * pulse,
              height: nodeSize + 24 * pulse,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFC93C)
                        .withValues(alpha: 0.55 * (1 - pulse)),
                    blurRadius: 12,
                    spreadRadius: 12 * pulse,
                  ),
                ],
              ),
            ),

          // İlerleme halkası
          CustomPaint(
            size: Size(nodeSize, nodeSize),
            painter: _RingPainter(
              progress: progress,
              locked: locked,
              strokeWidth: 5,
              color: baseColor,
            ),
          ),

          // Çekirdek daire + resim/ikon
          Container(
            width: nodeSize * .78,
            height: nodeSize * .78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(baseColor, Colors.white, .35)!,
                  baseColor,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: darkColor,
                  offset: const Offset(0, 7),
                ),
                BoxShadow(
                  color: darkColor.withValues(alpha: .5),
                  blurRadius: 18,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Saydam PNG'lerin arkası için ana renk gradyanı
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.lerp(baseColor, Colors.white, .35)!,
                          baseColor,
                        ],
                      ),
                    ),
                  ),
                  if (modelPath != null)
                    IgnorePointer(
                      child: ModelViewer(
                        src: modelPath!,
                        autoRotate: true,
                        autoRotateDelay: 0,
                        rotationPerSecond: '30deg',
                        cameraControls: false,
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  else if (imagePath != null)
                    (locked
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.matrix(_greyscale),
                            child: Opacity(
                              opacity: .65,
                              child: Image.asset(
                                imagePath!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Image.asset(
                            imagePath!,
                            fit: BoxFit.cover,
                          ))
                  else
                    Center(
                      child: ColorFiltered(
                        colorFilter: locked
                            ? const ColorFilter.matrix(_greyscale)
                            : const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.dst,
                              ),
                        child: Opacity(
                          opacity: locked ? .65 : 1,
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ),
                  // İç kenarlık (camsı 3D etki)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.32),
                        width: 2.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Kilit emojisi
          if (locked)
            const Text(
              '🔒',
              style: TextStyle(
                fontSize: 17,
                shadows: [Shadow(color: Colors.black38, blurRadius: 2)],
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// Üstteki yuvarlak pill başlık — emoji + başlık metni.
class _CardBanner extends StatelessWidget {
  const _CardBanner({
    required this.emoji,
    required this.title,
    required this.locked,
  });

  final String emoji;
  final String title;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: locked ? .8 : 1),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(color: Color(0x1F213255), offset: Offset(0, 3)),
        ],
      ),
      child: Text(
        '$emoji $title',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 11,
          color: Color(0xFF213255),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// Küçük durum etiketi — "ÖNERİLEN" (altın) veya "KEŞFEDİLMEDİ" (gri).
/// Ne önerilen ne kilitli ise sabit yükseklikte boş alan döner.
class _CardTag extends StatelessWidget {
  const _CardTag({required this.suggested, required this.locked});

  final bool suggested;
  final bool locked;

  static const double _height = 18;

  @override
  Widget build(BuildContext context) {
    if (!suggested && !locked) return const SizedBox(height: _height);

    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
      decoration: BoxDecoration(
        color: suggested
            ? const Color(0xFFFFC93C)
            : Colors.white.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: suggested
                ? const Color(0xFFE8A400)
                : const Color(0xFF213255).withValues(alpha: .1),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        suggested ? 'ÖNERİLEN' : 'KEŞFEDİLMEDİ',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: .4,
          color: suggested ? Colors.white : HomeDesignTokens.mutedText,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// Düğümün altındaki kısa etiket (pill).
class _CardLabel extends StatelessWidget {
  const _CardLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(color: Color(0x1A213255), offset: Offset(0, 3)),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: Color(0xFF213255),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
/// Dairesel ilerleme halkası çizici.
class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.locked,
    required this.strokeWidth,
    required this.color,
  });

  final double? progress;
  final bool locked;
  final double strokeWidth;
  final Color color;

  static const double _pi = 3.1415926535897932;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - strokeWidth;

    // Arka plan halkası
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = color.withValues(alpha: .3),
    );

    // İlerleme yayı
    if (progress != null && !locked) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -_pi / 2,
        2 * _pi * progress!,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress ||
      old.locked != locked ||
      old.color != color;
}
