/// Uygulama özellik bayrakları (`0013-feature-flags.md`).
enum FeatureFlag {
  /// Ödüllü reklamlar; uzak yapılandırma veya override ile kapatılabilir.
  rewardedAdsEnabled,
}

/// [FeatureFlag] için uzak anahtar, varsayılan ve açıklama.
extension FeatureFlagX on FeatureFlag {
  /// Uzak yapılandırma anahtarı (Firebase Remote Config vb.).
  String get remoteConfigKey => 'feature_$name';

  /// Override ve uzak değer yokken kullanılan varsayılan.
  bool get defaultValue => switch (this) {
        FeatureFlag.rewardedAdsEnabled => true,
      };

  /// Hata ayıklama ve dokümantasyon için kısa açıklama.
  String get description => switch (this) {
        FeatureFlag.rewardedAdsEnabled => 'Ödüllü reklamlar (kill switch)',
      };
}
