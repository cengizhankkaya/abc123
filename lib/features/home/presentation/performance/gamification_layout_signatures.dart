import 'package:abc123/features/home/domain/entities/badge_model.dart';
import 'package:abc123/features/home/domain/entities/quest_model.dart';
import 'package:abc123/features/home/domain/entities/shop_item_model.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';

/// [Selector] / [context.select] için hafif imzalar (`16_performance.md` — gereksiz rebuild azaltma).

int homeCategoryProgressSignature(GamificationProvider p) => Object.hash(
      p.numberDrawings,
      p.letterDrawings,
      p.shapeDrawings,
      p.colorRounds,
      p.wordsCompleted,
    );

int headerPointsStreakSignature(GamificationProvider p) =>
    Object.hash(p.points, p.streak, p.childName);

int homeContinueSignature(GamificationProvider p) => Object.hash(
      p.lastActivityMode,
      p.lastActivityIndex,
      p.lastActivityTotal,
    );

int questListLayoutSignature(List<QuestModel> quests) {
  var h = quests.length;
  for (final q in quests) {
    h = Object.hash(h, q.id, q.currentCount, q.isCompleted, q.isClaimed);
  }
  return h;
}

int unlockedBadgeListSignature(List<BadgeModel> badges) {
  var h = badges.length;
  for (final b in badges) {
    h = Object.hash(h, b.id);
  }
  return h;
}

int shopTabSignature(GamificationProvider p, ShopItemType type) {
  final itemIds = p.shopItems.where((i) => i.type == type).map((i) => i.id).toList()..sort();
  var h = Object.hash(p.points, type.index);
  for (final id in p.ownedItemIds) {
    h = Object.hash(h, id);
  }
  for (final e in p.equippedItems.entries) {
    h = Object.hash(h, e.key, e.value);
  }
  for (final id in itemIds) {
    h = Object.hash(h, id);
  }
  return h;
}
