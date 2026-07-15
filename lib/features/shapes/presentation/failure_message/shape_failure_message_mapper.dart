import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/shapes/domain/failure/shape_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [ShapeFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class ShapeFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is ShapeFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as ShapeFailure);
  }

  static String toMessage(ShapeFailure failure) {
    return switch (failure) {
      ShapeRecognitionFailed() => 'Şekil tanıma başarısız oldu.',
      ShapeShapeSetLoadFailed() => 'Şekil seti yüklenemedi.',
    };
  }
}
