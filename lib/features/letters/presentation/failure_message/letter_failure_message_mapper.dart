import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/letters/domain/failure/letter_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [LetterFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class LetterFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is LetterFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as LetterFailure);
  }

  static String toMessage(LetterFailure failure) {
    return switch (failure) {
      LetterRecognitionFailed() => 'Harf tanıma başarısız oldu.',
      LetterLetterSetLoadFailed() => 'Harf seti yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
