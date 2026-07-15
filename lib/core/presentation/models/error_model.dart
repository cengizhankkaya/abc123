import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/error/failures/technical_failure.dart';
import 'package:abc123/core/presentation/services/failure_message_service.dart';
import 'package:flutter/widgets.dart';

/// Domain/Infrastructure [Failure] nesnelerini UI (BLoC boundary) tarafında sarmalayan model (`08_error_handling.md`, `06_presentation_layer.md`).
///
/// BLoC state'lerinde doğrudan [Failure] tutulmaz; bunun yerine [ErrorModel.fromFailure] kullanılır.
class ErrorModel {
  const ErrorModel({required this.failure});

  factory ErrorModel.fromFailure(Failure failure) => ErrorModel(failure: failure);

  final Failure failure;

  /// Hatanın yeniden denenebilir olup olmadığı.
  bool get isRetryable => failure is TechnicalFailure && (failure as TechnicalFailure).isRetryable;

  /// [FailureMessageService] üzerinden lokalize edilmiş kullanıcı dostu hata mesajını döndürür.
  String getMessage(BuildContext context, FailureMessageService messageService) {
    return messageService.getLocalizedMessage(context, failure);
  }
}
