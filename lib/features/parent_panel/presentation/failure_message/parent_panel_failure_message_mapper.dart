import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/parent_panel/domain/failure/parent_panel_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [ParentPanelFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class ParentPanelFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is ParentPanelFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as ParentPanelFailure);
  }

  static String toMessage(ParentPanelFailure failure) {
    return switch (failure) {
      ParentPanelAuthFailed() => 'Ebeveyn doğrulaması başarısız.',
      ParentPanelProgressLoadFailed() => 'İlerleme verileri yüklenemedi.',
      ParentPanelScreenTimeSaveFailed() => 'Ekran süresi ayarları kaydedilemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
