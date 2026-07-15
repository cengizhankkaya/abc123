import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/draw/domain/failure/draw_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [DrawFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class DrawFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is DrawFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as DrawFailure);
  }

  static String toMessage(DrawFailure failure) {
    return switch (failure) {
      DrawRecognitionFailed() => 'Çizim tanıma başarısız oldu.',
      DrawExportFailed() => 'Çizim kaydedilemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
