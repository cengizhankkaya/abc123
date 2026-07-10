// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class HomeLocalizationsTr extends HomeLocalizations {
  HomeLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get hello => 'Merhaba';

  @override
  String get slogan => 'Çiz, Öğren, Eğlen!';

  @override
  String get seeTutorial => 'Öğreticiye bak';

  @override
  String get tutorial => 'Öğretici';

  @override
  String get points => 'Puan';

  @override
  String get streakDay => 'Gün';

  @override
  String get badgeFirstLoginName => 'İlk Adım';

  @override
  String get badgeFirstLoginDesc => 'Uygulamaya ilk kez giriş yaptın!';

  @override
  String get badgeFirstDrawName => 'Çizer Başlangıcı';

  @override
  String get badgeFirstDrawDesc => 'İlk çizimini tamamladın!';

  @override
  String get badgeStreak3Name => 'Azimli';

  @override
  String get badgeStreak3Desc => '3 gün üst üste geldin!';

  @override
  String get badgeStreak7Name => 'Haftanın Yıldızı';

  @override
  String get badgeStreak7Desc => '7 gün boyunca çalıştın!';

  @override
  String get badgeMasterArtistName => 'Usta Çizer';

  @override
  String get badgeMasterArtistDesc => '100 çizim yaptın!';

  @override
  String get badgeStreak30Name => 'Aylık Usta';

  @override
  String get badgeStreak30Desc => '30 gün boyunca düzenli geldin!';

  @override
  String get badgeBronzeArtistName => 'Bronz Kalem';

  @override
  String get badgeBronzeArtistDesc => '10 çizim yaptın!';

  @override
  String get badgeSilverArtistName => 'Gümüş Kalem';

  @override
  String get badgeSilverArtistDesc => '50 çizim yaptın!';

  @override
  String get badgeGoldArtistName => 'Altın Kalem';

  @override
  String get badgeGoldArtistDesc => '250 çizim yaptın!';

  @override
  String get badgeDiamondArtistName => 'Elmas Sanatçı';

  @override
  String get badgeDiamondArtistDesc => '500 çizim yaptın! İnanılmaz!';

  @override
  String get badgeEarlyBirdName => 'Sabah Şekeri';

  @override
  String get badgeEarlyBirdDesc => 'Sabah erkenden çalışmaya başladın!';

  @override
  String get badgeNightOwlName => 'Gece Kuşu';

  @override
  String get badgeNightOwlDesc => 'Gece geç saatte bile çalışıyorsun!';

  @override
  String get badgeWeekendWarriorName => 'Haftasonu Eğlencesi';

  @override
  String get badgeWeekendWarriorDesc => 'Haftasonunu öğrenerek geçiriyorsun!';

  @override
  String get badgeNumberMasterName => 'Sayı Ustası';

  @override
  String get badgeNumberMasterDesc => '50 sayı çizdin!';

  @override
  String get badgeLetterMasterName => 'Harf Uzmanı';

  @override
  String get badgeLetterMasterDesc => '50 harf çizdin!';

  @override
  String get badgeShapeMasterName => 'Şekil Sihirbazı';

  @override
  String get badgeShapeMasterDesc => '50 şekil çizdin!';

  @override
  String get badgeHighScorerName => 'Yüksek Skorer';

  @override
  String get badgeHighScorerDesc => '1000 puana ulaştın!';

  @override
  String get badgeScoreLegendName => 'Puan Efsanesi';

  @override
  String get badgeScoreLegendDesc => '5000 puana ulaştın!';

  @override
  String get badgeBadgeCollectorName => 'Rozet Koleksiyoncusu';

  @override
  String get badgeBadgeCollectorDesc => '5 rozet kazandın!';

  @override
  String get badgeBadgeMasterName => 'Rozet Ustası';

  @override
  String get badgeBadgeMasterDesc => '15 rozet kazandın!';

  @override
  String get shopTitle => 'MAĞAZA';

  @override
  String get shopScreenSubtitle => 'Avatarını özelleştir!';

  @override
  String get tabHat => 'Şapka';

  @override
  String get tabGlasses => 'Gözlük';

  @override
  String get tabOutfit => 'Kıyafet';

  @override
  String get owned => 'Senin';

  @override
  String get equipped => 'Giydin';

  @override
  String get shopSlotNone => 'Çıkar';

  @override
  String itemEquipped(String item) {
    return '$item giyildi!';
  }

  @override
  String itemUnequipped(String slot) {
    return '$slot çıkarıldı';
  }

  @override
  String get slotHat => 'Şapka';

  @override
  String get slotGlasses => 'Gözlük';

  @override
  String get slotOutfit => 'Kıyafet';

  @override
  String get insufficientPoints => 'Yeterli puanın yok! 😢';

  @override
  String get buyTitle => 'Satın Al?';

  @override
  String buyDescription(int price) {
    return '$price yıldız harcayarak bu eşyayı almak istiyor musun?';
  }

  @override
  String get noBtn => 'Hayır';

  @override
  String get yesBuyBtn => 'Evet, Al!';

  @override
  String itemBought(String item) {
    return '$item satın alındı! 🎉';
  }

  @override
  String get freePointsBtn => 'REKLAM İZLE PUAN KAZAN';

  @override
  String rewardEarned(int amount) {
    return 'Tebrikler! $amount Puan Kazandın! 🎉';
  }

  @override
  String get myQuestsTitle => 'GÖREVLERİM';

  @override
  String get questsScreenSubtitle => 'Görevleri tamamla, puan kazan!';

  @override
  String get questsDailySection => 'Günlük Görevler';

  @override
  String get questsWeeklySection => 'Haftalık Görevler';

  @override
  String get loadingQuests => 'Görevler yükleniyor...';

  @override
  String get dailyQuest => 'GÜNLÜK GÖREV';

  @override
  String get weeklyQuest => 'HAFTALIK GÖREV';

  @override
  String get hat_blue_cap => 'Mavi Şapka';

  @override
  String get hat_crown => 'Kral Tacı';

  @override
  String get hat_wizard => 'Büyücü Şapkası';

  @override
  String get hat_flower => 'Çiçekli Taç';

  @override
  String get hat_pirate => 'Korsan Şapkası';

  @override
  String get hat_chef => 'Aşçı Şapkası';

  @override
  String get glasses_sun => 'Güneş Gözlüğü';

  @override
  String get glasses_nerd => 'Bilgiç Gözlüğü';

  @override
  String get glasses_heart => 'Kalpli Gözlük';

  @override
  String get glasses_3d => '3D Gözlük';

  @override
  String get glasses_vr => 'VR Gözlüğü';

  @override
  String get glasses_ski => 'Kayak Gözlüğü';

  @override
  String get glasses_mask => 'Maske';

  @override
  String get glasses_reading => 'Okuma Gözlüğü';

  @override
  String get outfit_red => 'Kırmızı Tişört';

  @override
  String get outfit_super => 'Süper Kahraman';

  @override
  String get outfit_green => 'Yeşil Hoodie';

  @override
  String get outfit_doctor => 'Doktor Önlüğü';

  @override
  String get outfit_space => 'Uzay Kostümü';

  @override
  String get outfit_sports => 'Forma';

  @override
  String get outfit_police => 'Polis Üniforması';

  @override
  String get outfit_chef => 'Aşçı Önlüğü';

  @override
  String get outfit_winter => 'Kışlık Mont';

  @override
  String get outfit_tuxedo => 'Smokin';

  @override
  String get badgesTitle => 'ROZETLERİM';

  @override
  String get totalBadges => 'Toplam:';

  @override
  String get filterAll => 'TÜMÜ';

  @override
  String get filterEarned => 'KAZANILAN';

  @override
  String get filterLocked => 'BEKLEYEN';

  @override
  String get numbersTitle => 'Rakam Öğrenme';

  @override
  String get lettersTitle => 'Harf Öğrenme';

  @override
  String get shapesTitle => 'Şekil Öğrenme';

  @override
  String get colorsTitle => 'Renk Öğrenme';

  @override
  String get wordsTitle => 'Kelime Oluşturma';

  @override
  String get badgeColorMasterName => 'Renk Ustası';

  @override
  String get badgeColorMasterDesc => '50 renk turunu tamamladın!';

  @override
  String get badgeWordMasterName => 'Kelime Ustası';

  @override
  String get badgeWordMasterDesc => '50 kelime tamamladın!';

  @override
  String get questsRefreshedMessage => 'Görevler yenilendi.';

  @override
  String get noBadgesFound => 'Rozet bulunamadı';

  @override
  String homeGreetingWithName(String name) {
    return 'Merhaba, $name!';
  }

  @override
  String get homeSloganToday => 'Bugün ne öğrenelim?';

  @override
  String homeStreakDays(int count) {
    return '$count günlük seri';
  }

  @override
  String get homeLearningModes => 'Öğrenme Modları';

  @override
  String get numbersTitleShort => 'Rakamlar';

  @override
  String get lettersTitleShort => 'Harfler';

  @override
  String get shapesTitleShort => 'Şekiller';

  @override
  String get wordsTitleShort => 'Kelimeler';

  @override
  String get colorsTitleShort => 'Renkler';

  @override
  String get numbersSubtitle => '0–9 çiz';

  @override
  String get lettersSubtitle => 'A–Z çiz';

  @override
  String get shapesSubtitle => 'Yeni!';

  @override
  String get wordsSubtitle => 'Kelime çiz';

  @override
  String get colorsSubtitle => 'Oyna ve öğren';

  @override
  String homeWhereYouLeft(String label) {
    return 'Kaldığın yer: $label';
  }

  @override
  String homeStepsRemaining(int count) {
    return '$count adım kaldı';
  }

  @override
  String homeContinueNumber(String number) {
    return 'Rakam $number';
  }

  @override
  String homeContinueLetter(String letter) {
    return 'Harf $letter';
  }

  @override
  String homeContinueShape(String number) {
    return 'Şekil $number';
  }

  @override
  String get homeContinueWord => 'Kelimeler';

  @override
  String get homeContinueColor => 'Renkler';

  @override
  String get homeContinueColorVision => 'Renk Görüşü';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsChildName => 'İsim';

  @override
  String get settingsChildNameHint => 'Adını yaz';

  @override
  String get settingsSaveName => 'Kaydet';

  @override
  String get settingsNameSaved => 'İsim kaydedildi';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get badgesScreenTitle => 'Rozetlerim';

  @override
  String badgesEarnedOfTotal(int count, int total) {
    return '$count / $total rozet kazanıldı';
  }

  @override
  String badgesStreakDayCount(int count) {
    return '$count gün';
  }

  @override
  String get badgesStreakSubtitle => 'Üst üste çizim serisi';

  @override
  String get parentPanelTitle => 'Ebeveyn Paneli';

  @override
  String parentPanelWeeklyProgress(String name) {
    return '$name\'in bu haftaki ilerlemesi';
  }

  @override
  String get parentPanelWeeklyProgressNoName => 'Bu haftaki ilerleme';

  @override
  String get parentPanelStatDuration => 'SÜRE';

  @override
  String get parentPanelStatCompleted => 'TAMAMLANAN';

  @override
  String get parentPanelStatAccuracy => 'ORT. DOĞRULUK';

  @override
  String parentPanelDurationMinutes(int minutes) {
    return '${minutes}dk';
  }

  @override
  String parentPanelAccuracyPercent(int percent) {
    return '%$percent';
  }

  @override
  String get parentPanelChartTitle => 'Günlük çizim süresi';

  @override
  String parentPanelInsightLettersLearned(String range) {
    return 'Harf $range öğrenildi';
  }

  @override
  String parentPanelInsightNumberStruggling(int number) {
    return 'Rakam $number zorlanıyor';
  }

  @override
  String get parentPanelInsightGettingStarted => 'Öğrenme yolculuğu yeni başlıyor';

  @override
  String get parentPanelToday => 'Bugün';

  @override
  String get parentPanelYesterday => 'Dün';

  @override
  String get settingsParentPanel => 'Ebeveyn Paneli';

  @override
  String get settingsParentPanelSubtitle => 'İlerleme ve içgörüler';
}
