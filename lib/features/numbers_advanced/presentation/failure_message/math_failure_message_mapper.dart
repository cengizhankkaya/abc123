import 'package:abc123/features/numbers_advanced/domain/failure/math_failure.dart';

/// [MathFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class MathFailureMessageMapper {
  static String toMessage(MathFailure failure) {
    return switch (failure) {
      MathProgressSaveFailed() => 'İlerleme kaydedilemedi.',
      MathExerciseLoadFailed() => 'Alıştırma yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
