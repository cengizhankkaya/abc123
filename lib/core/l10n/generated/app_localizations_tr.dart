// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Rakam Tanıma Uygulaması';

  @override
  String get navHome => 'Ana sayfa';

  @override
  String get navQuests => 'Görevler';

  @override
  String get navShop => 'Mağaza';

  @override
  String get navBadges => 'Rozetler';

  @override
  String get tutorialScreenTitle => 'Abc123 Eğitim';

  @override
  String get tutorialRedirectMessage => 'YouTube videosuna yönlendiriliyorsunuz…';

  @override
  String get navMenuTooltip => 'Menü';

  @override
  String get tutorialHttpsOnlyMessage => 'Yalnızca güvenli (HTTPS) bağlantılar açılabilir.';

  @override
  String get tutorialOpenFailedMessage => 'Video açılamadı. Lütfen tekrar deneyin.';

  @override
  String navErrorPageNotFound(String uri) {
    return 'Sayfa bulunamadı:\n$uri';
  }

  @override
  String get routerInvalidResultData => 'Geçersiz sonuç verisi';

  @override
  String get routerInvalidInfoDrawData => 'Geçersiz bilgi ekranı verisi';

  @override
  String get adRewardPointEarned => 'Tebrikler! 1 puan kazandınız.';

  @override
  String get adLoadFailedRetry => 'Reklam yüklenemedi, lütfen tekrar deneyin.';

  @override
  String get themeModeTooltip => 'Görünüm';

  @override
  String get themeModeLight => 'Açık';

  @override
  String get themeModeDark => 'Koyu';

  @override
  String get themeModeSystem => 'Sisteme göre';
}
