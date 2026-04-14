/// Oyun sonunda gösterilen **eğitici** özet (tıbbi tanı değildir).
enum ColorVisionHeuristicProfile {
  /// Her iki eksende de plakaların çoğu doğru.
  typical,

  /// Kırmızı–yeşil plakalarda belirgin düşüş, BY plakaları nispeten iyi.
  redGreenAxisLikely,

  /// BY plakalarda belirgin düşüş, RG nispeten iyi.
  blueYellowAxisLikely,

  /// Her iki türde de zayıf skor.
  mixedDifficulty,

  /// Sınırlı veri veya belirsiz skor dağılımı.
  inconclusive,
}

/// Skorlara göre basit kural tablosu. Klinik sınıflandırma yerine geçmez.
ColorVisionHeuristicProfile resolveColorVisionProfile({
  required int rgCorrect,
  required int rgTotal,
  required int byCorrect,
  required int byTotal,
}) {
  double rate(int correct, int total) {
    if (total <= 0) {
      return 1;
    }
    return correct / total;
  }

  final rg = rate(rgCorrect, rgTotal);
  final by = rate(byCorrect, byTotal);

  if (rgTotal == 0 && byTotal == 0) {
    return ColorVisionHeuristicProfile.inconclusive;
  }

  const ok = 0.62;
  const weak = 0.48;

  final rgWeak = rgTotal > 0 && rg < weak;
  final byWeak = byTotal > 0 && by < weak;
  final rgOk = rgTotal == 0 || rg >= ok;
  final byOk = byTotal == 0 || by >= ok;

  if (rgOk && byOk && rg >= ok && by >= ok) {
    return ColorVisionHeuristicProfile.typical;
  }
  if (rgWeak && !byWeak && by >= ok) {
    return ColorVisionHeuristicProfile.redGreenAxisLikely;
  }
  if (byWeak && !rgWeak && rg >= ok) {
    return ColorVisionHeuristicProfile.blueYellowAxisLikely;
  }
  if (rgWeak && byWeak) {
    return ColorVisionHeuristicProfile.mixedDifficulty;
  }
  return ColorVisionHeuristicProfile.inconclusive;
}
