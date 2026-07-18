// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class ColorsLocalizationsUr extends ColorsLocalizations {
  ColorsLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get colorGameTitle => 'رنگ';

  @override
  String get colorGameInstruction => 'لفظ پڑھو، پھر نیچے صحیح رنگ پر تھپتھپاؤ۔';

  @override
  String get colorNameRed => 'سرخ';

  @override
  String get colorNameBlue => 'نیلا';

  @override
  String get colorNameGreen => 'سبز';

  @override
  String get colorNameYellow => 'پیلا';

  @override
  String get colorNameOrange => 'نارنجی';

  @override
  String get colorNamePurple => 'جامنی';

  @override
  String get colorNamePink => 'گلابی';

  @override
  String get colorNameCyan => 'فیروزی';

  @override
  String get colorNameBrown => 'بھورا';

  @override
  String get colorNameLime => 'لیموں';

  @override
  String get colorNameTeal => 'سمندری';

  @override
  String get colorNameIndigo => 'انڈگو';

  @override
  String get colorNameMagenta => 'میجنٹا';

  @override
  String get colorNameNavy => 'نیوی';

  @override
  String get colorNameCoral => 'مرجان';

  @override
  String get colorNameGold => 'سنہرا';

  @override
  String get colorNameViolet => 'بنفشی';

  @override
  String get colorNameSky => 'آسمانی';

  @override
  String get colorChapterTitleBasics => 'باب 1 · پہلے رنگ';

  @override
  String get colorChapterTitleWide => 'باب 2 · مزید رنگ';

  @override
  String get colorChapterTitleMaster => 'باب 3 · رنگ کا استاد';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'باب $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'مرحلہ $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'نیا باب!';

  @override
  String get colorGameNextChapterBody => 'نئے رنگ منتظر ہیں۔';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'مرحلہ $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need درست';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds س';
  }

  @override
  String get colorGameTimeUp => 'وقت ختم!';

  @override
  String get colorGameNextStageTitle => 'بہترین!';

  @override
  String get colorGameNextStageBody => 'اگلے مرحلے کے لیے تیار؟';

  @override
  String get colorGameContinue => 'جاری رکھیں';

  @override
  String get colorGameVictoryTitle => 'زبردست!';

  @override
  String get colorGameVictoryBody => 'تمام باب مکمل!';

  @override
  String get colorGamePlayAgain => 'دوبارہ کھیلیں';

  @override
  String get colorGameBack => 'واپس';

  @override
  String get colorFeedbackCorrect => 'بہترین!';

  @override
  String get colorFeedbackWrong => 'دوبارہ کوشش کرو';

  @override
  String get colorVisionHomeTitle => 'رنگوں کی اشکال';

  @override
  String get colorVisionHomeSubtitle => 'مزے دار اسکین';

  @override
  String get colorVisionIntroDisclaimer =>
      'نقطوں والی تصاویر سے پتہ چلتا ہے کہ آپ رنگ کیسے دیکھتے ہیں۔ یہ کوئی طبی ٹیسٹ نہیں ہے۔';

  @override
  String get colorVisionStart => 'آئیں کھیلیں';

  @override
  String get colorVisionQuestion => 'آپ کو نقطوں کے درمیان کون سی شکل نظر آتی ہے؟';

  @override
  String get colorVisionOptionCircle => 'دائرہ';

  @override
  String get colorVisionOptionSquare => 'مربع';

  @override
  String get colorVisionOptionTriangle => 'مثلث';

  @override
  String get colorVisionOptionNothing => 'کوئی شکل نہیں';

  @override
  String colorVisionProgress(int current, int total) {
    return 'پلیٹ $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total درست';
  }

  @override
  String get colorVisionResultsTitle => 'راؤنڈ ختم!';

  @override
  String get colorVisionResultsGood => 'آپ نے زیادہ تر اشکال تلاش کر لیں — زبردست!';

  @override
  String get colorVisionResultsMixed => 'کچھ پلیٹیں مشکل تھیں؛ بچوں میں یہ بہت عام ہے۔';

  @override
  String get colorVisionResultsLow =>
      'بہت سی اشکال دیکھنا مشکل تھا۔ یہ گیم کلر بلائنڈنس کی تشخیص نہیں کر سکتی۔';

  @override
  String get colorVisionResultsMedicalNote => 'صرف سیکھنے اور تجسس کے لیے۔';

  @override
  String get colorVisionPlayAgain => 'دوبارہ کھیلیں';

  @override
  String get colorVisionIntroTitle => 'چھپی ہوئی اشکال';

  @override
  String get colorVisionPlateBadgeRg => 'سرخ · سبز';

  @override
  String get colorVisionPlateBadgeBy => 'نیلا · پیلا';

  @override
  String get colorVisionOptionDiamond => 'ہیرا';

  @override
  String get colorVisionResultHintTitle => 'مزے دار خلاصہ';

  @override
  String get colorVisionProfileTypical => 'آپ کے جوابات عام رنگ کی بصارت کے مطابق ہیں۔';

  @override
  String get colorVisionProfileRedGreenAxis => 'آپ نے سرخ-سبز قسم کی پلیٹیں زیادہ چھوڑ دیں۔';

  @override
  String get colorVisionProfileBlueYellowAxis => 'آپ نے نیلی-پیلی قسم کی پلیٹیں زیادہ چھوڑ دیں۔';

  @override
  String get colorVisionProfileMixed =>
      'دونوں قسم کی پلیٹیں مشکل تھیں۔ اچھی روشنی میں دوبارہ کوشش کریں۔';

  @override
  String get colorVisionProfileInconclusive => 'کوئی واضح پیٹرن نہیں — دوبارہ کوشش کریں۔';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'سرخ-سبز: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'نیلا-پیلا: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'گیم لوڈ کرنے میں ناکام۔';

  @override
  String get colorFailurePalette => 'رنگوں کا پیلیٹ حاصل نہیں کیا جا سکا۔';

  @override
  String get colorFailureUnknown => 'ایک غیر متوقع خربی پیش آگئی۔';
}
