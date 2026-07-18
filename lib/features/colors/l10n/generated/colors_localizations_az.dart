// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class ColorsLocalizationsAz extends ColorsLocalizations {
  ColorsLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get colorGameTitle => 'Rənglər';

  @override
  String get colorGameInstruction => 'Sözü oxu, sonra aşağıda uyğun rəngə toxun.';

  @override
  String get colorNameRed => 'Qırmızı';

  @override
  String get colorNameBlue => 'Mavi';

  @override
  String get colorNameGreen => 'Yaşıl';

  @override
  String get colorNameYellow => 'Sarı';

  @override
  String get colorNameOrange => 'Narıncı';

  @override
  String get colorNamePurple => 'Bənövşəyi';

  @override
  String get colorNamePink => 'Çəhrayı';

  @override
  String get colorNameCyan => 'Firuzəyi';

  @override
  String get colorNameBrown => 'Qəhvəyi';

  @override
  String get colorNameLime => 'Laym';

  @override
  String get colorNameTeal => 'Dəniz yaşılı';

  @override
  String get colorNameIndigo => 'İndiqo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Dəniz mavisi';

  @override
  String get colorNameCoral => 'Mərcan';

  @override
  String get colorNameGold => 'Qızılı';

  @override
  String get colorNameViolet => 'Bənövşəyi açıq';

  @override
  String get colorNameSky => 'Səma mavisi';

  @override
  String get colorChapterTitleBasics => 'Fəsil 1 · İlk rənglər';

  @override
  String get colorChapterTitleWide => 'Fəsil 2 · Daha çox rəng';

  @override
  String get colorChapterTitleMaster => 'Fəsil 3 · Rəng ustası';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Fəsil $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Səviyyə $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Yeni fəsil!';

  @override
  String get colorGameNextChapterBody => 'Yeni rənglər səni gözləyir.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Mərhələ $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need düzgün';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds san';
  }

  @override
  String get colorGameTimeUp => 'Vaxt bitdi!';

  @override
  String get colorGameNextStageTitle => 'Əla!';

  @override
  String get colorGameNextStageBody => 'Növbəti səviyyəyə hazırsan?';

  @override
  String get colorGameContinue => 'Davam';

  @override
  String get colorGameVictoryTitle => 'Mohtəşəm!';

  @override
  String get colorGameVictoryBody => 'Bütün fəsilləri bitirdin!';

  @override
  String get colorGamePlayAgain => 'Yenidən oyna';

  @override
  String get colorGameBack => 'Geri';

  @override
  String get colorFeedbackCorrect => 'Əla!';

  @override
  String get colorFeedbackWrong => 'Yenə dene';

  @override
  String get colorVisionHomeTitle => 'Rəng fiqurları';

  @override
  String get colorVisionHomeSubtitle => 'Əyləncəli skan';

  @override
  String get colorVisionIntroDisclaimer =>
      'Nöqtəli şəkillər rəngləri necə gördüyünüzü kəşf etməyə kömək edir. Bu tibbi bir test deyil. Narahatlığınız varsa göz həkiminə müraciət edin.';

  @override
  String get colorVisionStart => 'Gəlin oynayaq';

  @override
  String get colorVisionQuestion => 'Nöqtələr arasında hansı fiquru görürsünüz?';

  @override
  String get colorVisionOptionCircle => 'Dairə';

  @override
  String get colorVisionOptionSquare => 'Kvadrat';

  @override
  String get colorVisionOptionTriangle => 'Üçbucaq';

  @override
  String get colorVisionOptionNothing => 'Fiqur yoxdur';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Lövhə $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total doğru eşləşmə';
  }

  @override
  String get colorVisionResultsTitle => 'Tur bitdi!';

  @override
  String get colorVisionResultsGood => 'Fiqurların çoxunu tapdınız — əla!';

  @override
  String get colorVisionResultsMixed => 'Bəzi lövhələr çətin idi; bu uşaqlarda çox yaygındır.';

  @override
  String get colorVisionResultsLow =>
      'Bir çox fiquru görmək çətin oldu. Bu oyun rəng korluğu diaqnozu qoya bilməz.';

  @override
  String get colorVisionResultsMedicalNote => 'Yalnız öyrənmək və maraq üçündür.';

  @override
  String get colorVisionPlayAgain => 'Yenidən oyna';

  @override
  String get colorVisionIntroTitle => 'Gizli fiqurlar';

  @override
  String get colorVisionPlateBadgeRg => 'Qırmızı · yaşıl';

  @override
  String get colorVisionPlateBadgeBy => 'Mavi · sarı';

  @override
  String get colorVisionOptionDiamond => 'Almaz';

  @override
  String get colorVisionResultHintTitle => 'Əyləncəli xülasə';

  @override
  String get colorVisionProfileTypical => 'Cavablarınız tipik rəng görmə ilə uyğun görünür.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'Qırmızı-yaşıl tipli lövhələrdə daha çox çətinlik çəkdiniz.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'Mavi-sarı tipli lövhələrdə daha çox çətinlik çəkdiniz.';

  @override
  String get colorVisionProfileMixed =>
      'Hər iki növ lövhə çətin idi. Yaxşı işıqda yenidən yoxlayın.';

  @override
  String get colorVisionProfileInconclusive => 'Dəqiq bir nəticə çıxmadı — yenidən yoxlayın.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Qırmızı-yaşıl: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Mavi-sarı: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Oyun yüklənmədi. Yenidən cəhd edin.';

  @override
  String get colorFailurePalette => 'Rəng palitrası alınmadı.';

  @override
  String get colorFailureUnknown => 'Gözlənilməz bir xəta baş verdi.';
}
