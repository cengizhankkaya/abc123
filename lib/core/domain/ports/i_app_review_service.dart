abstract class IAppReviewService {
  /// Oyun başarıyla tamamlandığında çağrılır. 
  /// Sayacı artırır ve gerekiyorsa mağaza değerlendirme penceresini (in-app review) gösterir.
  Future<void> requestReviewIfNeeded();
}
