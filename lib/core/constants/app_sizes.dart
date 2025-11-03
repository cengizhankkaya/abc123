import 'package:flutter/widgets.dart';
import '../utils/screen_util.dart';

class AppSizes {
  static double paddingNormal(BuildContext context) =>
      ScreenUtil.w(16).clamp(8, 32);
  static double paddingSmall(BuildContext context) =>
      ScreenUtil.w(8).clamp(4, 20);
  static double paddingLarge(BuildContext context) =>
      ScreenUtil.w(24).clamp(12, 48);

  static double imageSize(BuildContext context) =>
      ScreenUtil.w(100).clamp(60, 180);

  static double drawingAreaSize(BuildContext context) =>
      ScreenUtil.w(300).clamp(180, 400);

  static double sliderWidth(BuildContext context) =>
      ScreenUtil.w(70).clamp(30, 150);
  static double sliderHeight(BuildContext context) =>
      ScreenUtil.h(10).clamp(6, 20);

  // Action bar'a özel boyutlar
  static double actionBarHeight(BuildContext context) =>
      ScreenUtil.w(48).clamp(40, 64);
  static double actionBarButtonFontSize(BuildContext context) =>
      ScreenUtil.sp(16).clamp(14, 20);
  static double actionBarButtonIconSize(BuildContext context) =>
      ScreenUtil.w(22).clamp(18, 28);
  static double actionBarButtonHPadding(BuildContext context) =>
      ScreenUtil.w(12).clamp(8, 20);
  static double actionBarButtonVPadding(BuildContext context) =>
      ScreenUtil.h(7).clamp(4, 14);
}
