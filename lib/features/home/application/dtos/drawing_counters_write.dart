/// Çizim sayaçlarını kalıcılığa yazmak için girdi (değişmez DTO — `11_data_modeling.md`).
class DrawingCountersWrite {
  final int totalDrawings;
  final int numberDrawings;
  final int letterDrawings;
  final int shapeDrawings;

  const DrawingCountersWrite({
    required this.totalDrawings,
    required this.numberDrawings,
    required this.letterDrawings,
    required this.shapeDrawings,
  });
}
