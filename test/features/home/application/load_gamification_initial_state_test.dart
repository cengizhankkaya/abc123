@TestOn('vm')
library;

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/application/usecases/load_gamification_initial_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
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
      const d = GamificationTestData.initialStateDefaults;
      when(() => mockPersistence.getInt(GamificationConstants.keyPoints))
          .thenAnswer((_) async => right(d.points));
      when(() => mockPersistence.getInt(GamificationConstants.keyStreak))
          .thenAnswer((_) async => right(d.streak));
      when(() => mockPersistence.getInt(GamificationConstants.keyTotalDrawings))
          .thenAnswer((_) async => right(d.totalDrawings));
      when(
              () => mockPersistence.getInt(GamificationConstants.keyNumberDrawings),)
          .thenAnswer((_) async => right(d.numberDrawings));
      when(
              () => mockPersistence.getInt(GamificationConstants.keyLetterDrawings),)
          .thenAnswer((_) async => right(d.letterDrawings));
      when(
              () => mockPersistence.getInt(GamificationConstants.keyShapeDrawings),)
          .thenAnswer((_) async => right(d.shapeDrawings));
      when(() => mockPersistence.getInt(GamificationConstants.keyColorRounds))
          .thenAnswer((_) async => right(d.colorRounds));
      when(() => mockPersistence.getInt(GamificationConstants.keyWordsCompleted))
          .thenAnswer((_) async => right(d.wordsCompleted));
      when(() => mockPersistence
              .getStringList(GamificationConstants.keyUnlockedBadges),)
          .thenAnswer((_) async => right(d.unlockedBadgeIds));
      when(() => mockPersistence.getStringList(GamificationConstants.keyOwnedItems))
          .thenAnswer((_) async => right(d.ownedItemIds));
      when(() => mockPersistence.getString(GamificationConstants.keyEquippedItems))
          .thenAnswer((_) async => right(d.equippedItemsJson));
      when(() => mockPersistence.getString(GamificationConstants.keyQuestsLedger))
          .thenAnswer((_) async => right(d.questsLedgerJson));

      final result = await useCase.call();

      expect(result.isRight(), isTrue);
      final state =
          result.fold((_) => throw StateError('Right beklenir'), (s) => s);
      expect(state.points, d.points);
      expect(state.streak, d.streak);
      expect(state.totalDrawings, d.totalDrawings);
      expect(state.unlockedBadgeIds, d.unlockedBadgeIds);
      expect(state.colorRounds, d.colorRounds);
      expect(state.wordsCompleted, d.wordsCompleted);
      expect(state.equippedItemsJson, d.equippedItemsJson);
      expect(state.questsLedgerJson, d.questsLedgerJson);
    });

    test('null sayısal alanlarda varsayılan sıfır ve boş listeler kullanılır',
        () async {
      when(() => mockPersistence.getInt(any())).thenAnswer((_) async => right(null));
      when(() => mockPersistence.getStringList(any()))
          .thenAnswer((_) async => right(null));
      when(() => mockPersistence.getString(any()))
          .thenAnswer((_) async => right(null));

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
