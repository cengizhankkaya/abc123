/// Çizim sayaçlarını kalıcılığa yazmak için girdi (değişmez DTO — `11_data_modeling.md`).
class DrawingCountersWrite {
  const DrawingCountersWrite({
    required this.totalDrawings,
    required this.numberDrawings,
    required this.letterDrawings,
    required this.shapeDrawings,
    required this.colorRounds,
    required this.wordsCompleted,
  });
  final int totalDrawings;
  final int numberDrawings;
  final int letterDrawings;
  final int shapeDrawings;
  final int colorRounds;
  final int wordsCompleted;
}
