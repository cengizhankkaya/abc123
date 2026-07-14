import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Ana avatar widget'ı — Fluttermoji SVG sistemi kullanır.
///
/// Eski CustomPaint tabanlı (şapka/gözlük/kıyafet katmanları) sistem kaldırıldı.
/// Bu widget [FluttermojiController] ile çalışır; widget ağacında
/// ChangeNotifierProvider<FluttermojiController> sağlanmış olması gerekir.
class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    this.size = 180,
    this.showBackground = true,
  });

  final double size;
  final bool showBackground;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 1.09)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 42,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.09, end: 1)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 58,
      ),
    ]).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FluttermojiController>();
    final s = widget.size;

    return AnimatedBuilder(
      animation: _pulseScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseScale.value,
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
                    color: Colors.blue.withValues(alpha: 0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              )
            : null,
        child: ClipOval(
          child: controller.fluttermoji.isEmpty
              ? const Center(child: CupertinoActivityIndicator())
              : SvgPicture.string(
                  controller.fluttermoji,
                  width: s,
                  height: s,
                  fit: BoxFit.cover,
                  semanticsLabel: 'Avatar',
                  placeholderBuilder: (_) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
