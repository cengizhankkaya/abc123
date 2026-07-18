// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'numbers_advanced_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class NumbersAdvancedLocalizationsAz extends NumbersAdvancedLocalizations {
  NumbersAdvancedLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get mathHubTitle => 'Math Adventure';

  @override
  String get mathHubSubtitle => 'Choose a topic to practice';

  @override
  String get mathHubTensTitle => 'Tens Numbers';

  @override
  String get mathHubTensSubtitle => '10, 20, 30 … 100';

  @override
  String get mathHubFreeTitle => 'Free Practice';

  @override
  String get mathHubFreeSubtitle => '2-digit numbers';

  @override
  String get mathHubVisualTitle => 'Visual Addition';

  @override
  String get mathHubVisualSubtitle => 'Count & write';

  @override
  String get mathHubSymbolicTitle => 'Addition & Subtraction';

  @override
  String get mathHubSymbolicSubtitle => 'A, B, C levels';

  @override
  String get mathSelectTensTitle => 'Pick a Tens Number';

  @override
  String mathDrawTensInstruction(int number) {
    return 'Draw $number in the boxes';
  }

  @override
  String mathFreePracticeInstruction(int number) {
    return 'Draw the number $number';
  }

  @override
  String get mathVisualInstruction => 'Count the objects and write the total';

  @override
  String get mathSymbolicInstruction => 'Solve and write the answer';

  @override
  String get mathTensBox => 'Tens';

  @override
  String get mathUnitsBox => 'Units';

  @override
  String get mathCheckButton => 'Check';

  @override
  String get mathNextButton => 'Next';

  @override
  String get mathCorrect => 'Correct! 🎉';

  @override
  String get mathWrong => 'Try again!';

  @override
  String get mathHintVisible => 'Hint mode ON';

  @override
  String get mathHintHidden => 'Hint mode OFF';

  @override
  String get mathLevelLocked => 'Complete previous level at 80%';

  @override
  String mathLevelProgress(int correct, int total, int percent) {
    return '$correct/$total correct ($percent%)';
  }

  @override
  String get mathLevelA => 'Level A';

  @override
  String get mathLevelB => 'Level B';

  @override
  String get mathLevelC => 'Level C';

  @override
  String get mathLevelADesc => 'Result ≤ 10';

  @override
  String get mathLevelBDesc => 'Result ≤ 20';

  @override
  String get mathLevelCDesc => 'Two-digit, no carry';

  @override
  String get mathClearButton => 'Clear';

  @override
  String get mathEmptyDrawingWarning => 'Please draw in the box first';

  @override
  String get mathParentSectionTitle => 'Math Progress';

  @override
  String get mathParentAdditions => 'Additions solved';

  @override
  String get mathParentSubtractions => 'Subtractions solved';

  @override
  String get mathParentTens => 'Tens practiced';

  @override
  String get mathParentSuggest => 'Keep practicing subtraction!';

  @override
  String get badgeMathFirstAdditionName => 'First Addition!';

  @override
  String get badgeMathFirstAdditionDesc => 'You solved your first addition!';

  @override
  String get badgeTensHeroName => 'Tens Hero';

  @override
  String get badgeTensHeroDesc => 'You practiced all tens numbers!';

  @override
  String get badgeSubtractionMasterName => 'Subtraction Master';

  @override
  String get badgeSubtractionMasterDesc => 'You solved 20 subtractions!';

  @override
  String get mathAdvancedHomeTitle => 'Addition & Subtraction';

  @override
  String get mathAdvancedHomeSubtitle => 'Math adventure';
}
