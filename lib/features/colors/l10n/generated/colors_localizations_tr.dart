// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class ColorsLocalizationsTr extends ColorsLocalizations {
  ColorsLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get colorGameTitle => 'Renkler';

  @override
  String get colorGameInstruction => 'Kelimeyi oku, aşağıda doğru renge dokun.';

  @override
  String get colorNameRed => 'Kırmızı';

  @override
  String get colorNameBlue => 'Mavi';

  @override
  String get colorNameGreen => 'Yeşil';

  @override
  String get colorNameYellow => 'Sarı';

  @override
  String get colorNameOrange => 'Turuncu';

  @override
  String get colorNamePurple => 'Mor';

  @override
  String get colorNamePink => 'Pembe';

  @override
  String get colorNameCyan => 'Camgöbeği';

  @override
  String get colorNameBrown => 'Kahverengi';

  @override
  String get colorNameLime => 'Limon yeşili';

  @override
  String get colorNameTeal => 'Petrol mavisi';

  @override
  String get colorNameIndigo => 'İndigo';

  @override
  String get colorNameMagenta => 'Macenta';

  @override
  String get colorNameNavy => 'Lacivert';

  @override
  String get colorNameCoral => 'Mercan';

  @override
  String get colorNameGold => 'Altın sarısı';

  @override
  String get colorNameViolet => 'Eflatun';

  @override
  String get colorNameSky => 'Gök mavisi';

  @override
  String get colorChapterTitleBasics => 'Bölüm 1 · İlk renkler';

  @override
  String get colorChapterTitleWide => 'Bölüm 2 · Daha çok renk';

  @override
  String get colorChapterTitleMaster => 'Bölüm 3 · Renk ustası';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Kısım $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Seviye $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Yeni bölüm!';

  @override
  String get colorGameNextChapterBody => 'Yeni renkler seni bekliyor.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Aşama $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need doğru';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds sn';
  }

  @override
  String get colorGameTimeUp => 'Süre doldu!';

  @override
  String get colorGameNextStageTitle => 'Süper!';

  @override
  String get colorGameNextStageBody => 'Sıradaki seviyeye hazır mısın?';

  @override
  String get colorGameContinue => 'Devam';

  @override
  String get colorGameVictoryTitle => 'Harikasın!';

  @override
  String get colorGameVictoryBody => 'Tüm bölümleri tamamladın!';

  @override
  String get colorGamePlayAgain => 'Yeniden oyna';

  @override
  String get colorGameBack => 'Geri';

  @override
  String get colorFeedbackCorrect => 'Harika!';

  @override
  String get colorFeedbackWrong => 'Bir daha dene';

  @override
  String get colorVisionHomeTitle => 'Renk şekilleri';

  @override
  String get colorVisionHomeSubtitle => 'Eğlenceli tarama';

  @override
  String get colorVisionIntroDisclaimer =>
      'Noktalı resimler, renkleri nasıl gördüğünü keşfetmene yardım eder. Bu bir tıbbi test değildir. Merakın veya endişen varsa bir göz hekimine danış.';

  @override
  String get colorVisionStart => 'Hadi oynayalım';

  @override
  String get colorVisionQuestion => 'Noktaların arasında hangi şekli görüyorsun?';

  @override
  String get colorVisionOptionCircle => 'Daire';

  @override
  String get colorVisionOptionSquare => 'Kare';

  @override
  String get colorVisionOptionTriangle => 'Üçgen';

  @override
  String get colorVisionOptionNothing => 'Şekil yok';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Levha $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total doğru eşleşme';
  }

  @override
  String get colorVisionResultsTitle => 'Tur bitti!';

  @override
  String get colorVisionResultsGood => 'Çoğu şekli buldun — harika!';

  @override
  String get colorVisionResultsMixed =>
      'Bazı levhalar zordu; bu çocuklarda çok yaygındır.';

  @override
  String get colorVisionResultsLow =>
      'Birçok şekli görmek zor oldu. Bu oyun renk körlüğü tanısı koyamaz. Endişeleniyorsan bir uzmana danış.';

  @override
  String get colorVisionResultsMedicalNote =>
      'Yalnızca öğrenme ve merak içindir; profesyonel göz bakımının yerini tutmaz.';

  @override
  String get colorVisionPlayAgain => 'Yeniden oyna';

  @override
  String get colorVisionIntroTitle => 'Gizli şekiller';

  @override
  String get colorVisionPlateBadgeRg => 'Kırmızı · yeşil karışım';

  @override
  String get colorVisionPlateBadgeBy => 'Mavi · sarı karışım';

  @override
  String get colorVisionOptionDiamond => 'Elmas';

  @override
  String get colorVisionResultHintTitle => 'Eğlenceli özet';

  @override
  String get colorVisionProfileTypical =>
      'Bu levhalar için cevapların çoğu çocuklarda tipik renk görme ile uyumlu görünüyor.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'Kırmızı–yeşil tarzı levhaları daha çok kaçırdın. Bu desen genelde kırmızı–yeşil renk körlüğü (protanopi veya deuteranopi ailesi) ile konuşulur; bu uygulama ikisini ayırt edemez.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'Mavi–sarı tarzı levhaları daha çok kaçırdın. Bu bazen mavi–sarı (tritan tipi) zorlukla ilişkilendirilir; kesin söyleyebilen yalnızca bir göz uzmanıdır.';

  @override
  String get colorVisionProfileMixed =>
      'Her iki levha türü de zordu. Parlaklık, gece modu veya yorgunluk sonucu etkileyebilir. İyi ışıkta yeniden dene.';

  @override
  String get colorVisionProfileInconclusive =>
      'Net bir desen çıkmadı — parlak ekranda, kol mesafesinde yeniden dene.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Kırmızı–yeşil tarzı: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Mavi–sarı tarzı: $correct / $total';
  }
}
