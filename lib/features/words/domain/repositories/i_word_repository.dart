import 'dart:ui';
import 'package:abc123/features/words/domain/word_entry.dart';

/// Kelime kataloğuna erişim için domain portu.
///
/// Implementation: `infrastructure/repositories/word_repository_impl.dart`
// ignore: one_member_abstracts
abstract interface class IWordRepository {
  /// Verilen dil için kelime listesini döndürür.
  List<WordEntry> getWordsForLocale(Locale locale);
}
