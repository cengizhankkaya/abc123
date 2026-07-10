/// Matematik modülü zorluk seviyeleri (`numbers_advanced` feature).
///
/// - [levelA]: Sonuç ≤ 10, tek basamaklı çıktı.
/// - [levelB]: Sonuç ≤ 20, tek veya çift basamaklı karışık.
/// - [levelC]: 2 basamaklı + 2 basamaklı, taşımasız (örn. 23 + 15 = 38).
enum DifficultyLevel {
  levelA,
  levelB,
  levelC;

  /// Sonraki seviyeyi döndürür; zaten [levelC] ise yine [levelC] döner.
  DifficultyLevel get next => switch (this) {
        DifficultyLevel.levelA => DifficultyLevel.levelB,
        DifficultyLevel.levelB => DifficultyLevel.levelC,
        DifficultyLevel.levelC => DifficultyLevel.levelC,
      };

  /// Ekranda gösterilecek kısa etiket.
  String get label => switch (this) {
        DifficultyLevel.levelA => 'A',
        DifficultyLevel.levelB => 'B',
        DifficultyLevel.levelC => 'C',
      };
}
