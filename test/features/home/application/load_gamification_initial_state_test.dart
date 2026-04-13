@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/application/usecases/load_gamification_initial_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_helpers.dart';
import '../../../helpers/test_data.dart';

void main() {
  setUpAll(registerMockFallbackValues);

  group('LoadGamificationInitialState', () {
    late MockGamificationPersistence mockPersistence;
    late LoadGamificationInitialState useCase;

    setUp(() {
      mockPersistence = MockGamificationPersistence();
      useCase = LoadGamificationInitialState(mockPersistence);
    });

    test('kalıcılık değerlerini GamificationInitialState olarak birleştirir',
        () async {
      final d = GamificationTestData.initialStateDefaults;
      when(() => mockPersistence.getInt(GamificationConstants.keyPoints))
          .thenAnswer((_) async => d.points);
      when(() => mockPersistence.getInt(GamificationConstants.keyStreak))
          .thenAnswer((_) async => d.streak);
      when(() => mockPersistence.getInt(GamificationConstants.keyTotalDrawings))
          .thenAnswer((_) async => d.totalDrawings);
      when(
              () => mockPersistence.getInt(GamificationConstants.keyNumberDrawings))
          .thenAnswer((_) async => d.numberDrawings);
      when(
              () => mockPersistence.getInt(GamificationConstants.keyLetterDrawings))
          .thenAnswer((_) async => d.letterDrawings);
      when(
              () => mockPersistence.getInt(GamificationConstants.keyShapeDrawings))
          .thenAnswer((_) async => d.shapeDrawings);
      when(() => mockPersistence
              .getStringList(GamificationConstants.keyUnlockedBadges))
          .thenAnswer((_) async => d.unlockedBadgeIds);
      when(() => mockPersistence.getStringList(GamificationConstants.keyOwnedItems))
          .thenAnswer((_) async => d.ownedItemIds);
      when(() => mockPersistence.getString(GamificationConstants.keyEquippedItems))
          .thenAnswer((_) async => d.equippedItemsJson);

      final result = await useCase.call();

      expect(result.isRight(), isTrue);
      final state =
          result.fold((_) => throw StateError('Right beklenir'), (s) => s);
      expect(state.points, d.points);
      expect(state.streak, d.streak);
      expect(state.totalDrawings, d.totalDrawings);
      expect(state.unlockedBadgeIds, d.unlockedBadgeIds);
      expect(state.equippedItemsJson, d.equippedItemsJson);
    });

    test('null sayısal alanlarda varsayılan sıfır ve boş listeler kullanılır',
        () async {
      when(() => mockPersistence.getInt(any())).thenAnswer((_) async => null);
      when(() => mockPersistence.getStringList(any()))
          .thenAnswer((_) async => null);
      when(() => mockPersistence.getString(any()))
          .thenAnswer((_) async => null);

      final result = await useCase.call();

      expect(result.isRight(), isTrue);
      final state =
          result.fold((_) => throw StateError('Right beklenir'), (s) => s);
      expect(state.points, 0);
      expect(state.streak, 0);
      expect(state.totalDrawings, 0);
      expect(state.unlockedBadgeIds, isEmpty);
      expect(state.ownedItemIds, isEmpty);
      expect(state.equippedItemsJson, isNull);
    });
  });
}
