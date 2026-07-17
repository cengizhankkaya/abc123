import 'package:abc123/core/error/failures/failure.dart';
import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/colors/domain/failure/color_failure.dart';
import 'package:abc123/features/colors/l10n/l10n_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [ColorFailure]'ı kullanıcı dostu mesaja dönüştürür (`08_error_handling.md`, `01_project_structure.md`).
@lazySingleton
class ColorFailureMessageMapper implements FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is ColorFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return toMessage(context, failure as ColorFailure);
  }

  static String toMessage(BuildContext context, ColorFailure failure) {
    final l10n = context.colorsL10n;
    return switch (failure) {
      ColorGameLoadFailed() => l10n.colorFailureLoad,
      ColorPaletteFetchFailed() => l10n.colorFailurePalette,
    };
  }
}
