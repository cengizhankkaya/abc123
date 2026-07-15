import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/numbers_advanced/domain/failure/math_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [MathFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class MathFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is MathFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as MathFailure);
  }

  static String toMessage(MathFailure failure) {
    return switch (failure) {
      MathProgressSaveFailed() => 'İlerleme kaydedilemedi.',
      MathExerciseLoadFailed() => 'Alıştırma yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
