import 'dart:ui';

import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/features/words/domain/repositories/i_word_repository.dart';
import 'package:abc123/features/words/domain/word_catalog.dart';
import 'package:abc123/features/words/domain/word_entry.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWordRepository)
class WordRepositoryImpl extends BaseRepository implements IWordRepository {
  WordRepositoryImpl(
    super.exceptionHandler,
    super.failureMapper,
  );

  @override
  List<WordEntry> getWordsForLocale(Locale locale) {
    return WordCatalog.wordsForLocale(locale.languageCode);
  }
}
