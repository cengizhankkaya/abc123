/// Remote Config servisi için port (arayüz) tanımı.
///
/// Firebase Remote Config'i soyutlar; test ortamlarında mock ile değiştirilebilir.
abstract interface class IRemoteConfigService {
  /// Remote Config değerlerini sunucudan çekip aktive eder.
  Future<void> fetchAndActivate();

  /// `minimum_build_number` parametresini döndürür.
  ///
  /// Uygulamanın mevcut build numarası bu değerden küçükse güncelleme zorunludur.
  int get minimumBuildNumber;

  /// `optional_build_number` parametresini döndürür.
  ///
  /// Uygulamanın mevcut build numarası bu değerden küçükse opsiyonel
  /// güncelleme ekranı gösterilir (kullanıcı kapatabilir).
  int get optionalBuildNumber;

  /// `whats_new` parametresini döndürür.
  ///
  /// Opsiyonel güncelleme ekranında gösterilecek "Yenilikler" metni.
  /// Remote Config'den dinamik olarak güncellenir.
  String get whatsNew;
}
