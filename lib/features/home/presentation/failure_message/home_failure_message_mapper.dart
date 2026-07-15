import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/home/domain/failure/home_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [HomeFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`).
@lazySingleton
class HomeFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is HomeFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(failure as HomeFailure);
  }

  static String toMessage(HomeFailure failure) {
    return switch (failure) {
      HomeQuestLoadFailed() => 'Görevler yüklenemedi.',
      HomeBadgeFetchFailed() => 'Rozetler alınamadı.',
      HomeShopLoadFailed() => 'Mağaza yüklenemedi.',
      _ => 'Beklenmeyen bir hata oluştu.',
    };
  }
}
