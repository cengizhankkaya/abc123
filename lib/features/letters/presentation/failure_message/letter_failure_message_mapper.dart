import 'package:abc123/features/letters/domain/failure/letter_failure.dart';

/// [LetterFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class LetterFailureMessageMapper {
  static String toMessage(LetterFailure failure) {
    return switch (failure) {
      LetterRecognitionFailed() => 'Harf tanıma başarısız oldu.',
      LetterLetterSetLoadFailed() => 'Harf seti yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
