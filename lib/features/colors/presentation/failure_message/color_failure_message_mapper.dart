import 'package:abc123/features/colors/domain/failure/color_failure.dart';

/// [ColorFailure]'ı kullanıcı dostu mesaja dönüştürür (`01_project_structure.md`).
abstract final class ColorFailureMessageMapper {
  static String toMessage(ColorFailure failure) {
    return switch (failure) {
      ColorGameLoadFailed() => 'Oyun yüklenemedi. Lütfen tekrar deneyin.',
      ColorPaletteFetchFailed() => 'Renk paleti alınamadı.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
