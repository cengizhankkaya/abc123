import 'package:abc123/core/presentation/services/failure_message_mapper.dart';
import 'package:abc123/features/colors/presentation/failure_message/color_failure_message_mapper.dart';
import 'package:abc123/features/draw/presentation/failure_message/draw_failure_message_mapper.dart';
import 'package:abc123/features/home/presentation/failure_message/home_failure_message_mapper.dart';
import 'package:abc123/features/info/presentation/failure_message/info_failure_message_mapper.dart';
import 'package:abc123/features/letters/presentation/failure_message/letter_failure_message_mapper.dart';
import 'package:abc123/features/numbers_advanced/presentation/failure_message/math_failure_message_mapper.dart';
import 'package:abc123/features/parent_panel/presentation/failure_message/parent_panel_failure_message_mapper.dart';
import 'package:abc123/features/shapes/presentation/failure_message/shape_failure_message_mapper.dart';
import 'package:abc123/features/words/presentation/failure_message/word_failure_message_mapper.dart';
import 'package:injectable/injectable.dart';

/// Hata mesajı dönüştürücülerini (mappers) bir liste olarak sağlayan DI modülü (`08_error_handling.md`, `09_dependency_injection.md`).
@module
abstract class FailureMappersModule {
  @lazySingleton
  List<FailureMessageMapper> provideFailureMessageMappers(
    MathFailureMessageMapper mathMapper,
    InfoFailureMessageMapper infoMapper,
    ColorFailureMessageMapper colorMapper,
    DrawFailureMessageMapper drawMapper,
    LetterFailureMessageMapper letterMapper,
    ShapeFailureMessageMapper shapeMapper,
    ParentPanelFailureMessageMapper parentPanelMapper,
    HomeFailureMessageMapper homeMapper,
    WordFailureMessageMapper wordMapper,
  ) =>
      [
        mathMapper,
        infoMapper,
        colorMapper,
        drawMapper,
        letterMapper,
        shapeMapper,
        parentPanelMapper,
        homeMapper,
        wordMapper,
      ];
}
