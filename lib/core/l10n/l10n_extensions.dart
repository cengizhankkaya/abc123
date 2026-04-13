import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations? get appL10n => AppLocalizations.of(this);
}
