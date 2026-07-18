// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'colors_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class ColorsLocalizationsDe extends ColorsLocalizations {
  ColorsLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get colorGameTitle => 'Farben';

  @override
  String get colorGameInstruction => 'Lies das Wort und tippe dann unten auf die passende Farbe.';

  @override
  String get colorNameRed => 'Rot';

  @override
  String get colorNameBlue => 'Blau';

  @override
  String get colorNameGreen => 'Grün';

  @override
  String get colorNameYellow => 'Gelb';

  @override
  String get colorNameOrange => 'Orange';

  @override
  String get colorNamePurple => 'Lila';

  @override
  String get colorNamePink => 'Rosa';

  @override
  String get colorNameCyan => 'Cyan';

  @override
  String get colorNameBrown => 'Braun';

  @override
  String get colorNameLime => 'Limette';

  @override
  String get colorNameTeal => 'Petrol';

  @override
  String get colorNameIndigo => 'Indigo';

  @override
  String get colorNameMagenta => 'Magenta';

  @override
  String get colorNameNavy => 'Marineblau';

  @override
  String get colorNameCoral => 'Koralle';

  @override
  String get colorNameGold => 'Goldgelb';

  @override
  String get colorNameViolet => 'Violett';

  @override
  String get colorNameSky => 'Himmelblau';

  @override
  String get colorChapterTitleBasics => 'Kapitel 1 · Erste Farben';

  @override
  String get colorChapterTitleWide => 'Kapitel 2 · Mehr Farben';

  @override
  String get colorChapterTitleMaster => 'Kapitel 3 · Farben-Profi';

  @override
  String colorGameChapterProgress(int current, int total) {
    return 'Kapitel $current von $total';
  }

  @override
  String colorGameLevelProgress(int current, int total) {
    return 'Level $current von $total';
  }

  @override
  String get colorGameNextChapterTitle => 'Neues Kapitel!';

  @override
  String get colorGameNextChapterBody => 'Neue Farben warten auf dich.';

  @override
  String colorGameStageProgress(int current, int total) {
    return 'Stufe $current von $total';
  }

  @override
  String colorGameRoundProgress(int done, int need) {
    return '$done von $need richtig';
  }

  @override
  String colorGameTimeLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get colorGameTimeUp => 'Zeit ist um!';

  @override
  String get colorGameNextStageTitle => 'Super!';

  @override
  String get colorGameNextStageBody => 'Bereit für das nächste Level?';

  @override
  String get colorGameContinue => 'Weiter';

  @override
  String get colorGameVictoryTitle => 'Fantastisch!';

  @override
  String get colorGameVictoryBody => 'Du hast alle Kapitel geschafft!';

  @override
  String get colorGamePlayAgain => 'Nochmal spielen';

  @override
  String get colorGameBack => 'Zurück';

  @override
  String get colorFeedbackCorrect => 'Super!';

  @override
  String get colorFeedbackWrong => 'Nochmal';

  @override
  String get colorVisionHomeTitle => 'Farbformen';

  @override
  String get colorVisionHomeSubtitle => 'Spaß-Scan';

  @override
  String get colorVisionIntroDisclaimer =>
      'Punktbilder helfen zu entdecken, wie du Farben siehst. Dies ist kein medizinischer Test. Bei Bedenken wende dich an einen Augenarzt.';

  @override
  String get colorVisionStart => 'Lass uns spielen';

  @override
  String get colorVisionQuestion => 'Welche Form siehst du in den Punkten?';

  @override
  String get colorVisionOptionCircle => 'Kreis';

  @override
  String get colorVisionOptionSquare => 'Quadrat';

  @override
  String get colorVisionOptionTriangle => 'Dreieck';

  @override
  String get colorVisionOptionNothing => 'Keine Form';

  @override
  String colorVisionProgress(int current, int total) {
    return 'Tafel $current / $total';
  }

  @override
  String colorVisionScoreLine(int correct, int total) {
    return '$correct / $total richtige';
  }

  @override
  String get colorVisionResultsTitle => 'Runde beendet!';

  @override
  String get colorVisionResultsGood => 'Du hast die meisten Formen gefunden — toll!';

  @override
  String get colorVisionResultsMixed =>
      'Einige Tafeln waren knifflig; das ist sehr häufig bei Kindern.';

  @override
  String get colorVisionResultsLow =>
      'Viele Formen waren schwer zu sehen. Dieses Spiel kann keine Farbenblindheit diagnostizieren.';

  @override
  String get colorVisionResultsMedicalNote =>
      'Nur zum Lernen und für Neugier; ersetzt keine professionelle Augenpflege.';

  @override
  String get colorVisionPlayAgain => 'Nochmal spielen';

  @override
  String get colorVisionIntroTitle => 'Versteckte Formen';

  @override
  String get colorVisionPlateBadgeRg => 'Rot · Grün';

  @override
  String get colorVisionPlateBadgeBy => 'Blau · Gelb';

  @override
  String get colorVisionOptionDiamond => 'Diamant';

  @override
  String get colorVisionResultHintTitle => 'Zusammenfassung';

  @override
  String get colorVisionProfileTypical =>
      'Deine Antworten stimmen mit typischem Farbensehen überein.';

  @override
  String get colorVisionProfileRedGreenAxis => 'Du hast mehr der rot-grünen Tafeln verfehlt.';

  @override
  String get colorVisionProfileBlueYellowAxis => 'Du hast mehr der blau-gelben Tafeln verfehlt.';

  @override
  String get colorVisionProfileMixed =>
      'Beide Arten von Tafeln waren knifflig. Versuche es bei gutem Licht erneut.';

  @override
  String get colorVisionProfileInconclusive => 'Kein klares Muster. Versuche es erneut.';

  @override
  String colorVisionScoreRgLine(int correct, int total) {
    return 'Rot-Grün: $correct / $total';
  }

  @override
  String colorVisionScoreByLine(int correct, int total) {
    return 'Blau-Gelb: $correct / $total';
  }

  @override
  String get colorFailureLoad => 'Spiel konnte nicht geladen werden.';

  @override
  String get colorFailurePalette => 'Farbpalette konnte nicht geladen werden.';

  @override
  String get colorFailureUnknown => 'Ein unerwarteter Fehler ist aufgetreten.';
}
