import 'package:abc123/features/draw/l10n/generated/draw_localizations.dart';
import 'package:flutter/widgets.dart';

extension DrawLocalizationsX on BuildContext {
  DrawLocalizations? get drawL10n => DrawLocalizations.of(this);
}
