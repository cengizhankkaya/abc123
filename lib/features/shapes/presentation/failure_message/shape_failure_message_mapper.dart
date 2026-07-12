import 'package:abc123/features/shapes/domain/failure/shape_failure.dart';

/// [ShapeFailure]'ı kullanıcı dostu mesaja dönüştürür.
abstract final class ShapeFailureMessageMapper {
  static String toMessage(ShapeFailure failure) {
    return switch (failure) {
      ShapeRecognitionFailed() => 'Şekil tanıma başarısız oldu.',
      ShapeShapeSetLoadFailed() => 'Şekil seti yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
