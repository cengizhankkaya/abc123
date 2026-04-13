import 'package:abc123/features/home/l10n/generated/home_localizations.dart';
import 'package:flutter/widgets.dart';

extension HomeLocalizationsX on BuildContext {
  HomeLocalizations? get homeL10n => HomeLocalizations.of(this);
}
