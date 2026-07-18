// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ColorsLocalizationsAr extends ColorsLocalizations {
  ColorsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get colorGameTitle => 'الألوان';

  @override
  String get colorGameInstruction => 'اقرأ الكلمة ثم المس اللون الصحيح في الأسفل.';

  @override
  String get colorNameRed => 'أحمر';

  @override
  String get colorNameBlue => 'أزرق';

  @override
  String get colorNameGreen => 'أخضر';

  @override
  String get colorNameYellow => 'أصفر';

  @override
  String get colorNameOrange => 'برتقالي';

  @override
  String get colorNamePurple => 'بنفسجي';

  @override
  String get colorNamePink => 'وردي';

  @override
  String get colorNameCyan => 'سماوي';

  @override
  String get colorNameBrown => 'بني';

  @override
  String get colorNameLime => 'ليموني';

  @override
  String get colorNameTeal => 'تركوازي';

  @override
  String get colorNameIndigo => 'نيلي';

  @override
  String get colorNameMagenta => 'أرجواني';

  @override
  String get colorNameNavy => 'كحلي';

  @override
  String get colorNameCoral => 'مرجاني';

  @override
  String get colorNameGold => 'ذهبي';

  @override
  String get colorNameViolet => 'بنفسجي فاتح';

  @override
  String get colorNameSky => 'أزرق سماوي';

  @override
  String get colorChapterTitleBasics => 'الفصل 1 · الألوان الأولى';

  @override
  String get colorChapterTitleWide => 'الفصل 2 · المزيد من الألوان';

  @override
  String get colorChapterTitleMaster => 'الفصل 3 · سيد الألوان';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'الفصل $current من $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'المستوى $current من $total';
  }

  @override
  String get colorGameNextChapterTitle => 'فصل جديد!';

  @override
  String get colorGameNextChapterBody => 'ألوان جديدة في انتظارك.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'المرحلة $current من $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done من $need صحيح';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds ث';
  }

  @override
  String get colorGameTimeUp => 'انتهى الوقت!';

  @override
  String get colorGameNextStageTitle => 'رائع!';

  @override
  String get colorGameNextStageBody => 'هل أنت مستعد للمستوى التالي؟';

  @override
  String get colorGameContinue => 'متابعة';

  @override
  String get colorGameVictoryTitle => 'مذهل!';

  @override
  String get colorGameVictoryBody => 'أكملت كل الفصول!';

  @override
  String get colorGamePlayAgain => 'العب مجددًا';

  @override
  String get colorGameBack => 'رجوع';

  @override
  String get colorFeedbackCorrect => 'رائع!';

  @override
  String get colorFeedbackWrong => 'حاول مرة أخرى';

  @override
  String get colorVisionHomeTitle => 'أشكال الألوان';

  @override
  String get colorVisionHomeSubtitle => 'مسح ممتع';

  @override
  String get colorVisionIntroDisclaimer =>
      'تساعدك صور النقاط على اكتشاف كيفية رؤيتك للألوان. هذا ليس اختبارًا طبيًا.';

  @override
  String get colorVisionStart => 'هيا نلعب';

  @override
  String get colorVisionQuestion => 'ما الشكل الذي تراه بين النقاط؟';

  @override
  String get colorVisionOptionCircle => 'دائرة';

  @override
  String get colorVisionOptionSquare => 'مربع';

  @override
  String get colorVisionOptionTriangle => 'مثلث';

  @override
  String get colorVisionOptionNothing => 'لا يوجد شكل';

  @override
  String colorVisionProgress(int current, int total) {
    return 'لوحة $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total صحيح';
  }

  @override
  String get colorVisionResultsTitle => 'انتهت الجولة!';

  @override
  String get colorVisionResultsGood => 'لقد وجدت معظم الأشكال — رائع!';

  @override
  String get colorVisionResultsMixed => 'كانت بعض اللوحات صعبة؛ هذا شائع جدًا عند الأطفال.';

  @override
  String get colorVisionResultsLow =>
      'كان من الصعب رؤية العديد من الأشكال. هذه اللعبة لا تشخص عمى الألوان.';

  @override
  String get colorVisionResultsMedicalNote => 'للتعلم والفضول فقط.';

  @override
  String get colorVisionPlayAgain => 'العب مرة أخرى';

  @override
  String get colorVisionIntroTitle => 'أشكال مخفية';

  @override
  String get colorVisionPlateBadgeRg => 'أحمر · أخضر';

  @override
  String get colorVisionPlateBadgeBy => 'أزرق · أصفر';

  @override
  String get colorVisionOptionDiamond => 'ماسة';

  @override
  String get colorVisionResultHintTitle => 'ملخص ممتع';

  @override
  String get colorVisionProfileTypical => 'يبدو أن إجاباتك تتماشى مع الرؤية النموذجية للألوان.';

  @override
  String get colorVisionProfileRedGreenAxis => 'لقد فاتتك المزيد من لوحات النمط الأحمر والأخضر.';

  @override
  String get colorVisionProfileBlueYellowAxis => 'لقد فاتتك المزيد من لوحات النمط الأزرق والأصفر.';

  @override
  String get colorVisionProfileMixed =>
      'كان كلا النوعين من اللوحات صعبًا. حاول مرة أخرى في ضوء جيد.';

  @override
  String get colorVisionProfileInconclusive => 'لا يوجد نمط واضح — حاول مرة أخرى.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'النمط الأحمر والأخضر: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'النمط الأزرق والأصفر: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'فشل تحميل اللعبة.';

  @override
  String get colorFailurePalette => 'تعذر جلب لوحة الألوان.';

  @override
  String get colorFailureUnknown => 'حدث خطأ غير متوقع.';
}
