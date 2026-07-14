import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/features/home/infrastructure/repositories/gamification_repository_impl.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GamificationFailureMapper implements FailureMapper {

  GamificationFailureMapper(
    this._defaultMapper,
  );
  final FailureMapper _defaultMapper;

  @override
  Failure mapExceptionToFailure(Exception exception) {
    // SharedPreferences işlemleri sırasında fırlatılabilecek özel exception'ları yakalar
    // ve Gamification modülüne özgü StorageFailure'a dönüştürür.
    // Şimdilik her türlü exception'ı StorageFailure olarak değerlendiriyoruz,
    // ancak spesifik Exception kontrolü yapılabilir.
    
    // Fallback to default mapper if it's a ServerException/NetworkException etc.
    final defaultFailure = _defaultMapper.mapExceptionToFailure(exception);
    if (defaultFailure is UnexpectedFailure) {
      return const StorageFailure();
    }
    return defaultFailure;
  }
}
