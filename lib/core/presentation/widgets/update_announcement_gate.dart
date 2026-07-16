import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:abc123/core/domain/ports/i_remote_config_service.dart';
import 'package:abc123/core/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Uygulama açılışında opsiyonel güncelleme bottom sheet'ini gösterir.
///
/// Zorla güncellemenin aksine kullanıcı kapatabilir — sadece öneri niteliğindedir.
/// Remote Config'deki `optional_build_number` mevcut build'den büyükse tetiklenir.
class UpdateAnnouncementGate extends StatefulWidget {
  const UpdateAnnouncementGate({
    required this.remoteConfigService,
    required this.child,
    super.key,
  });

  final IRemoteConfigService remoteConfigService;
  final Widget child;

  @override
  State<UpdateAnnouncementGate> createState() => _UpdateAnnouncementGateState();
}

class _UpdateAnnouncementGateState extends State<UpdateAnnouncementGate> {
  @override
  void initState() {
    super.initState();
    // İlk frame sonrası göster — router tamamen mount olduktan sonra.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_checkOptionalUpdate());
    });
  }

  Future<void> _checkOptionalUpdate() async {
    if (!mounted) return;
    try {
      final optionalBuildNumber = widget.remoteConfigService.optionalBuildNumber;
      if (optionalBuildNumber <= 0) return; // Devre dışı

      final packageInfo = await PackageInfo.fromPlatform();
      final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      if (currentBuildNumber >= optionalBuildNumber) return; // Güncel

      final prefs = await SharedPreferences.getInstance();
      final seenVersion = prefs.getInt('seen_optional_update_version') ?? 0;

      if (optionalBuildNumber <= seenVersion) return; // Kullanıcı bu sürümü zaten gördü/atladı

      // Kullanıcının bu güncellemeyi gördüğünü kaydedelim ki bir daha çıkmasın
      await prefs.setInt('seen_optional_update_version', optionalBuildNumber);

      if (!mounted) return;
      await _showUpdateSheet();
    } on Exception catch (_) {
      // Hata durumunda sessizce devam et.
    }
  }

  Future<void> _showUpdateSheet() async {
    final navContext = rootNavigatorKey.currentContext;
    if (navContext == null) return;

    final whatsNew = widget.remoteConfigService.whatsNew;
    await showDialog<void>(
      context: navContext,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: UpdateAvailableSheet(
          appName: 'abc123',
          whatsNew: whatsNew,
          onUpdate: _openStore,
        ),
      ),
    );
  }

  Future<void> _openStore() async {
    final Uri storeUrl;
    if (Platform.isIOS) {
      storeUrl = Uri.parse('https://apps.apple.com/tr/app/abc1234/id6762213643?l=trAbc1234');
    } else {
      storeUrl = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.cengizhan.abc123',
      );
    }
    if (await canLaunchUrl(storeUrl)) {
      await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// -----------------------------------------------------------------
/// Ana widget
/// -----------------------------------------------------------------
class UpdateAvailableSheet extends StatefulWidget {
  const UpdateAvailableSheet({
    required this.appName,
    required this.whatsNew,
    super.key,
    this.onUpdate,
    this.onLater,
  });
  final String appName;
  final String whatsNew;
  final VoidCallback? onUpdate;
  final VoidCallback? onLater;

  @override
  State<UpdateAvailableSheet> createState() => _UpdateAvailableSheetState();
}

class _UpdateAvailableSheetState extends State<UpdateAvailableSheet> with TickerProviderStateMixin {
  // Kart zıplayarak gelsin
  late final AnimationController _entryController;
  late final Animation<double> _entryScale;

  // İkon sürekli hafifçe yukarı-aşağı süzülsün (bob)
  late final AnimationController _floatController;

  // Roket ikonu hafifçe sağa-sola sallansın
  late final AnimationController _wiggleController;

  // "YENİ" rozeti nabız gibi büyüyüp küçülsün
  late final AnimationController _pulseController;

  // Buton parlama / nefes alma efekti
  late final AnimationController _glowController;

  // Konfeti parçacıkları
  late final AnimationController _confettiController;
  final List<_Confetto> _confetti = List.generate(26, _Confetto.new);

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entryScale = CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _wiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _floatController.dispose();
    _wiggleController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _entryScale,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // Arka plan gradyanı
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4FC3F7), Color(0xFF1565C0)],
                  ),
                ),
              ),

              // Konfeti animasyonu
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _confettiController,
                  builder: (_, __) => CustomPaint(
                    painter: _ConfettiPainter(
                      confetti: _confetti,
                      t: _confettiController.value,
                    ),
                  ),
                ),
              ),

              // İçerik
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 44, 28, 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // İkon + YENİ rozeti
                    _buildFloatingIcon(),
                    const SizedBox(height: 26),

                    const Text(
                      'Harika Bir Güncelleme!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('🎉', style: TextStyle(fontSize: 26)),
                    const SizedBox(height: 14),

                    Text(
                      '${widget.appName} güncellendi. Yeni özellikleri kaçırmayın!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.92),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Yenilikler listesi (Remote Config'den)
                    if (widget.whatsNew.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '✨ Neler Yeni?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white.withValues(alpha: 0.95),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.whatsNew,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],

                    _buildUpdateButton(context),
                    const SizedBox(height: 18),

                    TextButton(
                      onPressed: () {
                        widget.onLater?.call();
                        Navigator.of(context).maybePop();
                      },
                      child: Text(
                        'Daha Sonra',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatController, _wiggleController, _pulseController]),
      builder: (_, __) {
        final floatY = -8 * sin(_floatController.value * pi);
        final wiggle = sin(_wiggleController.value * 2 * pi) * 0.09;
        final badgeScale = 1 + 0.12 * sin(_pulseController.value * 2 * pi);

        return Transform.translate(
          offset: Offset(0, floatY),
          child: SizedBox(
            width: 130,
            height: 130,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Beyaz daire + roket
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Transform.rotate(
                      angle: wiggle,
                      child: Image.asset(
                        'assets/fonts/applog.png',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // YENİ rozeti (nabız gibi büyüyüp küçülür)
                Positioned(
                  top: -6,
                  right: -18,
                  child: Transform.scale(
                    scale: badgeScale,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD23F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        'YENİ',
                        style: TextStyle(
                          color: Color(0xFFB3261E),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (_, __) {
        final glow = 8 + 10 * _glowController.value;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B35).withValues(alpha: 0.55),
                blurRadius: glow,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                widget.onUpdate?.call();
                Navigator.of(context).maybePop();
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A50), Color(0xFFFF5F2E)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'ŞİMDİ GÜNCELLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// -----------------------------------------------------------------
/// Konfeti parçacığı modeli + çizici (harici paket kullanılmaz)
/// -----------------------------------------------------------------
class _Confetto {
  _Confetto(int seed)
      : startX = _rand(seed, 1),
        speed = 0.6 + _rand(seed, 2) * 0.9,
        size = 5 + _rand(seed, 3) * 7,
        phase = _rand(seed, 4),
        swaySpeed = 1 + _rand(seed, 5) * 2,
        isCircle = seed % 2 == 0,
        color = _palette[seed % _palette.length];
  final double startX; // 0..1
  final double speed; // düşüş hızı
  final double size;
  final double phase; // başlangıç gecikmesi
  final double swaySpeed;
  final Color color;
  final bool isCircle;

  static const List<Color> _palette = [
    Color(0xFFFFD23F),
    Color(0xFFFF6B35),
    Color(0xFF4FC3F7),
    Color(0xFF7ED957),
    Color(0xFFFF6FB5),
    Colors.white,
  ];

  static double _rand(int seed, int salt) {
    final r = Random(seed * 977 + salt * 131);
    return r.nextDouble();
  }
}

class _ConfettiPainter extends CustomPainter {
  // 0..1 döngü ilerlemesi

  _ConfettiPainter({required this.confetti, required this.t});
  final List<_Confetto> confetti;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    for (final c in confetti) {
      // Her parçacık kendi fazından başlayarak sürekli düşer (loop)
      final progress = (t * c.speed + c.phase) % 1.0;
      final y = progress * size.height;
      final sway = sin(progress * c.swaySpeed * 2 * pi) * 14;
      final x = c.startX * size.width + sway;

      // Yukarıdan aşağı sönümlenen opaklık (üstte belirir, altta kaybolur)
      final opacity = (1 - progress).clamp(0.0, 1.0) * 0.9;
      final paint = Paint()..color = c.color.withValues(alpha: opacity);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * 4 * pi);
      if (c.isCircle) {
        canvas.drawCircle(Offset.zero, c.size / 2, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: c.size, height: c.size * 0.5),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
