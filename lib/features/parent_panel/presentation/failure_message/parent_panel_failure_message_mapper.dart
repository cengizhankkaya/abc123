import 'package:abc123/features/parent_panel/domain/failure/parent_panel_failure.dart';

/// [ParentPanelFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class ParentPanelFailureMessageMapper {
  static String toMessage(ParentPanelFailure failure) {
    return switch (failure) {
      ParentPanelAuthFailed() => 'Ebeveyn doğrulaması başarısız.',
      ParentPanelProgressLoadFailed() => 'İlerleme verileri yüklenemedi.',
      ParentPanelScreenTimeSaveFailed() => 'Ekran süresi ayarları kaydedilemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
