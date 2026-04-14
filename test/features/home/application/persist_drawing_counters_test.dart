@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/application/usecases/persist_drawing_counters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_helpers.dart';
import '../../../helpers/test_data.dart';

void main() {
  setUpAll(registerMockFallbackValues);

  group('PersistDrawingCounters', () {
    late MockGamificationPersistence mockPersistence;
    late PersistDrawingCounters useCase;

    setUp(() {
      mockPersistence = MockGamificationPersistence();
      useCase = PersistDrawingCounters(mockPersistence);
      when(() => mockPersistence.setInt(any(), any()))
          .thenAnswer((_) async {});
    });

    test('tüm sayaç anahtarlarına doğru değerleri yazar', () async {
      final input = GamificationTestData.sampleCountersWrite;

      final result = await useCase.call(input);

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => unit, (r) => r), unit);
      verify(
        () => mockPersistence.setInt(
          GamificationConstants.keyTotalDrawings,
          input.totalDrawings,
        ),
      ).called(1);
      verify(
        () => mockPersistence.setInt(
          GamificationConstants.keyNumberDrawings,
          input.numberDrawings,
        ),
      ).called(1);
      verify(
        () => mockPersistence.setInt(
          GamificationConstants.keyLetterDrawings,
          input.letterDrawings,
        ),
      ).called(1);
      verify(
        () => mockPersistence.setInt(
          GamificationConstants.keyShapeDrawings,
          input.shapeDrawings,
        ),
      ).called(1);
      verify(
        () => mockPersistence.setInt(
          GamificationConstants.keyColorRounds,
          input.colorRounds,
        ),
      ).called(1);
    });

    test('kalıcılık hata fırlatırsa Left döner', () async {
      when(() => mockPersistence.setInt(any(), any()))
          .thenThrow(Exception('disk dolu'));

      final result = await useCase.call(GamificationTestData.sampleCountersWrite);

      expect(result.isLeft(), isTrue);
    });
  });
}
