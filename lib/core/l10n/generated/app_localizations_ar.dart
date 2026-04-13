// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Number Learning App';

  @override
  String get navHome => 'Home';

  @override
  String get navQuests => 'Quests';

  @override
  String get navShop => 'Shop';

  @override
  String get navBadges => 'Badges';

  @override
  String get tutorialScreenTitle => 'Tutorial';

  @override
  String get tutorialRedirectMessage => 'Opening YouTube…';

  @override
  String get navMenuTooltip => 'Menu';

  @override
  String get tutorialHttpsOnlyMessage => 'Only secure (HTTPS) links can be opened.';

  @override
  String get tutorialOpenFailedMessage => 'Could not open the video. Please try again.';

  @override
  String navErrorPageNotFound(String uri) {
    return 'Page not found:\n$uri';
  }

  @override
  String get routerInvalidResultData => 'Invalid result data';

  @override
  String get routerInvalidInfoDrawData => 'Invalid info screen data';

  @override
  String get adRewardPointEarned => 'Congratulations! You earned 1 point.';

  @override
  String get adLoadFailedRetry => 'Ad could not be loaded. Please try again.';

  @override
  String get themeModeTooltip => 'Theme';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeSystem => 'System default';
}
