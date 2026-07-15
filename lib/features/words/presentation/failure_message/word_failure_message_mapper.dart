import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/words/domain/failure/word_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WordFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class WordFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is WordFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as WordFailure);
  }

  static String toMessage(WordFailure failure) {
    return switch (failure) {
      WordWordListLoadFailed() => 'Kelime listesi yüklenemedi.',
      WordRecognitionFailed() => 'Yazı tanıma başarısız oldu.',
    };
  }
}
