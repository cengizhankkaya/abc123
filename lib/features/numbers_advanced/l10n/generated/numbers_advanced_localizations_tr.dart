// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'numbers_advanced_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class NumbersAdvancedLocalizationsTr extends NumbersAdvancedLocalizations {
  NumbersAdvancedLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get mathHubTitle => 'Matematik Macerası';

  @override
  String get mathHubSubtitle => 'Pratik yapmak için bir konu seç';

  @override
  String get mathHubTensTitle => 'Onluklar';

  @override
  String get mathHubTensSubtitle => '10, 20, 30 … 100';

  @override
  String get mathHubFreeTitle => 'Serbest Pratik';

  @override
  String get mathHubFreeSubtitle => '2 basamaklı sayılar';

  @override
  String get mathHubVisualTitle => 'Görsel Toplama';

  @override
  String get mathHubVisualSubtitle => 'Say ve yaz';

  @override
  String get mathHubSymbolicTitle => 'Toplama-Çıkarma';

  @override
  String get mathHubSymbolicSubtitle => 'A, B, C seviyeleri';

  @override
  String get mathSelectTensTitle => 'Bir Onluk Sayı Seç';

  @override
  String mathDrawTensInstruction(int number) {
    return 'Kutulara $number sayısını çiz';
  }

  @override
  String mathFreePracticeInstruction(int number) {
    return '$number sayısını çizin';
  }

  @override
  String get mathVisualInstruction => 'Nesneleri say ve toplamı yaz';

  @override
  String get mathSymbolicInstruction => 'Sonucu hesapla ve yaz';

  @override
  String get mathTensBox => 'Onlar';

  @override
  String get mathUnitsBox => 'Birler';

  @override
  String get mathCheckButton => 'Kontrol Et';

  @override
  String get mathNextButton => 'İleri';

  @override
  String get mathCorrect => 'Doğru! 🎉';

  @override
  String get mathWrong => 'Tekrar Dene!';

  @override
  String get mathHintVisible => 'İpucu Açık';

  @override
  String get mathHintHidden => 'İpucu Kapalı';

  @override
  String get mathLevelLocked => 'Önceki seviyeyi %80 tamamlayın';

  @override
  String mathLevelProgress(int correct, int total, int percent) {
    return '$total soruda $correct doğru (%$percent)';
  }

  @override
  String get mathLevelA => 'Seviye A';

  @override
  String get mathLevelB => 'Seviye B';

  @override
  String get mathLevelC => 'Seviye C';

  @override
  String get mathLevelADesc => 'Sonuç ≤ 10';

  @override
  String get mathLevelBDesc => 'Sonuç ≤ 20';

  @override
  String get mathLevelCDesc => 'İki basamaklı, taşımasız';

  @override
  String get mathClearButton => 'Temizle';

  @override
  String get mathEmptyDrawingWarning => 'Önce kutuya bir şeyler çizin';

  @override
  String get mathParentSectionTitle => 'Matematik İlerlemesi';

  @override
  String get mathParentAdditions => 'Çözülen toplama';

  @override
  String get mathParentSubtractions => 'Çözülen çıkarma';

  @override
  String get mathParentTens => 'Uygulanan onluk';

  @override
  String get mathParentSuggest => 'Çıkarma pratiğine devam edin!';

  @override
  String get badgeMathFirstAdditionName => 'İlk Toplama!';

  @override
  String get badgeMathFirstAdditionDesc => 'İlk toplamayı çözdün!';

  @override
  String get badgeTensHeroName => 'Onluklar Kahramanı';

  @override
  String get badgeTensHeroDesc => 'Tüm onluk sayıları egzersiz yaptın!';

  @override
  String get badgeSubtractionMasterName => 'Çıkarma Ustası';

  @override
  String get badgeSubtractionMasterDesc => '20 çıkarma işlemi çözdün!';

  @override
  String get mathAdvancedHomeTitle => 'Toplama-Çıkarma';

  @override
  String get mathAdvancedHomeSubtitle => 'Matematik macerası';
}
