import 'package:abc123/features/info/domain/failure/info_failure.dart';

/// [InfoFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class InfoFailureMessageMapper {
  static String toMessage(InfoFailure failure) {
    return switch (failure) {
      InfoDataLoadFailed() => 'Bilgi yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
