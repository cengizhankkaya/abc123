import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Kullanıcının Fluttermoji SVG avatarını daire şeklinde gösterir.
///
/// GetX kaldırıldı — abc123'te `ChangeNotifier` + `provider` paketi kullanılıyor.
/// Widget'in çalışması için widget ağacında `FluttermojiController`'ın
/// `ChangeNotifierProvider` olarak sağlanmış olması gerekir.
class FluttermojiCircleAvatar extends StatelessWidget {

  const FluttermojiCircleAvatar({
    super.key,
    this.radius = 75.0,
    this.backgroundColor,
  });
  final double radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<FluttermojiController>(
      builder: (context, controller, _) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor ?? Colors.blueAccent,
          child: controller.fluttermoji.isEmpty
              ? const CupertinoActivityIndicator()
              : SvgPicture.string(
                  controller.fluttermoji,
                  height: radius * 1.6,
                  semanticsLabel: 'Your Fluttermoji',
                  placeholderBuilder: (context) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
        );
      },
    );
  }
}
