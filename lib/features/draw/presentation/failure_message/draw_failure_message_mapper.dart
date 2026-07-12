import 'package:abc123/features/draw/domain/failure/draw_failure.dart';

/// [DrawFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class DrawFailureMessageMapper {
  static String toMessage(DrawFailure failure) {
    return switch (failure) {
      DrawRecognitionFailed() => 'Çizim tanıma başarısız oldu.',
      DrawExportFailed() => 'Çizim kaydedilemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
