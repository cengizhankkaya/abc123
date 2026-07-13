/// Ödüllü reklam servisi için domain portu.
///
/// Presentation katmanı bu interface üzerinden reklam işlemlerini çağırır;
/// somut implementasyon [AdService] (`core/infrastructure/ads/ad_service.dart`).
abstract interface class IAdService {
  /// Reklam SDK'sını başlatır ve ilk yüklemeyi tetikler.
  void initialize();

  /// Yeni bir ödüllü reklam yükler.
  void loadRewardedAd();

  /// Ödüllü reklamı gösterir.
  ///
  /// [onReward]: Kullanıcı ödülü kazandığında çağrılır.
  /// [onAdNotReady]: Reklam hazır değilse çağrılır (isteğe bağlı).
  void showRewardedAd({
    required void Function(int rewardAmount) onReward,
    void Function()? onAdNotReady,
  });
}
