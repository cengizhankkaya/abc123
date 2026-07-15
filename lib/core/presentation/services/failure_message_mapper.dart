import 'package:abc123/core/error/failures/failure.dart';
import 'package:flutter/widgets.dart';

/// Modül bazlı hata mesajı dönüştürücüleri için taban arayüz (`08_error_handling.md`).
///
/// Her modül kendi domain failure tipini yakalayıp kullanıcı dostu mesaja çeviren
/// bir [FailureMessageMapper] uygular ve `@lazySingleton (as: FailureMessageMapper)`
/// ile bağımlılık enjeksiyonuna kayıt olur.
abstract class FailureMessageMapper {
  /// Bu dönüştürücünün verilen [failure] nesnesini işleyip işleyemeyeceği.
  bool canHandle(Failure failure);

  /// Hata mesajını (varsa [context] desteğiyle) lokalize olarak döndürür.
  String map(BuildContext context, Failure failure);
}
