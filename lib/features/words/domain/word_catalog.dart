import 'package:abc123/features/words/domain/word_entry.dart';
import 'package:abc123/features/words/domain/word_story.dart';

abstract final class WordCatalog {
  static const int targetWordCount = 50;

  static List<WordEntry> wordsForLocale(String languageCode) {
    final raw = switch (languageCode) {
      'tr' => _trWords,
      _ => _enWords,
    };
    return WordStory.sortedByLength(raw);
  }

  static List<WordChapterConfig> chaptersForLocale(String languageCode) {
    final raw = switch (languageCode) {
      'tr' => _trWords,
      _ => _enWords,
    };
    return WordStory.chaptersForWords(raw);
  }

  static int wordCountForLocale(String languageCode) => wordsForLocale(languageCode).length;

  // --- 2 harf ---
  static const _enLen2 = [
    WordEntry(id: 'en_at', spelling: 'AT', displayKey: 'wordAtDisplay', emoji: '🐎'),
    WordEntry(id: 'en_be', spelling: 'BE', displayKey: 'wordBeDisplay', emoji: '🐝'),
    WordEntry(id: 'en_do', spelling: 'DO', displayKey: 'wordDoDisplay', emoji: '🎵'),
    WordEntry(id: 'en_go', spelling: 'GO', displayKey: 'wordGoDisplay', emoji: '🏃'),
    WordEntry(id: 'en_hi', spelling: 'HI', displayKey: 'wordHiDisplay', emoji: '👋'),
    WordEntry(id: 'en_in', spelling: 'IN', displayKey: 'wordInDisplay', emoji: '📥'),
    WordEntry(id: 'en_on', spelling: 'ON', displayKey: 'wordOnDisplay', emoji: '🔛'),
    WordEntry(id: 'en_up', spelling: 'UP', displayKey: 'wordUpDisplay', emoji: '⬆️'),
  ];

  // --- 3 harf ---
  static const _enLen3 = [
    WordEntry(id: 'en_bat', spelling: 'BAT', displayKey: 'wordBatDisplay', emoji: '🦇'),
    WordEntry(id: 'en_bee', spelling: 'BEE', displayKey: 'wordBeeDisplay', emoji: '🐝'),
    WordEntry(id: 'en_box', spelling: 'BOX', displayKey: 'wordBoxDisplay', emoji: '📦'),
    WordEntry(id: 'en_cat', spelling: 'CAT', displayKey: 'wordCatDisplay', emoji: '🐱'),
    WordEntry(id: 'en_cow', spelling: 'COW', displayKey: 'wordCowDisplay', emoji: '🐄'),
    WordEntry(id: 'en_dog', spelling: 'DOG', displayKey: 'wordDogDisplay', emoji: '🐶'),
    WordEntry(id: 'en_egg', spelling: 'EGG', displayKey: 'wordEggDisplay', emoji: '🥚'),
    WordEntry(id: 'en_fox', spelling: 'FOX', displayKey: 'wordFoxDisplay', emoji: '🦊'),
    WordEntry(id: 'en_hat', spelling: 'HAT', displayKey: 'wordHatDisplay', emoji: '🎩'),
    WordEntry(id: 'en_hen', spelling: 'HEN', displayKey: 'wordHenDisplay', emoji: '🐔'),
    WordEntry(id: 'en_pen', spelling: 'PEN', displayKey: 'wordPenDisplay', emoji: '🖊️'),
    WordEntry(id: 'en_sun', spelling: 'SUN', displayKey: 'wordSunDisplay', emoji: '☀️'),
  ];

  // --- 4 harf ---
  static const _enLen4 = [
    WordEntry(id: 'en_bear', spelling: 'BEAR', displayKey: 'wordBearDisplay', emoji: '🐻'),
    WordEntry(id: 'en_bird', spelling: 'BIRD', displayKey: 'wordBirdDisplay', emoji: '🐦'),
    WordEntry(id: 'en_book', spelling: 'BOOK', displayKey: 'wordBookDisplay', emoji: '📚'),
    WordEntry(id: 'en_duck', spelling: 'DUCK', displayKey: 'wordDuckDisplay', emoji: '🦆'),
    WordEntry(id: 'en_fish', spelling: 'FISH', displayKey: 'wordFishDisplay', emoji: '🐟'),
    WordEntry(id: 'en_frog', spelling: 'FROG', displayKey: 'wordFrogDisplay', emoji: '🐸'),
    WordEntry(id: 'en_hand', spelling: 'HAND', displayKey: 'wordHandDisplay', emoji: '✋'),
    WordEntry(id: 'en_home', spelling: 'HOME', displayKey: 'wordHomeDisplay', emoji: '🏠'),
    WordEntry(id: 'en_kite', spelling: 'KITE', displayKey: 'wordKiteDisplay', emoji: '🪁'),
    WordEntry(id: 'en_lion', spelling: 'LION', displayKey: 'wordLionDisplay', emoji: '🦁'),
    WordEntry(id: 'en_moon', spelling: 'MOON', displayKey: 'wordMoonDisplay', emoji: '🌙'),
    WordEntry(id: 'en_tree', spelling: 'TREE', displayKey: 'wordTreeDisplay', emoji: '🌳'),
  ];

  // --- 5 harf ---
  static const _enLen5 = [
    WordEntry(id: 'en_apple', spelling: 'APPLE', displayKey: 'wordAppleDisplay', emoji: '🍎'),
    WordEntry(id: 'en_chair', spelling: 'CHAIR', displayKey: 'wordChairDisplay', emoji: '🪑'),
    WordEntry(id: 'en_grape', spelling: 'GRAPE', displayKey: 'wordGrapeDisplay', emoji: '🍇'),
    WordEntry(id: 'en_horse', spelling: 'HORSE', displayKey: 'wordHorseDisplay', emoji: '🐴'),
    WordEntry(id: 'en_house', spelling: 'HOUSE', displayKey: 'wordHouseDisplay', emoji: '🏠'),
    WordEntry(id: 'en_mouse', spelling: 'MOUSE', displayKey: 'wordMouseDisplay', emoji: '🐭'),
    WordEntry(id: 'en_snake', spelling: 'SNAKE', displayKey: 'wordSnakeDisplay', emoji: '🐍'),
    WordEntry(id: 'en_tiger', spelling: 'TIGER', displayKey: 'wordTigerDisplay', emoji: '🐯'),
    WordEntry(id: 'en_train', spelling: 'TRAIN', displayKey: 'wordTrainDisplay', emoji: '🚆'),
    WordEntry(id: 'en_whale', spelling: 'WHALE', displayKey: 'wordWhaleDisplay', emoji: '🐋'),
  ];

  // --- 6 harf ---
  static const _enLen6 = [
    WordEntry(id: 'en_banana', spelling: 'BANANA', displayKey: 'wordBananaDisplay', emoji: '🍌'),
    WordEntry(id: 'en_flower', spelling: 'FLOWER', displayKey: 'wordFlowerDisplay', emoji: '🌸'),
    WordEntry(id: 'en_garden', spelling: 'GARDEN', displayKey: 'wordGardenDisplay', emoji: '🌻'),
    WordEntry(id: 'en_monkey', spelling: 'MONKEY', displayKey: 'wordMonkeyDisplay', emoji: '🐵'),
    WordEntry(id: 'en_orange', spelling: 'ORANGE', displayKey: 'wordOrangeDisplay', emoji: '🍊'),
    WordEntry(id: 'en_rabbit', spelling: 'RABBIT', displayKey: 'wordRabbitDisplay', emoji: '🐰'),
    WordEntry(id: 'en_school', spelling: 'SCHOOL', displayKey: 'wordSchoolDisplay', emoji: '🏫'),
    WordEntry(id: 'en_turtle', spelling: 'TURTLE', displayKey: 'wordTurtleDisplay', emoji: '🐢'),
  ];

  static final List<WordEntry> _enWords = [
    ..._enLen2,
    ..._enLen3,
    ..._enLen4,
    ..._enLen5,
    ..._enLen6,
  ];

  static const _trLen2 = [
    WordEntry(id: 'tr_at', spelling: 'AT', displayKey: 'wordAtDisplay', emoji: '🐎'),
    WordEntry(id: 'tr_el', spelling: 'EL', displayKey: 'wordElDisplay', emoji: '✋'),
    WordEntry(id: 'tr_ev', spelling: 'EV', displayKey: 'wordEvDisplay', emoji: '🏠'),
    WordEntry(id: 'tr_ok', spelling: 'OK', displayKey: 'wordOkDisplay', emoji: '👌'),
    WordEntry(id: 'tr_su', spelling: 'SU', displayKey: 'wordSuDisplay', emoji: '💧'),
    WordEntry(id: 'tr_ak', spelling: 'AK', displayKey: 'wordAkDisplay', emoji: '❄️'),
    WordEntry(id: 'tr_al', spelling: 'AL', displayKey: 'wordAlDisplay', emoji: '🔴'),
    WordEntry(id: 'tr_ul', spelling: 'UL', displayKey: 'wordUlDisplay', emoji: '🌍'),
  ];

  static const _trLen3 = [
    WordEntry(id: 'tr_bal', spelling: 'BAL', displayKey: 'wordBalDisplay', emoji: '🍯'),
    WordEntry(id: 'tr_can', spelling: 'CAN', displayKey: 'wordCanDisplay', emoji: '❤️'),
    WordEntry(id: 'tr_den', spelling: 'DEN', displayKey: 'wordDenDisplay', emoji: '🏔️'),
    WordEntry(id: 'tr_gun', spelling: 'GUN', displayKey: 'wordGunDisplay', emoji: '☀️'),
    WordEntry(id: 'tr_kar', spelling: 'KAR', displayKey: 'wordKarDisplay', emoji: '❄️'),
    WordEntry(id: 'tr_kum', spelling: 'KUM', displayKey: 'wordKumDisplay', emoji: '🏖️'),
    WordEntry(id: 'tr_sut', spelling: 'SUT', displayKey: 'wordSutDisplay', emoji: '🥛'),
    WordEntry(id: 'tr_top', spelling: 'TOP', displayKey: 'wordTopDisplay', emoji: '⚽'),
    WordEntry(id: 'tr_tuz', spelling: 'TUZ', displayKey: 'wordTuzDisplay', emoji: '🧂'),
    WordEntry(id: 'tr_yaz', spelling: 'YAZ', displayKey: 'wordYazDisplay', emoji: '🌞'),
    WordEntry(id: 'tr_yol', spelling: 'YOL', displayKey: 'wordYolDisplay', emoji: '🛤️'),
    WordEntry(id: 'tr_oda', spelling: 'ODA', displayKey: 'wordOdaDisplay', emoji: '🛏️'),
  ];

  static const _trLen4 = [
    WordEntry(id: 'tr_agac', spelling: 'AGAC', displayKey: 'wordAgacDisplay', emoji: '🌳'),
    WordEntry(id: 'tr_baba', spelling: 'BABA', displayKey: 'wordBabaDisplay', emoji: '👨'),
    WordEntry(id: 'tr_dede', spelling: 'DEDE', displayKey: 'wordDedeDisplay', emoji: '👴'),
    WordEntry(id: 'tr_elma', spelling: 'ELMA', displayKey: 'wordElmaDisplay', emoji: '🍎'),
    WordEntry(id: 'tr_gunes', spelling: 'GUNES', displayKey: 'wordGunesDisplay', emoji: '☀️'),
    WordEntry(id: 'tr_kale', spelling: 'KALE', displayKey: 'wordKaleDisplay', emoji: '🏰'),
    WordEntry(id: 'tr_kapi', spelling: 'KAPI', displayKey: 'wordKapiDisplay', emoji: '🚪'),
    WordEntry(id: 'tr_kopek', spelling: 'KOPEK', displayKey: 'wordKopekDisplay', emoji: '🐶'),
    WordEntry(id: 'tr_masa', spelling: 'MASA', displayKey: 'wordMasaDisplay', emoji: '🪑'),
    WordEntry(id: 'tr_nene', spelling: 'NENE', displayKey: 'wordNeneDisplay', emoji: '👵'),
    WordEntry(id: 'tr_tren', spelling: 'TREN', displayKey: 'wordTrenDisplay', emoji: '🚆'),
    WordEntry(id: 'tr_kedi4', spelling: 'KEDI', displayKey: 'wordKediDisplay', emoji: '🐱'),
  ];

  static const _trLen5 = [
    WordEntry(id: 'tr_bulut', spelling: 'BULUT', displayKey: 'wordBulutDisplay', emoji: '☁️'),
    WordEntry(id: 'tr_cicek', spelling: 'CICEK', displayKey: 'wordCicekDisplay', emoji: '🌸'),
    WordEntry(id: 'tr_cocuk', spelling: 'COCUK', displayKey: 'wordCocukDisplay', emoji: '👦'),
    WordEntry(id: 'tr_deniz', spelling: 'DENIZ', displayKey: 'wordDenizDisplay', emoji: '🌊'),
    WordEntry(id: 'tr_kalem', spelling: 'KALEM', displayKey: 'wordKalemDisplay', emoji: '✏️'),
    WordEntry(id: 'tr_kurt', spelling: 'KURT', displayKey: 'wordKurtDisplay', emoji: '🐺'),
    WordEntry(id: 'tr_meyve', spelling: 'MEYVE', displayKey: 'wordMeyveDisplay', emoji: '🍇'),
    WordEntry(id: 'tr_okul', spelling: 'OKUL', displayKey: 'wordOkulDisplay', emoji: '🏫'),
    WordEntry(id: 'tr_sabah', spelling: 'SABAH', displayKey: 'wordSabahDisplay', emoji: '🌅'),
    WordEntry(id: 'tr_yemek', spelling: 'YEMEK', displayKey: 'wordYemekDisplay', emoji: '🍽️'),
    WordEntry(id: 'tr_renk', spelling: 'RENK', displayKey: 'wordRenkDisplay', emoji: '🎨'),
    WordEntry(id: 'tr_maske', spelling: 'MASKE', displayKey: 'wordMaskeDisplay', emoji: '🎭'),
  ];

  static const _trLen6 = [
    WordEntry(id: 'tr_balkon', spelling: 'BALKON', displayKey: 'wordBalkonDisplay', emoji: '🏠'),
    WordEntry(id: 'tr_camlar', spelling: 'CAMLAR', displayKey: 'wordCamlarDisplay', emoji: '🪟'),
    WordEntry(id: 'tr_kuslar', spelling: 'KUSLAR', displayKey: 'wordKuslarDisplay', emoji: '🐦'),
    WordEntry(id: 'tr_ruzgar', spelling: 'RUZGAR', displayKey: 'wordRuzgarDisplay', emoji: '💨'),
    WordEntry(id: 'tr_sandal', spelling: 'SANDAL', displayKey: 'wordSandalDisplay', emoji: '⛵'),
    WordEntry(id: 'tr_yildiz', spelling: 'YILDIZ', displayKey: 'wordYildizDisplay', emoji: '⭐'),
  ];

  static final List<WordEntry> _trWords = [
    ..._trLen2,
    ..._trLen3,
    ..._trLen4,
    ..._trLen5,
    ..._trLen6,
  ];
}
