import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'words_localizations_en.dart';
import 'words_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of WordsLocalizations
/// returned by `WordsLocalizations.of(context)`.
///
/// Applications need to include `WordsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/words_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WordsLocalizations.localizationsDelegates,
///   supportedLocales: WordsLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the WordsLocalizations.supportedLocales
/// property.
abstract class WordsLocalizations {
  WordsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WordsLocalizations? of(BuildContext context) {
    return Localizations.of<WordsLocalizations>(context, WordsLocalizations);
  }

  static const LocalizationsDelegate<WordsLocalizations> delegate = _WordsLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('tr')];

  /// l10n: wordsTitle
  ///
  /// In en, this message translates to:
  /// **'Build Words'**
  String get wordsTitle;

  /// l10n: wordComplete
  ///
  /// In en, this message translates to:
  /// **'Word completed!'**
  String get wordComplete;

  /// l10n: wordsContinue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get wordsContinue;

  /// l10n: wordChapterTitle
  ///
  /// In en, this message translates to:
  /// **'{length}-letter words'**
  String wordChapterTitle(int length);

  /// l10n: wordLevelProgress
  ///
  /// In en, this message translates to:
  /// **'Word {current} of {total}'**
  String wordLevelProgress(int current, int total);

  /// No description provided for @wordAtDisplay.
  ///
  /// In en, this message translates to:
  /// **'At'**
  String get wordAtDisplay;

  /// No description provided for @wordBeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Be'**
  String get wordBeDisplay;

  /// No description provided for @wordDoDisplay.
  ///
  /// In en, this message translates to:
  /// **'Do'**
  String get wordDoDisplay;

  /// No description provided for @wordGoDisplay.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get wordGoDisplay;

  /// No description provided for @wordHiDisplay.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get wordHiDisplay;

  /// No description provided for @wordInDisplay.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get wordInDisplay;

  /// No description provided for @wordOnDisplay.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get wordOnDisplay;

  /// No description provided for @wordUpDisplay.
  ///
  /// In en, this message translates to:
  /// **'Up'**
  String get wordUpDisplay;

  /// No description provided for @wordElDisplay.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get wordElDisplay;

  /// No description provided for @wordEvDisplay.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get wordEvDisplay;

  /// No description provided for @wordOkDisplay.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get wordOkDisplay;

  /// No description provided for @wordSuDisplay.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get wordSuDisplay;

  /// No description provided for @wordAkDisplay.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get wordAkDisplay;

  /// No description provided for @wordAlDisplay.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get wordAlDisplay;

  /// No description provided for @wordUlDisplay.
  ///
  /// In en, this message translates to:
  /// **'Nation'**
  String get wordUlDisplay;

  /// No description provided for @wordBatDisplay.
  ///
  /// In en, this message translates to:
  /// **'Bat'**
  String get wordBatDisplay;

  /// No description provided for @wordBeeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Bee'**
  String get wordBeeDisplay;

  /// No description provided for @wordBoxDisplay.
  ///
  /// In en, this message translates to:
  /// **'Box'**
  String get wordBoxDisplay;

  /// No description provided for @wordCatDisplay.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get wordCatDisplay;

  /// No description provided for @wordCowDisplay.
  ///
  /// In en, this message translates to:
  /// **'Cow'**
  String get wordCowDisplay;

  /// No description provided for @wordDogDisplay.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get wordDogDisplay;

  /// No description provided for @wordEggDisplay.
  ///
  /// In en, this message translates to:
  /// **'Egg'**
  String get wordEggDisplay;

  /// No description provided for @wordFoxDisplay.
  ///
  /// In en, this message translates to:
  /// **'Fox'**
  String get wordFoxDisplay;

  /// No description provided for @wordHatDisplay.
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get wordHatDisplay;

  /// No description provided for @wordHenDisplay.
  ///
  /// In en, this message translates to:
  /// **'Hen'**
  String get wordHenDisplay;

  /// No description provided for @wordPenDisplay.
  ///
  /// In en, this message translates to:
  /// **'Pen'**
  String get wordPenDisplay;

  /// No description provided for @wordSunDisplay.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get wordSunDisplay;

  /// No description provided for @wordBalDisplay.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get wordBalDisplay;

  /// No description provided for @wordCanDisplay.
  ///
  /// In en, this message translates to:
  /// **'Life'**
  String get wordCanDisplay;

  /// No description provided for @wordDenDisplay.
  ///
  /// In en, this message translates to:
  /// **'Lake'**
  String get wordDenDisplay;

  /// No description provided for @wordGunDisplay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get wordGunDisplay;

  /// No description provided for @wordKarDisplay.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get wordKarDisplay;

  /// No description provided for @wordKumDisplay.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get wordKumDisplay;

  /// No description provided for @wordSutDisplay.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get wordSutDisplay;

  /// No description provided for @wordTopDisplay.
  ///
  /// In en, this message translates to:
  /// **'Ball'**
  String get wordTopDisplay;

  /// No description provided for @wordTuzDisplay.
  ///
  /// In en, this message translates to:
  /// **'Salt'**
  String get wordTuzDisplay;

  /// No description provided for @wordYazDisplay.
  ///
  /// In en, this message translates to:
  /// **'Summer'**
  String get wordYazDisplay;

  /// No description provided for @wordYolDisplay.
  ///
  /// In en, this message translates to:
  /// **'Road'**
  String get wordYolDisplay;

  /// No description provided for @wordOdaDisplay.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get wordOdaDisplay;

  /// No description provided for @wordBearDisplay.
  ///
  /// In en, this message translates to:
  /// **'Bear'**
  String get wordBearDisplay;

  /// No description provided for @wordBirdDisplay.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get wordBirdDisplay;

  /// No description provided for @wordBookDisplay.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get wordBookDisplay;

  /// No description provided for @wordDuckDisplay.
  ///
  /// In en, this message translates to:
  /// **'Duck'**
  String get wordDuckDisplay;

  /// No description provided for @wordFishDisplay.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get wordFishDisplay;

  /// No description provided for @wordFrogDisplay.
  ///
  /// In en, this message translates to:
  /// **'Frog'**
  String get wordFrogDisplay;

  /// No description provided for @wordHandDisplay.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get wordHandDisplay;

  /// No description provided for @wordHomeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get wordHomeDisplay;

  /// No description provided for @wordKiteDisplay.
  ///
  /// In en, this message translates to:
  /// **'Kite'**
  String get wordKiteDisplay;

  /// No description provided for @wordLionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get wordLionDisplay;

  /// No description provided for @wordMoonDisplay.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get wordMoonDisplay;

  /// No description provided for @wordTreeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get wordTreeDisplay;

  /// No description provided for @wordAgacDisplay.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get wordAgacDisplay;

  /// No description provided for @wordBabaDisplay.
  ///
  /// In en, this message translates to:
  /// **'Dad'**
  String get wordBabaDisplay;

  /// No description provided for @wordDedeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Grandpa'**
  String get wordDedeDisplay;

  /// No description provided for @wordElmaDisplay.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get wordElmaDisplay;

  /// No description provided for @wordGunesDisplay.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get wordGunesDisplay;

  /// No description provided for @wordKaleDisplay.
  ///
  /// In en, this message translates to:
  /// **'Castle'**
  String get wordKaleDisplay;

  /// No description provided for @wordKapiDisplay.
  ///
  /// In en, this message translates to:
  /// **'Door'**
  String get wordKapiDisplay;

  /// No description provided for @wordKopekDisplay.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get wordKopekDisplay;

  /// No description provided for @wordMasaDisplay.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get wordMasaDisplay;

  /// No description provided for @wordNeneDisplay.
  ///
  /// In en, this message translates to:
  /// **'Grandma'**
  String get wordNeneDisplay;

  /// No description provided for @wordTrenDisplay.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get wordTrenDisplay;

  /// No description provided for @wordKediDisplay.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get wordKediDisplay;

  /// No description provided for @wordAppleDisplay.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get wordAppleDisplay;

  /// No description provided for @wordChairDisplay.
  ///
  /// In en, this message translates to:
  /// **'Chair'**
  String get wordChairDisplay;

  /// No description provided for @wordGrapeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Grape'**
  String get wordGrapeDisplay;

  /// No description provided for @wordHorseDisplay.
  ///
  /// In en, this message translates to:
  /// **'Horse'**
  String get wordHorseDisplay;

  /// No description provided for @wordHouseDisplay.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get wordHouseDisplay;

  /// No description provided for @wordMouseDisplay.
  ///
  /// In en, this message translates to:
  /// **'Mouse'**
  String get wordMouseDisplay;

  /// No description provided for @wordSnakeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Snake'**
  String get wordSnakeDisplay;

  /// No description provided for @wordTigerDisplay.
  ///
  /// In en, this message translates to:
  /// **'Tiger'**
  String get wordTigerDisplay;

  /// No description provided for @wordTrainDisplay.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get wordTrainDisplay;

  /// No description provided for @wordWhaleDisplay.
  ///
  /// In en, this message translates to:
  /// **'Whale'**
  String get wordWhaleDisplay;

  /// No description provided for @wordBulutDisplay.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get wordBulutDisplay;

  /// No description provided for @wordCicekDisplay.
  ///
  /// In en, this message translates to:
  /// **'Flower'**
  String get wordCicekDisplay;

  /// No description provided for @wordCocukDisplay.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get wordCocukDisplay;

  /// No description provided for @wordDenizDisplay.
  ///
  /// In en, this message translates to:
  /// **'Sea'**
  String get wordDenizDisplay;

  /// No description provided for @wordKalemDisplay.
  ///
  /// In en, this message translates to:
  /// **'Pencil'**
  String get wordKalemDisplay;

  /// No description provided for @wordKurtDisplay.
  ///
  /// In en, this message translates to:
  /// **'Wolf'**
  String get wordKurtDisplay;

  /// No description provided for @wordMeyveDisplay.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get wordMeyveDisplay;

  /// No description provided for @wordOkulDisplay.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get wordOkulDisplay;

  /// No description provided for @wordSabahDisplay.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get wordSabahDisplay;

  /// No description provided for @wordYemekDisplay.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get wordYemekDisplay;

  /// No description provided for @wordRenkDisplay.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get wordRenkDisplay;

  /// No description provided for @wordMaskeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Mask'**
  String get wordMaskeDisplay;

  /// No description provided for @wordBananaDisplay.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get wordBananaDisplay;

  /// No description provided for @wordFlowerDisplay.
  ///
  /// In en, this message translates to:
  /// **'Flower'**
  String get wordFlowerDisplay;

  /// No description provided for @wordGardenDisplay.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get wordGardenDisplay;

  /// No description provided for @wordMonkeyDisplay.
  ///
  /// In en, this message translates to:
  /// **'Monkey'**
  String get wordMonkeyDisplay;

  /// No description provided for @wordOrangeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get wordOrangeDisplay;

  /// No description provided for @wordRabbitDisplay.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get wordRabbitDisplay;

  /// No description provided for @wordSchoolDisplay.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get wordSchoolDisplay;

  /// No description provided for @wordTurtleDisplay.
  ///
  /// In en, this message translates to:
  /// **'Turtle'**
  String get wordTurtleDisplay;

  /// No description provided for @wordBalkonDisplay.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get wordBalkonDisplay;

  /// No description provided for @wordCamlarDisplay.
  ///
  /// In en, this message translates to:
  /// **'Windows'**
  String get wordCamlarDisplay;

  /// No description provided for @wordKuslarDisplay.
  ///
  /// In en, this message translates to:
  /// **'Birds'**
  String get wordKuslarDisplay;

  /// No description provided for @wordRuzgarDisplay.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wordRuzgarDisplay;

  /// No description provided for @wordSandalDisplay.
  ///
  /// In en, this message translates to:
  /// **'Boat'**
  String get wordSandalDisplay;

  /// No description provided for @wordYildizDisplay.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get wordYildizDisplay;
}

class _WordsLocalizationsDelegate extends LocalizationsDelegate<WordsLocalizations> {
  const _WordsLocalizationsDelegate();

  @override
  Future<WordsLocalizations> load(Locale locale) {
    return SynchronousFuture<WordsLocalizations>(lookupWordsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_WordsLocalizationsDelegate old) => false;
}

WordsLocalizations lookupWordsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return WordsLocalizationsEn();
    case 'tr':
      return WordsLocalizationsTr();
  }

  throw FlutterError(
      'WordsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
