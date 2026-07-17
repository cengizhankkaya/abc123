/// Her harf veya kelime için AR'da gösterilecek 3D modelin bilgileri.
class ArModelInfo {
  const ArModelInfo({
    required this.id,
    required this.assetPath,
    required this.emoji,
  });

  /// `assets/models/ar/` altındaki .glb dosyasının tam yolu.
  final String assetPath;

  /// Modelin ID'si (çeviri için kullanılacak, örn. "at").
  final String id;

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
    'A': ArModelInfo(assetPath: '${_basePath}at.glb', id: 'at', emoji: '🐴'),
    'B': ArModelInfo(assetPath: '${_basePath}balik.glb', id: 'balik', emoji: '🐟'),
    'C': ArModelInfo(assetPath: '${_basePath}civciv.glb', id: 'civciv', emoji: '🐥'),
    'Ç': ArModelInfo(assetPath: '${_basePath}cicek.glb', id: 'cicek', emoji: '🌸'),
    'D': ArModelInfo(assetPath: '${_basePath}domuz.glb', id: 'domuz', emoji: '🐷'),
    'E': ArModelInfo(assetPath: '${_basePath}elma.glb', id: 'elma', emoji: '🍎'),
    'F': ArModelInfo(assetPath: '${_basePath}fil.glb', id: 'fil', emoji: '🐘'),
    'G': ArModelInfo(assetPath: '${_basePath}gemi.glb', id: 'gemi', emoji: '🚢'),
    'Ğ': ArModelInfo(assetPath: '${_basePath}gunes.glb', id: 'gunes', emoji: '☀️'),
    'H': ArModelInfo(assetPath: '${_basePath}horoz.glb', id: 'horoz', emoji: '🐓'),
    'I': ArModelInfo(assetPath: '${_basePath}inek.glb', id: 'irgatci', emoji: '🐄'),
    'İ': ArModelInfo(assetPath: '${_basePath}inek.glb', id: 'inek', emoji: '🐄'),
    'J': ArModelInfo(assetPath: '${_basePath}jaguar.glb', id: 'jaguar', emoji: '🐆'),
    'K': ArModelInfo(assetPath: '${_basePath}kedi.glb', id: 'kedi', emoji: '🐱'),
    'L': ArModelInfo(assetPath: '${_basePath}limon.glb', id: 'limon', emoji: '🍋'),
    'M': ArModelInfo(assetPath: '${_basePath}muz.glb', id: 'muz', emoji: '🍌'),
    'N': ArModelInfo(assetPath: '${_basePath}nar.glb', id: 'nar', emoji: '🍎'),
    'O': ArModelInfo(assetPath: '${_basePath}ordek.glb', id: 'ordek', emoji: '🦆'),
    'Ö': ArModelInfo(assetPath: '${_basePath}ordek.glb', id: 'ordek', emoji: '🦆'),
    'P': ArModelInfo(assetPath: '${_basePath}panda.glb', id: 'panda', emoji: '🐼'),
    'R': ArModelInfo(assetPath: '${_basePath}robot.glb', id: 'robot', emoji: '🤖'),
    'S': ArModelInfo(assetPath: '${_basePath}sincap.glb', id: 'sincap', emoji: '🐿️'),
    'Ş': ArModelInfo(assetPath: '${_basePath}sampinyon.glb', id: 'sampinyon', emoji: '🍄'),
    'T': ArModelInfo(assetPath: '${_basePath}tavuk.glb', id: 'tavuk', emoji: '🐔'),
    'U': ArModelInfo(assetPath: '${_basePath}uzayli.glb', id: 'uzayli', emoji: '👽'),
    'Ü': ArModelInfo(assetPath: '${_basePath}uzum.glb', id: 'uzum', emoji: '🍇'),
    'V': ArModelInfo(assetPath: '${_basePath}vagon.glb', id: 'vagon', emoji: '🚃'),
    'Y': ArModelInfo(assetPath: '${_basePath}yildiz.glb', id: 'yildiz', emoji: '⭐'),
    'Z': ArModelInfo(assetPath: '${_basePath}zurafa.glb', id: 'zurafa', emoji: '🦒'),
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
