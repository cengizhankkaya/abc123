import 'dart:convert';

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/features/home/application/dtos/drawing_counters_write.dart';
import 'package:abc123/features/home/application/dtos/gamification_initial_state.dart';
import 'package:abc123/features/home/application/dtos/quest_ledger.dart';
import 'package:abc123/features/home/application/dtos/quest_ledger_write.dart';
import 'package:abc123/features/home/application/quest/quest_rollover_resolver.dart';
import 'package:abc123/features/home/application/usecases/load_gamification_initial_state.dart';
import 'package:abc123/features/home/application/usecases/persist_drawing_counters.dart';
import 'package:abc123/features/home/application/usecases/persist_quest_ledger.dart';
import 'package:abc123/features/home/domain/entities/badge_model.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
final class GamificationProvider extends ChangeNotifier {
  final IGamificationPersistence _persistence;
  final LoadGamificationInitialState _loadInitial;
  final PersistDrawingCounters _persistDrawingCounters;
  final PersistQuestLedger _persistQuestLedger;
  final QuestRolloverResolver _questRolloverResolver;
  final AppLogger _logger;

  int _points = 0;
  int _streak = 0;
  int _totalDrawings = 0;
  int _numberDrawings = 0;
  int _letterDrawings = 0;
  int _shapeDrawings = 0;
  int _colorRounds = 0;
  List<String> _unlockedBadgeIds = [];
  List<QuestModel> _quests = [];
  QuestLedger? _questLedger;
  int _questRolloverGeneration = 0;

  /// Sıfırdan büyük olduğunda görev dönemi yenilenmiştir (UI geri bildirimi).
  int get questRolloverGeneration => _questRolloverGeneration;

  // Shop State
  List<String> _ownedItemIds = [];
  Map<String, String> _equippedItems = {}; // { 'hat': 'item_id', 'glasses': 'item_id' }

  List<QuestModel> get quests => _quests;
  List<String> get ownedItemIds => _ownedItemIds;
  Map<String, String> get equippedItems => _equippedItems;

  // Shop Items Catalog (ikon/renk sunumda `gamification_icon_catalog` + ARGB)
  final List<ShopItemModel> _shopItems = [
    ShopItemModel(
      id: 'hat_blue_cap',
      name: 'hat_blue_cap',
      type: ShopItemType.hat,
      price: 50,
      iconKey: 'school',
      colorArgb: 0xFF2196F3,
    ),
    ShopItemModel(
      id: 'hat_crown',
      name: 'hat_crown',
      type: ShopItemType.hat,
      price: 500,
      iconKey: 'emoji_events',
      colorArgb: 0xFFFFC107,
    ),
    ShopItemModel(
      id: 'hat_wizard',
      name: 'hat_wizard',
      type: ShopItemType.hat,
      price: 150,
      iconKey: 'auto_fix_high',
      colorArgb: 0xFF9C27B0,
    ),
    ShopItemModel(
      id: 'hat_flower',
      name: 'hat_flower',
      type: ShopItemType.hat,
      price: 75,
      iconKey: 'local_florist',
      colorArgb: 0xFFE91E63,
    ),
    ShopItemModel(
      id: 'hat_pirate',
      name: 'hat_pirate',
      type: ShopItemType.hat,
      price: 120,
      iconKey: 'explore',
      colorArgb: 0xFF000000,
    ),
    ShopItemModel(
      id: 'hat_chef',
      name: 'hat_chef',
      type: ShopItemType.hat,
      price: 80,
      iconKey: 'restaurant_menu',
      colorArgb: 0xFFFFFFFF,
    ),
    ShopItemModel(
      id: 'glasses_sun',
      name: 'glasses_sun',
      type: ShopItemType.glasses,
      price: 100,
      iconKey: 'visibility',
      colorArgb: 0xFF000000,
    ),
    ShopItemModel(
      id: 'glasses_nerd',
      name: 'glasses_nerd',
      type: ShopItemType.glasses,
      price: 75,
      iconKey: 'remove_red_eye',
      colorArgb: 0xFF795548,
    ),
    ShopItemModel(
      id: 'glasses_heart',
      name: 'glasses_heart',
      type: ShopItemType.glasses,
      price: 125,
      iconKey: 'favorite',
      colorArgb: 0xFFFF5252,
    ),
    ShopItemModel(
      id: 'glasses_3d',
      name: 'glasses_3d',
      type: ShopItemType.glasses,
      price: 150,
      iconKey: 'videogame_asset',
      colorArgb: 0xFF00BCD4,
    ),
    ShopItemModel(
      id: 'glasses_vr',
      name: 'glasses_vr',
      type: ShopItemType.glasses,
      price: 300,
      iconKey: 'vrpano',
      colorArgb: 0xFF9E9E9E,
    ),
    ShopItemModel(
      id: 'glasses_ski',
      name: 'glasses_ski',
      type: ShopItemType.glasses,
      price: 180,
      iconKey: 'downhill_skiing',
      colorArgb: 0xFFFFFFFF,
    ),
    ShopItemModel(
      id: 'glasses_mask',
      name: 'glasses_mask',
      type: ShopItemType.glasses,
      price: 50,
      iconKey: 'masks',
      colorArgb: 0xFF9C27B0,
    ),
    ShopItemModel(
      id: 'glasses_reading',
      name: 'glasses_reading',
      type: ShopItemType.glasses,
      price: 60,
      iconKey: 'menu_book',
      colorArgb: 0xFF009688,
    ),
    ShopItemModel(
      id: 'outfit_red',
      name: 'outfit_red',
      type: ShopItemType.outfit,
      price: 200,
      iconKey: 'checkroom',
      colorArgb: 0xFFF44336,
    ),
    ShopItemModel(
      id: 'outfit_super',
      name: 'outfit_super',
      type: ShopItemType.outfit,
      price: 1000,
      iconKey: 'shield',
      colorArgb: 0xFF448AFF,
    ),
    ShopItemModel(
      id: 'outfit_green',
      name: 'outfit_green',
      type: ShopItemType.outfit,
      price: 250,
      iconKey: 'forest',
      colorArgb: 0xFF4CAF50,
    ),
    ShopItemModel(
      id: 'outfit_doctor',
      name: 'outfit_doctor',
      type: ShopItemType.outfit,
      price: 400,
      iconKey: 'medical_services',
      colorArgb: 0xFFFFFFFF,
    ),
    ShopItemModel(
      id: 'outfit_space',
      name: 'outfit_space',
      type: ShopItemType.outfit,
      price: 800,
      iconKey: 'rocket_launch',
      colorArgb: 0xFFFF9800,
    ),
    ShopItemModel(
      id: 'outfit_sports',
      name: 'outfit_sports',
      type: ShopItemType.outfit,
      price: 220,
      iconKey: 'sports_soccer',
      colorArgb: 0xFFFF5252,
    ),
    ShopItemModel(
      id: 'outfit_police',
      name: 'outfit_police',
      type: ShopItemType.outfit,
      price: 350,
      iconKey: 'local_police',
      colorArgb: 0xFF2196F3,
    ),
    ShopItemModel(
      id: 'outfit_chef',
      name: 'outfit_chef',
      type: ShopItemType.outfit,
      price: 280,
      iconKey: 'restaurant',
      colorArgb: 0xFFFFFFFF,
    ),
    ShopItemModel(
      id: 'outfit_winter',
      name: 'outfit_winter',
      type: ShopItemType.outfit,
      price: 300,
      iconKey: 'ac_unit',
      colorArgb: 0xFF03A9F4,
    ),
    ShopItemModel(
      id: 'outfit_tuxedo',
      name: 'outfit_tuxedo',
      type: ShopItemType.outfit,
      price: 600,
      iconKey: 'person',
      colorArgb: 0xFF000000,
    ),
  ];

  List<ShopItemModel> get shopItems => _shopItems;

  // In-memory list of all available badges
  List<BadgeModel> _badges = [
    BadgeModel(
      id: GamificationConstants.badgeFirstLogin,
      nameKey: 'badgeFirstLoginName',
      descriptionKey: 'badgeFirstLoginDesc',
      iconKey: 'login',
    ),
    BadgeModel(
      id: GamificationConstants.badgeFirstDraw,
      nameKey: 'badgeFirstDrawName',
      descriptionKey: 'badgeFirstDrawDesc',
      iconKey: 'edit',
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak3,
      nameKey: 'badgeStreak3Name',
      descriptionKey: 'badgeStreak3Desc',
      iconKey: 'local_fire_department',
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak7,
      nameKey: 'badgeStreak7Name',
      descriptionKey: 'badgeStreak7Desc',
      iconKey: 'stars',
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak30,
      nameKey: 'badgeStreak30Name',
      descriptionKey: 'badgeStreak30Desc',
      iconKey: 'whatshot',
    ),
    BadgeModel(
      id: GamificationConstants.badgeBronzeArtist,
      nameKey: 'badgeBronzeArtistName',
      descriptionKey: 'badgeBronzeArtistDesc',
      iconKey: 'edit_note',
    ),
    BadgeModel(
      id: GamificationConstants.badgeSilverArtist,
      nameKey: 'badgeSilverArtistName',
      descriptionKey: 'badgeSilverArtistDesc',
      iconKey: 'brush',
    ),
    BadgeModel(
      id: GamificationConstants.badgeMasterArtist,
      nameKey: 'badgeMasterArtistName',
      descriptionKey: 'badgeMasterArtistDesc',
      iconKey: 'palette',
    ),
    BadgeModel(
      id: GamificationConstants.badgeGoldArtist,
      nameKey: 'badgeGoldArtistName',
      descriptionKey: 'badgeGoldArtistDesc',
      iconKey: 'color_lens',
    ),
    BadgeModel(
      id: GamificationConstants.badgeDiamondArtist,
      nameKey: 'badgeDiamondArtistName',
      descriptionKey: 'badgeDiamondArtistDesc',
      iconKey: 'diamond',
    ),
    BadgeModel(
      id: GamificationConstants.badgeEarlyBird,
      nameKey: 'badgeEarlyBirdName',
      descriptionKey: 'badgeEarlyBirdDesc',
      iconKey: 'wb_sunny',
    ),
    BadgeModel(
      id: GamificationConstants.badgeNightOwl,
      nameKey: 'badgeNightOwlName',
      descriptionKey: 'badgeNightOwlDesc',
      iconKey: 'nights_stay',
    ),
    BadgeModel(
      id: GamificationConstants.badgeWeekendWarrior,
      nameKey: 'badgeWeekendWarriorName',
      descriptionKey: 'badgeWeekendWarriorDesc',
      iconKey: 'weekend',
    ),
    BadgeModel(
      id: GamificationConstants.badgeNumberMaster,
      nameKey: 'badgeNumberMasterName',
      descriptionKey: 'badgeNumberMasterDesc',
      iconKey: 'looks_one',
    ),
    BadgeModel(
      id: GamificationConstants.badgeLetterMaster,
      nameKey: 'badgeLetterMasterName',
      descriptionKey: 'badgeLetterMasterDesc',
      iconKey: 'abc',
    ),
    BadgeModel(
      id: GamificationConstants.badgeShapeMaster,
      nameKey: 'badgeShapeMasterName',
      descriptionKey: 'badgeShapeMasterDesc',
      iconKey: 'category',
    ),
    BadgeModel(
      id: GamificationConstants.badgeColorMaster,
      nameKey: 'badgeColorMasterName',
      descriptionKey: 'badgeColorMasterDesc',
      iconKey: 'palette',
    ),
    BadgeModel(
      id: GamificationConstants.badgeHighScorer,
      nameKey: 'badgeHighScorerName',
      descriptionKey: 'badgeHighScorerDesc',
      iconKey: 'emoji_events',
    ),
    BadgeModel(
      id: GamificationConstants.badgeScoreLegend,
      nameKey: 'badgeScoreLegendName',
      descriptionKey: 'badgeScoreLegendDesc',
      iconKey: 'military_tech',
    ),
    BadgeModel(
      id: GamificationConstants.badgeBadgeCollector,
      nameKey: 'badgeBadgeCollectorName',
      descriptionKey: 'badgeBadgeCollectorDesc',
      iconKey: 'collections_bookmark',
    ),
    BadgeModel(
      id: GamificationConstants.badgeBadgeMaster,
      nameKey: 'badgeBadgeMasterName',
      descriptionKey: 'badgeBadgeMasterDesc',
      iconKey: 'workspace_premium',
    ),
  ];

  int get points => _points;
  int get streak => _streak;
  int get numberDrawings => _numberDrawings;
  int get letterDrawings => _letterDrawings;
  int get shapeDrawings => _shapeDrawings;
  int get colorRounds => _colorRounds;
  List<BadgeModel> get badges {
    return _badges.map((badge) {
      return badge.copyWith(isLocked: !_unlockedBadgeIds.contains(badge.id));
    }).toList();
  }

  List<BadgeModel> get unlockedBadges {
    return badges.where((b) => !b.isLocked).toList();
  }

  GamificationProvider({
    required IGamificationPersistence persistence,
    required LoadGamificationInitialState loadInitial,
    required PersistDrawingCounters persistDrawingCounters,
    required PersistQuestLedger persistQuestLedger,
    required QuestRolloverResolver questRolloverResolver,
    required AppLogger logger,
  })  : _persistence = persistence,
        _loadInitial = loadInitial,
        _persistDrawingCounters = persistDrawingCounters,
        _persistQuestLedger = persistQuestLedger,
        _questRolloverResolver = questRolloverResolver,
        _logger = logger {
    _init();
  }

  Future<void> _init() async {
    _logger.debug('Gamification init started', tag: 'Gamification');
    GamificationInitialState? loaded;
    final loadResult = await _loadInitial.call();
    loadResult.fold(
      (failure) => _logger.warning(
        'Gamification load failed',
        tag: 'Gamification',
        data: {'failure': failure.toString()},
      ),
      (s) {
        loaded = s;
        _points = s.points;
        _streak = s.streak;
        _totalDrawings = s.totalDrawings;
        _numberDrawings = s.numberDrawings;
        _letterDrawings = s.letterDrawings;
        _shapeDrawings = s.shapeDrawings;
        _colorRounds = s.colorRounds;
        _unlockedBadgeIds = List<String>.from(s.unlockedBadgeIds);
        _ownedItemIds = List<String>.from(s.ownedItemIds);
        if (s.equippedItemsJson != null) {
          final Object? decoded = json.decode(s.equippedItemsJson!);
          if (decoded is Map) {
            _equippedItems = <String, String>{
              for (final MapEntry<Object?, Object?> e in decoded.entries)
                e.key.toString(): e.value?.toString() ?? '',
            };
          } else {
            _equippedItems = {};
          }
        } else {
          _equippedItems = {};
        }
      },
    );

    await _checkStreak();

    final decoded = QuestLedger.tryDecode(loaded?.questsLedgerJson);
    final resolved = _questRolloverResolver.resolve(
      now: DateTime.now(),
      saved: decoded,
    );
    _quests = List<QuestModel>.from(resolved.ledger.quests);
    _questLedger = resolved.ledger;
    if (resolved.didRollover) {
      _questRolloverGeneration++;
    }
    await _persistQuestLedgerSilent();

    notifyListeners();
  }

  void _syncQuestLedgerFromQuests() {
    final cur = _questLedger;
    if (cur == null) return;
    _questLedger = QuestLedger(
      schemaVersion: QuestLedger.currentSchemaVersion,
      dayKey: cur.dayKey,
      weekKey: cur.weekKey,
      quests: List<QuestModel>.from(_quests),
    );
  }

  Future<void> _persistQuestLedgerSilent() async {
    final ledger = _questLedger;
    if (ledger == null) return;
    final r = await _persistQuestLedger.call(
      QuestLedgerWrite(encodedJson: ledger.encode()),
    );
    r.fold(
      (failure) => _logger.error(
        'Persist quest ledger failed',
        tag: 'Gamification',
        error: failure,
        data: {'failure': failure.toString()},
      ),
      (_) {},
    );
  }

  Future<void> _checkStreak() async {
    final lastLoginString = await _persistence.getString(GamificationConstants.keyLastLoginDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastLoginString == null) {
      // First time login
      _streak = 1;
      await _persistence.setString(GamificationConstants.keyLastLoginDate, today.toIso8601String());
      await _persistence.setInt(GamificationConstants.keyStreak, _streak);
      await _unlockBadge(GamificationConstants.badgeFirstLogin);
    } else {
      final lastLogin = DateTime.parse(lastLoginString);
      final lastLoginDate = DateTime(lastLogin.year, lastLogin.month, lastLogin.day);

      if (lastLoginDate.isBefore(today)) {
        if (today.difference(lastLoginDate).inDays == 1) {
          // Consecutive day
          _streak++;
          await _addPoints(GamificationConstants.pointsPerStreakDay);
        } else {
          // Streak broken
          _streak = 1;
        }
        await _persistence.setString(
            GamificationConstants.keyLastLoginDate, today.toIso8601String());
        await _persistence.setInt(GamificationConstants.keyStreak, _streak);

        // Check streak badges
        if (_streak >= 3) {
          await _unlockBadge(GamificationConstants.badgeStreak3);
        }
        if (_streak >= 7) {
          await _unlockBadge(GamificationConstants.badgeStreak7);
        }
        if (_streak >= 30) {
          await _unlockBadge(GamificationConstants.badgeStreak30);
        }
      }
    }

    // Check Time-based Badges
    final hour = now.hour;
    if (hour >= 6 && hour < 10) {
      await _unlockBadge(GamificationConstants.badgeEarlyBird);
    } else if (hour >= 22 || hour < 4) {
      await _unlockBadge(GamificationConstants.badgeNightOwl);
    }

    // Check Weekend Badge
    if (today.weekday == DateTime.saturday || today.weekday == DateTime.sunday) {
      await _unlockBadge(GamificationConstants.badgeWeekendWarrior);
    }
  }

  Future<void> addPoints(int amount) async {
    await _addPoints(amount);
    notifyListeners();
  }

  Future<void> _addPoints(int amount) async {
    _points += amount;
    await _persistence.setInt(GamificationConstants.keyPoints, _points);

    // Check Score Badges
    if (_points >= 1000) {
      await _unlockBadge(GamificationConstants.badgeHighScorer);
    }
    if (_points >= 5000) {
      await _unlockBadge(GamificationConstants.badgeScoreLegend);
    }
  }

  Future<void> incrementTotalDrawings({DrawingType type = DrawingType.any, String? label}) async {
    _totalDrawings++;

    if (type == DrawingType.number) {
      _numberDrawings++;
      if (_numberDrawings >= 50) {
        await _unlockBadge(GamificationConstants.badgeNumberMaster);
      }
    } else if (type == DrawingType.letter) {
      _letterDrawings++;
      if (_letterDrawings >= 50) {
        await _unlockBadge(GamificationConstants.badgeLetterMaster);
      }
    } else if (type == DrawingType.shape) {
      _shapeDrawings++;
      if (_shapeDrawings >= 50) {
        await _unlockBadge(GamificationConstants.badgeShapeMaster);
      }
    }

    final persistResult = await _persistDrawingCounters.call(
      DrawingCountersWrite(
        totalDrawings: _totalDrawings,
        numberDrawings: _numberDrawings,
        letterDrawings: _letterDrawings,
        shapeDrawings: _shapeDrawings,
        colorRounds: _colorRounds,
      ),
    );
    persistResult.fold(
      (failure) => _logger.error(
        'Persist drawing counters failed',
        tag: 'Gamification',
        error: failure,
        data: {'failure': failure.toString()},
      ),
      (_) {},
    );

    await _unlockBadge(GamificationConstants.badgeFirstDraw);
    if (_totalDrawings >= 10) {
      await _unlockBadge(GamificationConstants.badgeBronzeArtist);
    }
    if (_totalDrawings >= 50) {
      await _unlockBadge(GamificationConstants.badgeSilverArtist);
    }
    if (_totalDrawings >= 100) {
      await _unlockBadge(GamificationConstants.badgeMasterArtist);
    }
    if (_totalDrawings >= 250) {
      await _unlockBadge(GamificationConstants.badgeGoldArtist);
    }
    if (_totalDrawings >= 500) {
      await _unlockBadge(GamificationConstants.badgeDiamondArtist);
    }

    // Also award points for drawing
    await _addPoints(GamificationConstants.pointsPerCorrectDraw);

    // Check Quest Progress
    await checkQuestProgress(type, label);

    notifyListeners();
  }

  /// Renk oyununda doğru tur — çizim sayacından ayrı; puan ve `any` görevleri ilerler.
  Future<void> recordColorRoundSuccess() async {
    _colorRounds++;
    if (_colorRounds >= 50) {
      await _unlockBadge(GamificationConstants.badgeColorMaster);
    }

    final persistResult = await _persistDrawingCounters.call(
      DrawingCountersWrite(
        totalDrawings: _totalDrawings,
        numberDrawings: _numberDrawings,
        letterDrawings: _letterDrawings,
        shapeDrawings: _shapeDrawings,
        colorRounds: _colorRounds,
      ),
    );
    persistResult.fold(
      (failure) => _logger.error(
        'Persist drawing counters failed (color)',
        tag: 'Gamification',
        error: failure,
        data: {'failure': failure.toString()},
      ),
      (_) {},
    );

    await _addPoints(GamificationConstants.pointsPerCorrectDraw);
    await checkQuestProgress(DrawingType.any, null);
    notifyListeners();
  }

  Future<void> _unlockBadge(String badgeId) async {
    if (!_unlockedBadgeIds.contains(badgeId)) {
      _unlockedBadgeIds.add(badgeId);
      await _persistence.setStringList(GamificationConstants.keyUnlockedBadges, _unlockedBadgeIds);
      _logger.info(
        'Badge unlocked',
        tag: 'Gamification',
        data: {'badgeId': badgeId},
      );

      if (_unlockedBadgeIds.length >= 5) {
        await _unlockBadge(GamificationConstants.badgeBadgeCollector);
      }
      if (_unlockedBadgeIds.length >= 15) {
        await _unlockBadge(GamificationConstants.badgeBadgeMaster);
      }
    }
  }

  Future<void> checkQuestProgress(DrawingType type, String? drawnLabel) async {
    _quests = _quests.map((quest) {
      if (quest.isCompleted) return quest;

      final typeMatches = quest.targetType == type || quest.targetType == DrawingType.any;
      if (!typeMatches) return quest;

      if (quest.targetLabel != null) {
        if (drawnLabel == null ||
            quest.targetLabel!.toUpperCase().trim() != drawnLabel.toUpperCase().trim()) {
          return quest;
        }
      }

      final newCount = quest.currentCount + 1;
      final completed = newCount >= quest.targetCount;
      return quest.copyWith(
        currentCount: newCount,
        isCompleted: completed,
      );
    }).toList();
    _syncQuestLedgerFromQuests();
    await _persistQuestLedgerSilent();
  }

  Future<void> claimQuestReward(String questId) async {
    final index = _quests.indexWhere((q) => q.id == questId);
    if (index == -1) return;
    final quest = _quests[index];
    if (quest.isCompleted && !quest.isClaimed) {
      _quests = _quests.map((q) => q.id == questId ? q.copyWith(isClaimed: true) : q).toList();
      _syncQuestLedgerFromQuests();
      await _addPoints(quest.rewardPoints);
      await _persistQuestLedgerSilent();
      notifyListeners();
    }
  }

  Future<void> buyItem(ShopItemModel item) async {
    if (_points >= item.price && !_ownedItemIds.contains(item.id)) {
      _points -= item.price;
      _ownedItemIds.add(item.id);

      await _persistence.setInt(GamificationConstants.keyPoints, _points);
      await _persistence.setStringList(GamificationConstants.keyOwnedItems, _ownedItemIds);

      notifyListeners();
    }
  }

  Future<void> equipItem(ShopItemModel item) async {
    if (_ownedItemIds.contains(item.id)) {
      // Toggle or set
      // If already equipped, unequip? Or just set.
      // Let's set.
      _equippedItems[item.type.toString()] = item.id;

      await _persistence.setString(
          GamificationConstants.keyEquippedItems, json.encode(_equippedItems));

      notifyListeners();
    }
  }

  Future<void> unequipItem(ShopItemType type) async {
    if (_equippedItems.containsKey(type.toString())) {
      _equippedItems.remove(type.toString());
      await _persistence.setString(
          GamificationConstants.keyEquippedItems, json.encode(_equippedItems));
      notifyListeners();
    }
  }
}
