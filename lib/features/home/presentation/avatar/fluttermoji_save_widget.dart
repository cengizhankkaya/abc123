import 'package:abc123/features/home/presentation/avatar/fluttermoji_controller.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Kaydet butonu — FluttermojiController.setFluttermoji() çağırır.
///
/// GetX kaldırıldı — context.read<FluttermojiController>() ile erişim sağlanıyor.
class FluttermojiSaveWidget extends StatelessWidget {
  FluttermojiSaveWidget({
    super.key,
    FluttermojiThemeData? theme,
    this.onTap,
    this.child,
    this.splashFactory,
    this.splashColor,
    this.radius,
  }) : theme = theme ?? FluttermojiThemeData.standard;
  final FluttermojiThemeData theme;
  final Function? onTap;
  final Widget? child;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color? splashColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.read<FluttermojiController>().setFluttermoji();
        if (onTap != null) onTap!();
      },
      splashFactory: splashFactory,
      radius: radius,
      splashColor: splashColor,
      child: child ??
          Icon(
            Icons.save,
            color: theme.iconColor,
          ),
    );
  }
}
