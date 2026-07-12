import 'dart:ui';
import 'package:abc123/features/words/domain/repositories/i_word_repository.dart';
import 'package:abc123/features/words/domain/word_entry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWordListUseCase {
  final IWordRepository _repository;

  const GetWordListUseCase(this._repository);

  List<WordEntry> call(Locale locale) {
    return _repository.getWordsForLocale(locale);
  }
}
