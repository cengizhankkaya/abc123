/// Her harf veya kelime için AR'da gösterilecek 3D modelin bilgileri.
class ArModelInfo {
  const ArModelInfo({
    required this.assetPath,
    required this.displayName,
    required this.emoji,
  });

  /// `assets/models/ar/` altındaki .glb dosyasının tam yolu.
  final String assetPath;

  /// Kullanıcıya gösterilen Türkçe ad (örn. "At").
  final String displayName;

  /// Modeli temsil eden emoji (yükleme sırasında gösterilir).
  final String emoji;
}

/// Harf → ArModelInfo eşleştirmesi.
///
/// Desteklenmeyen harfler için `null` döner.
class ArModelMapper {
  ArModelMapper._();

  static const _basePath = 'assets/models/ar/';

  static const Map<String, ArModelInfo> _map = {
    'A': ArModelInfo(assetPath: '${_basePath}at.glb', displayName: 'At', emoji: '🐴'),
    'B': ArModelInfo(assetPath: '${_basePath}balik.glb', displayName: 'Balık', emoji: '🐟'),
    'C': ArModelInfo(assetPath: '${_basePath}civciv.glb', displayName: 'Civciv', emoji: '🐥'),
    'Ç': ArModelInfo(assetPath: '${_basePath}cicek.glb', displayName: 'Çiçek', emoji: '🌸'),
    'D': ArModelInfo(assetPath: '${_basePath}domuz.glb', displayName: 'Domuz', emoji: '🐷'),
    'E': ArModelInfo(assetPath: '${_basePath}elma.glb', displayName: 'Elma', emoji: '🍎'),
    'F': ArModelInfo(assetPath: '${_basePath}fil.glb', displayName: 'Fil', emoji: '🐘'),
    'G': ArModelInfo(assetPath: '${_basePath}gemi.glb', displayName: 'Gemi', emoji: '🚢'),
    'Ğ': ArModelInfo(assetPath: '${_basePath}gunes.glb', displayName: 'Güneş', emoji: '☀️'),
    'H': ArModelInfo(assetPath: '${_basePath}horoz.glb', displayName: 'Horoz', emoji: '🐓'),
    'I': ArModelInfo(assetPath: '${_basePath}inek.glb', displayName: 'Irgatçı', emoji: '🐄'),
    'İ': ArModelInfo(assetPath: '${_basePath}inek.glb', displayName: 'İnek', emoji: '🐄'),
    'J': ArModelInfo(assetPath: '${_basePath}jaguar.glb', displayName: 'Jaguar', emoji: '🐆'),
    'K': ArModelInfo(assetPath: '${_basePath}kedi.glb', displayName: 'Kedi', emoji: '🐱'),
    'L': ArModelInfo(assetPath: '${_basePath}limon.glb', displayName: 'Limon', emoji: '🍋'),
    'M': ArModelInfo(assetPath: '${_basePath}muz.glb', displayName: 'Muz', emoji: '🍌'),
    'N': ArModelInfo(assetPath: '${_basePath}nar.glb', displayName: 'Nar', emoji: '🍎'),
    'O': ArModelInfo(assetPath: '${_basePath}ordek.glb', displayName: 'Ördek', emoji: '🦆'),
    'Ö': ArModelInfo(assetPath: '${_basePath}ordek.glb', displayName: 'Ördek', emoji: '🦆'),
    'P': ArModelInfo(assetPath: '${_basePath}panda.glb', displayName: 'Panda', emoji: '🐼'),
    'R': ArModelInfo(assetPath: '${_basePath}robot.glb', displayName: 'Robot', emoji: '🤖'),
    'S': ArModelInfo(assetPath: '${_basePath}sincap.glb', displayName: 'Sincap', emoji: '🐿️'),
    'Ş': ArModelInfo(assetPath: '${_basePath}sampinyon.glb', displayName: 'Şampinyon', emoji: '🍄'),
    'T': ArModelInfo(assetPath: '${_basePath}tavuk.glb', displayName: 'Tavuk', emoji: '🐔'),
    'U': ArModelInfo(assetPath: '${_basePath}uzayli.glb', displayName: 'Uzaylı', emoji: '👽'),
    'Ü': ArModelInfo(assetPath: '${_basePath}uzum.glb', displayName: 'Üzüm', emoji: '🍇'),
    'V': ArModelInfo(assetPath: '${_basePath}vagon.glb', displayName: 'Vagon', emoji: '🚃'),
    'Y': ArModelInfo(assetPath: '${_basePath}yildiz.glb', displayName: 'Yıldız', emoji: '⭐'),
    'Z': ArModelInfo(assetPath: '${_basePath}zurafa.glb', displayName: 'Zürafa', emoji: '🦒'),
  };

  /// Harfe karşılık gelen AR modelini döner.
  /// Harf bulunamazsa `null` döner.
  static ArModelInfo? forLetter(String letter) {
    return _map[letter.toUpperCase()];
  }

  /// Bu harfin AR modeli olup olmadığını döner.
  static bool hasModel(String letter) {
    return _map.containsKey(letter.toUpperCase());
  }
}
