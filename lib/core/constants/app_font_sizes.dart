import 'package:flutter/widgets.dart';

import 'package:abc123/core/presentation/responsive/screen_size.dart';

ScreenSize _screenSize(BuildContext context) =>
    ScreenSize.fromWidth(MediaQuery.sizeOf(context).width);

class AppFontSizes {
  static double title(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 22,
      ScreenSize.medium => 24,
      ScreenSize.expanded => 26,
      ScreenSize.large => 28,
      ScreenSize.extraLarge => 30,
    };
  }

  static double subtitle(BuildContext context) {
    return switch (_screenSize(context)) {
      ScreenSize.compact => 16,
      ScreenSize.medium => 17,
      ScreenSize.expanded => 18,
      ScreenSize.large => 19,
      ScreenSize.extraLarge => 20,
    };
  }
}
