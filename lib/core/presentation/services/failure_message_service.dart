import 'package:abc123/core/error/failures/cache_failure.dart';
import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/network_failure.dart';
import 'package:abc123/core/error/failures/server_failure.dart';
import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// Tüm modül hata dönüştürücülerini barındıran ve UI'a lokalize hata mesajı sunan servis (`08_error_handling.md`).
@lazySingleton
class FailureMessageService {
  FailureMessageService(this._mappers);

  final List<FailureMessageMapper> _mappers;

  /// Verilen [failure] için uygun [FailureMessageMapper]'ı bulur ve mesajı döndürür.
  ///
  /// Eşleşen modül mapper'ı yoksa altyapı/teknik hatalar için varsayılan mesajlara düşer.
  String getLocalizedMessage(BuildContext context, Failure failure) {
    for (final mapper in _mappers) {
      if (mapper.canHandle(failure)) {
        return mapper.map(context, failure);
      }
    }

    if (failure is NetworkFailure) {
      return 'İnternet bağlantınızı kontrol edin ve tekrar deneyin.';
    } else if (failure is ServerFailure) {
      return 'Sunucuyla iletişim kurulurken bir sorun oluştu (Kod: ${failure.statusCode}).';
    } else if (failure is CacheFailure) {
      return 'Veriler kaydedilirken veya okunurken bir sorun oluştu.';
    } else if (failure is UnexpectedFailure) {
      return 'Beklenmeyen bir hata oluştu: ${failure.message}';
    }

    return failure.toString();
  }
}
