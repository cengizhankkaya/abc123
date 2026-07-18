// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class ColorsLocalizationsHi extends ColorsLocalizations {
  ColorsLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get colorGameTitle => 'रंग';

  @override
  String get colorGameInstruction => 'शब्द पढ़ो, फिर नीचे सही रंग पर टैप करो।';

  @override
  String get colorNameRed => 'लाल';

  @override
  String get colorNameBlue => 'नीला';

  @override
  String get colorNameGreen => 'हरा';

  @override
  String get colorNameYellow => 'पीला';

  @override
  String get colorNameOrange => 'नारंगी';

  @override
  String get colorNamePurple => 'बैंगनी';

  @override
  String get colorNamePink => 'गुलाबी';

  @override
  String get colorNameCyan => 'सियान';

  @override
  String get colorNameBrown => 'भूरा';

  @override
  String get colorNameLime => 'नींबू हरा';

  @override
  String get colorNameTeal => 'टील';

  @override
  String get colorNameIndigo => 'इंडिगो';

  @override
  String get colorNameMagenta => 'मैजेंटा';

  @override
  String get colorNameNavy => 'नेवी';

  @override
  String get colorNameCoral => 'कोरल';

  @override
  String get colorNameGold => 'सुनहरा';

  @override
  String get colorNameViolet => 'वायलेट';

  @override
  String get colorNameSky => 'आसमानी';

  @override
  String get colorChapterTitleBasics => 'अध्याय 1 · पहले रंग';

  @override
  String get colorChapterTitleWide => 'अध्याय 2 · और रंग';

  @override
  String get colorChapterTitleMaster => 'अध्याय 3 · रंग मास्टर';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'अध्याय $current / $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'स्तर $current / $total';
  }

  @override
  String get colorGameNextChapterTitle => 'नया अध्याय!';

  @override
  String get colorGameNextChapterBody => 'नए रंग इंतज़ार में हैं।';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'चरण $current / $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done / $need सही';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '$seconds से';
  }

  @override
  String get colorGameTimeUp => 'समय खत्म!';

  @override
  String get colorGameNextStageTitle => 'शाबाश!';

  @override
  String get colorGameNextStageBody => 'अगले स्तर के लिए तैयार?';

  @override
  String get colorGameContinue => 'आगे';

  @override
  String get colorGameVictoryTitle => 'कमाल!';

  @override
  String get colorGameVictoryBody => 'सभी अध्याय पूरे!';

  @override
  String get colorGamePlayAgain => 'फिर खेलें';

  @override
  String get colorGameBack => 'वापस';

  @override
  String get colorFeedbackCorrect => 'शाबाश!';

  @override
  String get colorFeedbackWrong => 'फिर कोशिश करो';

  @override
  String get colorVisionHomeTitle => 'रंग आकृतियाँ';

  @override
  String get colorVisionHomeSubtitle => 'मज़ेदार स्कैन';

  @override
  String get colorVisionIntroDisclaimer =>
      'डॉट चित्र यह जानने में मदद करते हैं कि आप रंग कैसे देखते हैं। यह कोई चिकित्सा परीक्षण नहीं है।';

  @override
  String get colorVisionStart => 'चलो खेलें';

  @override
  String get colorVisionQuestion => 'बिंदुओं के बीच आप कौन सी आकृति देखते हैं?';

  @override
  String get colorVisionOptionCircle => 'वृत्त';

  @override
  String get colorVisionOptionSquare => 'वर्ग';

  @override
  String get colorVisionOptionTriangle => 'त्रिभुज';

  @override
  String get colorVisionOptionNothing => 'कोई आकृति नहीं';

  @override
  String colorVisionProgress(int current, int total) {
    return 'प्लेट $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total सही';
  }

  @override
  String get colorVisionResultsTitle => 'राउंड समाप्त!';

  @override
  String get colorVisionResultsGood => 'आपको अधिकांश आकृतियाँ मिल गईं — बढ़िया!';

  @override
  String get colorVisionResultsMixed => 'कुछ प्लेटें कठिन थीं; यह बच्चों में बहुत आम है।';

  @override
  String get colorVisionResultsLow =>
      'कई आकृतियों को देखना कठिन था। यह खेल रंग अंधापन का निदान नहीं कर सकता।';

  @override
  String get colorVisionResultsMedicalNote => 'केवल सीखने और जिज्ञासा के लिए।';

  @override
  String get colorVisionPlayAgain => 'फिर से खेलें';

  @override
  String get colorVisionIntroTitle => 'छिपी हुई आकृतियाँ';

  @override
  String get colorVisionPlateBadgeRg => 'लाल · हरा';

  @override
  String get colorVisionPlateBadgeBy => 'नीला · पीला';

  @override
  String get colorVisionOptionDiamond => 'हीरा';

  @override
  String get colorVisionResultHintTitle => 'मज़ेदार सारांश';

  @override
  String get colorVisionProfileTypical =>
      'आपके उत्तर सामान्य रंग दृष्टि के अनुरूप प्रतीत होते हैं।';

  @override
  String get colorVisionProfileRedGreenAxis => 'आपसे लाल-हरी शैली की अधिक प्लेटें छूट गईं।';

  @override
  String get colorVisionProfileBlueYellowAxis => 'आपसे नीली-पीली शैली की अधिक प्लेटें छूट गईं।';

  @override
  String get colorVisionProfileMixed =>
      'दोनों प्रकार की प्लेटें कठिन थीं। अच्छी रोशनी में फिर से प्रयास करें।';

  @override
  String get colorVisionProfileInconclusive => 'कोई स्पष्ट पैटर्न नहीं — फिर से प्रयास करें।';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'लाल-हरा: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'नीला-पीला: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'गेम लोड करने में विफल।';

  @override
  String get colorFailurePalette => 'रंग पैलेट प्राप्त नहीं किया जा सका।';

  @override
  String get colorFailureUnknown => 'एक अप्रत्याशित त्रुटि हुई।';
}
