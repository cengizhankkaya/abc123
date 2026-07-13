import 'package:meta/meta.dart';

/// Bir kelime seviyesi girdisi.
///
/// `spelling`: TFLite modelin tanıyabildiği A–Z büyük harflerden oluşur.
/// `displayKey`: l10n anahtarıdır (ör. `wordCatDisplay`).
@immutable
final class WordEntry {
  const WordEntry({
    required this.id,
    required this.spelling,
    required this.displayKey,
    required this.emoji,
  });

  final String id;
  final String spelling;
  final String displayKey;
  final String emoji;

  int get length => spelling.length;
}

