import 'package:abc123/features/info/l10n/generated/info_localizations.dart';
import 'package:flutter/widgets.dart';

extension InfoLocalizationsX on BuildContext {
  InfoLocalizations? get infoL10n => InfoLocalizations.of(this);
}
