import 'dart:io';

/// Ödüllü reklam [adUnitId] (`ADMOB_REWARDED_ANDROID` / `ADMOB_REWARDED_IOS`).
class AdmobRewardedIds {
  AdmobRewardedIds._();

  static const String defaultAndroid = 'ca-app-pub-1254894147284178/7964725662';
  /// iOS Abc123 — AdMob `childodul_ios` birimi.
  static const String defaultIos = 'ca-app-pub-1254894147284178/7045870245';

  static const String _android = String.fromEnvironment(
    'ADMOB_REWARDED_ANDROID',
    defaultValue: defaultAndroid,
  );
  static const String _ios = String.fromEnvironment(
    'ADMOB_REWARDED_IOS',
    defaultValue: defaultIos,
  );

  static String get current {
    if (Platform.isAndroid) {
      return _android;
    }
    if (Platform.isIOS) {
      return _ios;
    }
    return _android;
  }
}
