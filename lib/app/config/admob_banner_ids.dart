import 'package:flutter/foundation.dart';

/// Banner [adUnitId] değerleri (`ADMOB_BANNER_ANDROID` / `ADMOB_BANNER_IOS`).
///
/// iOS için AdMob konsolunda ayrı reklam birimi oluşturup `ADMOB_BANNER_IOS` ile
/// verin veya [defaultIos] sabitini güncelleyin.
class AdmobBannerIds {
  AdmobBannerIds._();

  static const String defaultAndroid = 'ca-app-pub-1254894147284178/4586935049';

  /// iOS Abc123 — AdMob `bannerads_ios` birimi.
  static const String defaultIos = 'ca-app-pub-1254894147284178/6411445421';

  static const String _android = String.fromEnvironment(
    'ADMOB_BANNER_ANDROID',
    defaultValue: defaultAndroid,
  );
  static const String _ios = String.fromEnvironment(
    'ADMOB_BANNER_IOS',
    defaultValue: defaultIos,
  );

  static String get current {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return _ios;
      case TargetPlatform.android:
        return _android;
      default:
        return _android;
    }
  }
}
