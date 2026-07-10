/// Kalıcılıktan okunan oyun durumu özeti (uygulama DTO; değişmez — `11_data_modeling.md`).
class GamificationInitialState {
  final int points;
  final int streak;
  final int totalDrawings;
  final int numberDrawings;
  final int letterDrawings;
  final int shapeDrawings;
  final int colorRounds;
  final int wordsCompleted;
  final List<String> unlockedBadgeIds;
  final List<String> ownedItemIds;
  final String? equippedItemsJson;
  final String? questsLedgerJson;

  const GamificationInitialState({
    required this.points,
    required this.streak,
    required this.totalDrawings,
    required this.numberDrawings,
    required this.letterDrawings,
    required this.shapeDrawings,
    required this.colorRounds,
    required this.wordsCompleted,
    required this.unlockedBadgeIds,
    required this.ownedItemIds,
    this.equippedItemsJson,
    this.questsLedgerJson,
  });
}
