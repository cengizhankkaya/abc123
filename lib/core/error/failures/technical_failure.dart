import 'package:abc123/core/error/failures/failure.dart';

/// Altyapı ve teknik hatalar için taban arayüz (`08_error_handling.md`).
///
/// Bu sınıftan türeyen tüm teknik hatalar (sunucu, ağ, önbellek, ayrıştırma vb.)
/// yeniden denenebilir olup olmadığını ([isRetryable]) ve hata yığın izini ([stackTrace]) tanımlar.
abstract class TechnicalFailure extends Failure {
  const TechnicalFailure();

  /// Bu hatanın yeniden denenmeye (`retry`) uygun olup olmadığını belirtir.
  bool get isRetryable;

  /// Hatanın ayıklanması amacıyla orijinal yığın izi (`StackTrace`).
  StackTrace? get stackTrace;
}
