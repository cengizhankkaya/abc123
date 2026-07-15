import 'package:abc123/features/words/l10n/generated/words_localizations.dart';
import 'package:flutter/widgets.dart';

extension WordsLocalizationsX on BuildContext {
  WordsLocalizations? get wordsL10n => WordsLocalizations.of(this);
}
