import 'package:abc123/features/home/domain/failure/home_failure.dart';

/// [HomeFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class HomeFailureMessageMapper {
  static String toMessage(HomeFailure failure) {
    return switch (failure) {
      HomeQuestLoadFailed() => 'Görevler yüklenemedi.',
      HomeBadgeFetchFailed() => 'Rozetler alınamadı.',
      HomeShopLoadFailed() => 'Mağaza yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
