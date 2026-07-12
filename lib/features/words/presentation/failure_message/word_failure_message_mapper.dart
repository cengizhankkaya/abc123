import 'package:abc123/features/words/domain/failure/word_failure.dart';

/// [WordFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class WordFailureMessageMapper {
  static String toMessage(WordFailure failure) {
    return switch (failure) {
      WordWordListLoadFailed() => 'Kelime listesi yüklenemedi.',
      WordRecognitionFailed() => 'Yazı tanıma başarısız oldu.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
