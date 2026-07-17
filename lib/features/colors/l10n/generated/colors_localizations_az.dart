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
  String get colorVisionHomeTitle => 'Color shapes';

  @override
  String get colorVisionHomeSubtitle => 'Playful screening';

  @override
  String get colorVisionIntroDisclaimer =>
      'Dotted pictures like gentle puzzles help explore how you see colors. This is not a medical test. Ask an eye doctor if you have concerns.';

  @override
  String get colorVisionStart => 'Let\'s play';

  @override
  String get colorVisionQuestion => 'Which shape do you see in the dots?';

  @override
  String get colorVisionOptionCircle => 'Circle';

  @override
  String get colorVisionOptionSquare => 'Square';

  @override
  String get colorVisionOptionTriangle => 'Triangle';

  @override
  String get colorVisionOptionNothing => 'No shape';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Plate $current of $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct of $total matched';
  }

  @override
  String get colorVisionResultsTitle => 'Round complete!';

  @override
  String get colorVisionResultsGood => 'You spotted most shapes — nice!';

  @override
  String get colorVisionResultsMixed => 'Some plates were tricky. That happens to many kids.';

  @override
  String get colorVisionResultsLow =>
      'Many shapes were hard to see. This game cannot diagnose color vision. A specialist can help if you are worried.';

  @override
  String get colorVisionResultsMedicalNote =>
      'For learning and curiosity only. It does not replace professional eye care.';

  @override
  String get colorVisionPlayAgain => 'Play again';

  @override
  String get colorVisionIntroTitle => 'Hidden shapes';

  @override
  String get colorVisionPlateBadgeRg => 'Red · green mix';

  @override
  String get colorVisionPlateBadgeBy => 'Blue · yellow mix';

  @override
  String get colorVisionOptionDiamond => 'Diamond';

  @override
  String get colorVisionResultHintTitle => 'Playful summary';

  @override
  String get colorVisionProfileTypical =>
      'On these plates your answers look similar to typical color vision for kids.';

  @override
  String get colorVisionProfileRedGreenAxis =>
      'You missed more red–green style plates. That pattern is often discussed with red–green color blindness (protanopia or deuteranopia family). This app cannot separate those types.';

  @override
  String get colorVisionProfileBlueYellowAxis =>
      'You missed more blue–yellow style plates. That can sometimes relate to blue–yellow (tritan-type) difficulty — only an eye specialist can say for sure.';

  @override
  String get colorVisionProfileMixed =>
      'Both plate styles were difficult. Screen brightness, night mode, or tired eyes can change scores. Try again in good light.';

  @override
  String get colorVisionProfileInconclusive =>
      'No clear pattern — try again on a bright screen at arm’s length.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Red–green style: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Blue–yellow style: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Oyun yüklənə bilmədi. Zəhmət olmasa yenidən cəhd edin.';

  @override
  String get colorFailurePalette => 'Rəng palitrasını almaq mümkün olmadı.';

  @override
  String get colorFailureUnknown => 'Gözlənilməz bir xəta baş verdi.';
}
