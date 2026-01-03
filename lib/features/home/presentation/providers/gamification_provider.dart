import 'dart:math';

import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/features/home/domain/models/badge_model.dart';
import 'package:abc123/features/home/domain/models/quest_model.dart';
import 'package:abc123/features/home/domain/models/shop_item_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamificationProvider extends ChangeNotifier {
  int _points = 0;
  int _streak = 0;
  int _totalDrawings = 0;
  int _numberDrawings = 0;
  int _letterDrawings = 0;
  int _shapeDrawings = 0;
  List<String> _unlockedBadgeIds = [];
  List<QuestModel> _quests = [];

  // Shop State
  List<String> _ownedItemIds = [];
  Map<String, String> _equippedItems =
      {}; // { 'hat': 'item_id', 'glasses': 'item_id' }

  List<QuestModel> get quests => _quests;
  List<String> get ownedItemIds => _ownedItemIds;
  Map<String, String> get equippedItems => _equippedItems;

  // Shop Items Catalog
  final List<ShopItemModel> _shopItems = [
    // Hats
    const ShopItemModel(
      id: 'hat_blue_cap',
      name: 'Mavi Şapka',
      type: ShopItemType.hat,
      price: 50,
      iconData: Icons.school,
      color: Colors.blue,
    ),
    const ShopItemModel(
      id: 'hat_crown',
      name: 'Kral Tacı',
      type: ShopItemType.hat,
      price: 500,
      iconData: Icons.emoji_events,
      color: Colors.amber,
    ),
    const ShopItemModel(
      id: 'hat_wizard',
      name: 'Büyücü Şapkası',
      type: ShopItemType.hat,
      price: 150,
      iconData: Icons.auto_fix_high,
      color: Colors.purple,
    ),
    const ShopItemModel(
      id: 'hat_flower',
      name: 'Çiçekli Taç',
      type: ShopItemType.hat,
      price: 75,
      iconData: Icons.local_florist,
      color: Colors.pink,
    ),
    const ShopItemModel(
      id: 'hat_pirate',
      name: 'Korsan Şapkası',
      type: ShopItemType.hat,
      price: 120,
      iconData: Icons.explore,
      color: Colors.black,
    ),
    const ShopItemModel(
      id: 'hat_chef',
      name: 'Aşçı Şapkası',
      type: ShopItemType.hat,
      price: 80,
      iconData: Icons.restaurant_menu,
      color: Colors.white,
    ),

    // Glasses
    // Glasses
    const ShopItemModel(
      id: 'glasses_sun',
      name: 'Güneş Gözlüğü',
      type: ShopItemType.glasses,
      price: 100,
      iconData: Icons.visibility,
      color: Colors.black,
    ),
    const ShopItemModel(
      id: 'glasses_nerd',
      name: 'Bilgiç Gözlüğü',
      type: ShopItemType.glasses,
      price: 75,
      iconData: Icons.remove_red_eye,
      color: Colors.brown,
    ),
    const ShopItemModel(
      id: 'glasses_heart',
      name: 'Kalpli Gözlük',
      type: ShopItemType.glasses,
      price: 125,
      iconData: Icons.favorite,
      color: Colors.redAccent,
    ),
    const ShopItemModel(
      id: 'glasses_3d',
      name: '3D Gözlük',
      type: ShopItemType.glasses,
      price: 150,
      iconData: Icons.videogame_asset,
      color: Colors.cyan,
    ),
    const ShopItemModel(
      id: 'glasses_vr',
      name: 'VR Gözlüğü',
      type: ShopItemType.glasses,
      price: 300,
      iconData: Icons.vrpano,
      color: Colors.grey,
    ),
    const ShopItemModel(
      id: 'glasses_ski',
      name: 'Kayak Gözlüğü',
      type: ShopItemType.glasses,
      price: 180,
      iconData: Icons.downhill_skiing,
      color: Colors.white,
    ),
    const ShopItemModel(
      id: 'glasses_mask',
      name: 'Maske',
      type: ShopItemType.glasses,
      price: 50,
      iconData: Icons.masks,
      color: Colors.purple,
    ),
    const ShopItemModel(
      id: 'glasses_reading',
      name: 'Okuma Gözlüğü',
      type: ShopItemType.glasses,
      price: 60,
      iconData: Icons.menu_book,
      color: Colors.teal,
    ),

    // Outfits
    const ShopItemModel(
      id: 'outfit_red',
      name: 'Kırmızı Tişört',
      type: ShopItemType.outfit,
      price: 200,
      iconData: Icons.checkroom,
      color: Colors.red,
    ),
    const ShopItemModel(
      id: 'outfit_super',
      name: 'Süper Kahraman',
      type: ShopItemType.outfit,
      price: 1000,
      iconData: Icons.shield,
      color: Colors.blueAccent,
    ),
    const ShopItemModel(
      id: 'outfit_green',
      name: 'Yeşil Hoodie',
      type: ShopItemType.outfit,
      price: 250,
      iconData: Icons.forest,
      color: Colors.green,
    ),
    const ShopItemModel(
      id: 'outfit_doctor',
      name: 'Doktor Önlüğü',
      type: ShopItemType.outfit,
      price: 400,
      iconData: Icons.medical_services,
      color: Colors.white,
    ),
    const ShopItemModel(
      id: 'outfit_space',
      name: 'Uzay Kostümü',
      type: ShopItemType.outfit,
      price: 800,
      iconData: Icons.rocket_launch,
      color: Colors.orange,
    ),
    const ShopItemModel(
      id: 'outfit_sports',
      name: 'Forma',
      type: ShopItemType.outfit,
      price: 220,
      iconData: Icons.sports_soccer,
      color: Colors.redAccent,
    ),
    const ShopItemModel(
      id: 'outfit_police',
      name: 'Polis Üniforması',
      type: ShopItemType.outfit,
      price: 350,
      iconData: Icons.local_police,
      color: Colors.blue,
    ),
    const ShopItemModel(
      id: 'outfit_chef',
      name: 'Aşçı Önlüğü',
      type: ShopItemType.outfit,
      price: 280,
      iconData: Icons.restaurant,
      color: Colors.white,
    ),
    const ShopItemModel(
      id: 'outfit_winter',
      name: 'Kışlık Mont',
      type: ShopItemType.outfit,
      price: 300,
      iconData: Icons.ac_unit,
      color: Colors.lightBlue,
    ),
    const ShopItemModel(
      id: 'outfit_tuxedo',
      name: 'Smokin',
      type: ShopItemType.outfit,
      price: 600,
      iconData: Icons.person,
      color: Colors.black,
    ),
  ];

  List<ShopItemModel> get shopItems => _shopItems;

  // In-memory list of all available badges
  List<BadgeModel> _badges = [
    BadgeModel(
      id: GamificationConstants.badgeFirstLogin,
      nameKey: 'badgeFirstLoginName',
      descriptionKey: 'badgeFirstLoginDesc',
      iconData: Icons.login,
    ),
    BadgeModel(
      id: GamificationConstants.badgeFirstDraw,
      nameKey: 'badgeFirstDrawName',
      descriptionKey: 'badgeFirstDrawDesc',
      iconData: Icons.edit,
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak3,
      nameKey: 'badgeStreak3Name',
      descriptionKey: 'badgeStreak3Desc',
      iconData: Icons.local_fire_department,
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak7,
      nameKey: 'badgeStreak7Name',
      descriptionKey: 'badgeStreak7Desc',
      iconData: Icons.stars,
    ),
    BadgeModel(
      id: GamificationConstants.badgeStreak30,
      nameKey: 'badgeStreak30Name',
      descriptionKey: 'badgeStreak30Desc',
      iconData: Icons.whatshot,
    ),
    BadgeModel(
      id: GamificationConstants.badgeBronzeArtist,
      nameKey: 'badgeBronzeArtistName',
      descriptionKey: 'badgeBronzeArtistDesc',
      iconData: Icons.edit_note,
    ),
    BadgeModel(
      id: GamificationConstants.badgeSilverArtist,
      nameKey: 'badgeSilverArtistName',
      descriptionKey: 'badgeSilverArtistDesc',
      iconData: Icons.brush,
    ),
    BadgeModel(
      id: GamificationConstants.badgeMasterArtist,
      nameKey: 'badgeMasterArtistName',
      descriptionKey: 'badgeMasterArtistDesc',
      iconData: Icons.palette,
    ),
    BadgeModel(
      id: GamificationConstants.badgeGoldArtist,
      nameKey: 'badgeGoldArtistName',
      descriptionKey: 'badgeGoldArtistDesc',
      iconData: Icons.color_lens,
    ),
    BadgeModel(
      id: GamificationConstants.badgeDiamondArtist,
      nameKey: 'badgeDiamondArtistName',
      descriptionKey: 'badgeDiamondArtistDesc',
      iconData: Icons.diamond,
    ),
    BadgeModel(
      id: GamificationConstants.badgeEarlyBird,
      nameKey: 'badgeEarlyBirdName',
      descriptionKey: 'badgeEarlyBirdDesc',
      iconData: Icons.wb_sunny,
    ),
    BadgeModel(
      id: GamificationConstants.badgeNightOwl,
      nameKey: 'badgeNightOwlName',
      descriptionKey: 'badgeNightOwlDesc',
      iconData: Icons.nights_stay,
    ),
    BadgeModel(
      id: GamificationConstants.badgeWeekendWarrior,
      nameKey: 'badgeWeekendWarriorName',
      descriptionKey: 'badgeWeekendWarriorDesc',
      iconData: Icons.weekend,
    ),
    BadgeModel(
      id: GamificationConstants.badgeNumberMaster,
      nameKey: 'badgeNumberMasterName',
      descriptionKey: 'badgeNumberMasterDesc',
      iconData: Icons.looks_one,
    ),
    BadgeModel(
      id: GamificationConstants.badgeLetterMaster,
      nameKey: 'badgeLetterMasterName',
      descriptionKey: 'badgeLetterMasterDesc',
      iconData: Icons.abc,
    ),
    BadgeModel(
      id: GamificationConstants.badgeShapeMaster,
      nameKey: 'badgeShapeMasterName',
      descriptionKey: 'badgeShapeMasterDesc',
      iconData: Icons.category,
    ),
    BadgeModel(
      id: GamificationConstants.badgeHighScorer,
      nameKey: 'badgeHighScorerName',
      descriptionKey: 'badgeHighScorerDesc',
      iconData: Icons.emoji_events,
    ),
    BadgeModel(
      id: GamificationConstants.badgeScoreLegend,
      nameKey: 'badgeScoreLegendName',
      descriptionKey: 'badgeScoreLegendDesc',
      iconData: Icons.military_tech,
    ),
    BadgeModel(
      id: GamificationConstants.badgeBadgeCollector,
      nameKey: 'badgeBadgeCollectorName',
      descriptionKey: 'badgeBadgeCollectorDesc',
      iconData: Icons.collections_bookmark,
    ),
    BadgeModel(
      id: GamificationConstants.badgeBadgeMaster,
      nameKey: 'badgeBadgeMasterName',
      descriptionKey: 'badgeBadgeMasterDesc',
      iconData: Icons.workspace_premium,
    ),
  ];

  int get points => _points;
  int get streak => _streak;
  int get numberDrawings => _numberDrawings;
  int get letterDrawings => _letterDrawings;
  int get shapeDrawings => _shapeDrawings;
  List<BadgeModel> get badges {
    return _badges.map((badge) {
      return badge.copyWith(isLocked: !_unlockedBadgeIds.contains(badge.id));
    }).toList();
  }

  List<BadgeModel> get unlockedBadges {
    return badges.where((b) => !b.isLocked).toList();
  }

  GamificationProvider() {
    _init();
  }

  Future<void> _init() async {
    debugPrint("GamificationProvider: _init started");
    final prefs = await SharedPreferences.getInstance();
    _points = prefs.getInt(GamificationConstants.keyPoints) ?? 0;
    _streak = prefs.getInt(GamificationConstants.keyStreak) ?? 0;
    _totalDrawings = prefs.getInt(GamificationConstants.keyTotalDrawings) ?? 0;
    _numberDrawings =
        prefs.getInt(GamificationConstants.keyNumberDrawings) ?? 0;
    _letterDrawings =
        prefs.getInt(GamificationConstants.keyLetterDrawings) ?? 0;
    _shapeDrawings = prefs.getInt(GamificationConstants.keyShapeDrawings) ?? 0;
    _unlockedBadgeIds =
        prefs.getStringList(GamificationConstants.keyUnlockedBadges) ?? [];

    _ownedItemIds =
        prefs.getStringList(GamificationConstants.keyOwnedItems) ?? [];

    final equippedJson =
        prefs.getString(GamificationConstants.keyEquippedItems);
    if (equippedJson != null) {
      _equippedItems = Map<String, String>.from(json.decode(equippedJson));
    }

    await _checkStreak(prefs);

    // Initialize Quests if not present
    if (_quests.isEmpty) {
      _generateQuests();
    }

    // --- TESTING MODE: UNLOCK EVERYTHING (FORCED) ---
    // if (_ownedItemIds.isEmpty) { // Removed condition to force unlock
    _points = 50000;
    _ownedItemIds = _shopItems.map((e) => e.id).toList();
    await prefs.setInt(GamificationConstants.keyPoints, _points);
    await prefs.setStringList(
        GamificationConstants.keyOwnedItems, _ownedItemIds);
    // }
    // ---------------------------------------

    notifyListeners();
  }

  Future<void> _checkStreak(SharedPreferences prefs) async {
    final lastLoginString =
        prefs.getString(GamificationConstants.keyLastLoginDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastLoginString == null) {
      // First time login
      _streak = 1;
      await prefs.setString(
          GamificationConstants.keyLastLoginDate, today.toIso8601String());
      await prefs.setInt(GamificationConstants.keyStreak, _streak);
      _unlockBadge(GamificationConstants.badgeFirstLogin, prefs);
    } else {
      final lastLogin = DateTime.parse(lastLoginString);
      final lastLoginDate =
          DateTime(lastLogin.year, lastLogin.month, lastLogin.day);

      if (lastLoginDate.isBefore(today)) {
        if (today.difference(lastLoginDate).inDays == 1) {
          // Consecutive day
          _streak++;
          _addPoints(GamificationConstants.pointsPerStreakDay, prefs);
        } else {
          // Streak broken
          _streak = 1;
        }
        await prefs.setString(
            GamificationConstants.keyLastLoginDate, today.toIso8601String());
        await prefs.setInt(GamificationConstants.keyStreak, _streak);

        // Check streak badges
        if (_streak >= 3)
          _unlockBadge(GamificationConstants.badgeStreak3, prefs);
        if (_streak >= 7)
          _unlockBadge(GamificationConstants.badgeStreak7, prefs);
        if (_streak >= 30)
          _unlockBadge(GamificationConstants.badgeStreak30, prefs);
      }
    }

    // Check Time-based Badges
    final hour = now.hour;
    if (hour >= 6 && hour < 10) {
      _unlockBadge(GamificationConstants.badgeEarlyBird, prefs);
    } else if (hour >= 22 || hour < 4) {
      _unlockBadge(GamificationConstants.badgeNightOwl, prefs);
    }

    // Check Weekend Badge
    if (today.weekday == DateTime.saturday ||
        today.weekday == DateTime.sunday) {
      _unlockBadge(GamificationConstants.badgeWeekendWarrior, prefs);
    }
  }

  Future<void> addPoints(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    await _addPoints(amount, prefs);
    notifyListeners();
  }

  Future<void> _addPoints(int amount, SharedPreferences prefs) async {
    _points += amount;
    await prefs.setInt(GamificationConstants.keyPoints, _points);

    // Check Score Badges
    if (_points >= 1000) {
      _unlockBadge(GamificationConstants.badgeHighScorer, prefs);
    }
    if (_points >= 5000) {
      _unlockBadge(GamificationConstants.badgeScoreLegend, prefs);
    }
  }

  Future<void> incrementTotalDrawings(
      {DrawingType type = DrawingType.any, String? label}) async {
    final prefs = await SharedPreferences.getInstance();

    // Increment general total
    _totalDrawings++;
    await prefs.setInt(GamificationConstants.keyTotalDrawings, _totalDrawings);

    // Increment category specific
    if (type == DrawingType.number) {
      _numberDrawings++;
      await prefs.setInt(
          GamificationConstants.keyNumberDrawings, _numberDrawings);
      if (_numberDrawings >= 50)
        _unlockBadge(GamificationConstants.badgeNumberMaster, prefs);
    } else if (type == DrawingType.letter) {
      _letterDrawings++;
      await prefs.setInt(
          GamificationConstants.keyLetterDrawings, _letterDrawings);
      if (_letterDrawings >= 50)
        _unlockBadge(GamificationConstants.badgeLetterMaster, prefs);
    } else if (type == DrawingType.shape) {
      _shapeDrawings++;
      await prefs.setInt(
          GamificationConstants.keyShapeDrawings, _shapeDrawings);
      if (_shapeDrawings >= 50)
        _unlockBadge(GamificationConstants.badgeShapeMaster, prefs);
    }

    _unlockBadge(GamificationConstants.badgeFirstDraw, prefs);
    if (_totalDrawings >= 10) {
      _unlockBadge(GamificationConstants.badgeBronzeArtist, prefs);
    }
    if (_totalDrawings >= 50) {
      _unlockBadge(GamificationConstants.badgeSilverArtist, prefs);
    }
    if (_totalDrawings >= 100) {
      _unlockBadge(GamificationConstants.badgeMasterArtist, prefs);
    }
    if (_totalDrawings >= 250) {
      _unlockBadge(GamificationConstants.badgeGoldArtist, prefs);
    }
    if (_totalDrawings >= 500) {
      _unlockBadge(GamificationConstants.badgeDiamondArtist, prefs);
    }

    // Also award points for drawing
    await _addPoints(GamificationConstants.pointsPerCorrectDraw, prefs);

    // Check Quest Progress
    checkQuestProgress(type, label);

    notifyListeners();
  }

  Future<void> _unlockBadge(String badgeId, SharedPreferences prefs) async {
    if (!_unlockedBadgeIds.contains(badgeId)) {
      _unlockedBadgeIds.add(badgeId);
      await prefs.setStringList(
          GamificationConstants.keyUnlockedBadges, _unlockedBadgeIds);
      debugPrint("Badge Unlocked: $badgeId");

      if (_unlockedBadgeIds.length >= 5) {
        _unlockBadge(GamificationConstants.badgeBadgeCollector, prefs);
      }
      if (_unlockedBadgeIds.length >= 15) {
        _unlockBadge(GamificationConstants.badgeBadgeMaster, prefs);
      }
    }
  }

  void _generateQuests() {
    final random = Random();
    _quests = [];

    // 1. Daily Specific Quest
    final typeIndex = random.nextInt(3);
    final count = random.nextInt(3) + 3; // 3-5
    DrawingType type;
    String targetLabel;

    switch (typeIndex) {
      case 0:
        type = DrawingType.number;
        targetLabel = (random.nextInt(9) + 1).toString();
        break;
      case 1:
        type = DrawingType.letter;
        const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        targetLabel = letters[random.nextInt(letters.length)];
        break;
      case 2:
      default:
        type = DrawingType.shape;
        final shapes = ['DAIRE', 'UCGEN', 'KARE'];
        targetLabel = shapes[random.nextInt(shapes.length)];
        break;
    }

    _quests.add(QuestModel(
      id: "daily_${DateTime.now().day}",
      titleKey: 'daily_quest',
      targetType: type,
      targetLabel: targetLabel,
      targetCount: count,
      rewardPoints: 20,
    ));

    // 2. Weekly Category Quest (e.g. Draw 10 Numbers)
    _quests.add(QuestModel(
      id: "weekly_numbers",
      titleKey: 'weekly_number_quest',
      targetType: DrawingType.number,
      targetCount: 10,
      rewardPoints: 50,
    ));

    // 3. Weekly Generic Quest (Draw 20 Any)
    _quests.add(QuestModel(
      id: "weekly_generic",
      titleKey: 'weekly_generic_quest',
      targetType: DrawingType.any,
      targetCount: 20,
      rewardPoints: 100,
    ));
  }

  void checkQuestProgress(DrawingType type, String? drawnLabel) {
    for (var quest in _quests) {
      if (quest.isCompleted) continue;

      if (quest.targetType == type || quest.targetType == DrawingType.any) {
        // If specific label required
        if (quest.targetLabel != null) {
          if (drawnLabel == null ||
              quest.targetLabel!.toUpperCase().trim() !=
                  drawnLabel.toUpperCase().trim()) {
            continue;
          }
        }

        quest.currentCount++;
        if (quest.currentCount >= quest.targetCount) {
          quest.isCompleted = true;
        }
      }
    }
    // Notify listeners mainly if progress changes, currently calling often
    // Ideally check if changes happened. For now, this is called by incrementTotalDrawings which notifies.
  }

  Future<void> claimQuestReward(String questId) async {
    final index = _quests.indexWhere((q) => q.id == questId);
    if (index != -1) {
      final quest = _quests[index];
      if (quest.isCompleted && !quest.isClaimed) {
        quest.isClaimed = true;
        final prefs = await SharedPreferences.getInstance();
        await _addPoints(quest.rewardPoints, prefs);
        notifyListeners();
      }
    }
  }

  Future<void> buyItem(ShopItemModel item) async {
    if (_points >= item.price && !_ownedItemIds.contains(item.id)) {
      _points -= item.price;
      _ownedItemIds.add(item.id);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(GamificationConstants.keyPoints, _points);
      await prefs.setStringList(
          GamificationConstants.keyOwnedItems, _ownedItemIds);

      notifyListeners();
    }
  }

  Future<void> equipItem(ShopItemModel item) async {
    if (_ownedItemIds.contains(item.id)) {
      // Toggle or set
      // If already equipped, unequip? Or just set.
      // Let's set.
      _equippedItems[item.type.toString()] = item.id;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          GamificationConstants.keyEquippedItems, json.encode(_equippedItems));

      notifyListeners();
    }
  }

  Future<void> unequipItem(ShopItemType type) async {
    if (_equippedItems.containsKey(type.toString())) {
      _equippedItems.remove(type.toString());
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          GamificationConstants.keyEquippedItems, json.encode(_equippedItems));
      notifyListeners();
    }
  }
}
