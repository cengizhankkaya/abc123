import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/info/domain/failure/info_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [InfoFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class InfoFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is InfoFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as InfoFailure);
  }

  static String toMessage(InfoFailure failure) {
    return switch (failure) {
      InfoDataLoadFailed() => 'Bilgi yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
