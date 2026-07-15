import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/colors/domain/failure/color_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [ColorFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`, `01_project_structure.md`).
@lazySingleton
class ColorFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is ColorFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as ColorFailure);
  }

  static String toMessage(ColorFailure failure) {
    return switch (failure) {
      ColorGameLoadFailed() => 'Oyun yüklenemedi. Lütfen tekrar deneyin.',
      ColorPaletteFetchFailed() => 'Renk paleti alınamadı.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
