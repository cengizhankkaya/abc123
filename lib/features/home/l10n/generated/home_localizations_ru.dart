// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class HomeLocalizationsRu extends HomeLocalizations {
  HomeLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get hello => 'Здравствуйте';

  @override
  String get slogan => 'Рисуй, учись, развлекайся!';

  @override
  String get seeTutorial => 'Смотреть учебник';

  @override
  String get tutorial => 'Учебник';

  @override
  String get points => 'Очки';

  @override
  String get streakDay => 'Дней';

  @override
  String get badgeFirstLoginName => 'Первый Шаг';

  @override
  String get badgeFirstLoginDesc => 'Вы вошли в систему в первый раз!';

  @override
  String get badgeFirstDrawName => 'Начинающий Художник';

  @override
  String get badgeFirstDrawDesc => 'Вы завершили свой первый рисунок!';

  @override
  String get badgeStreak3Name => 'Решительный';

  @override
  String get badgeStreak3Desc => 'Вы заходили 3 дня подряд!';

  @override
  String get badgeStreak7Name => 'Звезда Недели';

  @override
  String get badgeStreak7Desc => 'Вы практиковались 7 дней!';

  @override
  String get badgeMasterArtistName => 'Мастер-Художник';

  @override
  String get badgeMasterArtistDesc => 'Вы сделали 100 рисунков!';

  @override
  String get badgeStreak30Name => 'Ежемесячный Мастер';

  @override
  String get badgeStreak30Desc => 'Вы заходили регулярно 30 дней!';

  @override
  String get badgeBronzeArtistName => 'Бронзовый Карандаш';

  @override
  String get badgeBronzeArtistDesc => 'Вы сделали 10 рисунков!';

  @override
  String get badgeSilverArtistName => 'Серебряный Карандаш';

  @override
  String get badgeSilverArtistDesc => 'Вы сделали 50 рисунков!';

  @override
  String get badgeGoldArtistName => 'Золотой Карандаш';

  @override
  String get badgeGoldArtistDesc => 'Вы сделали 250 рисунков!';

  @override
  String get badgeDiamondArtistName => 'Бриллиантовый Художник';

  @override
  String get badgeDiamondArtistDesc => 'Вы сделали 500 рисунков! Невероятно!';

  @override
  String get badgeEarlyBirdName => 'Ранняя Пташка';

  @override
  String get badgeEarlyBirdDesc => 'Вы начали работать рано утром!';

  @override
  String get badgeNightOwlName => 'Ночная Сова';

  @override
  String get badgeNightOwlDesc => 'Вы работаете даже поздно ночью!';

  @override
  String get badgeWeekendWarriorName => 'Выходные Веселье';

  @override
  String get badgeWeekendWarriorDesc => 'Вы проводите выходные, обучаясь!';

  @override
  String get badgeNumberMasterName => 'Математический Гений';

  @override
  String get badgeNumberMasterDesc => 'Вы нарисовали 50 цифр!';

  @override
  String get badgeLetterMasterName => 'Профи Алфавита';

  @override
  String get badgeLetterMasterDesc => 'Вы нарисовали 50 букв!';

  @override
  String get badgeShapeMasterName => 'Волшебник Геометрии';

  @override
  String get badgeShapeMasterDesc => 'Вы нарисовали 50 фигур!';

  @override
  String get badgeHighScorerName => 'High Scorer';

  @override
  String get badgeHighScorerDesc => 'You reached 1000 points!';

  @override
  String get badgeScoreLegendName => 'Score Legend';

  @override
  String get badgeScoreLegendDesc => 'You reached 5000 points!';

  @override
  String get badgeBadgeCollectorName => 'Badge Collector';

  @override
  String get badgeBadgeCollectorDesc => 'You earned 5 badges!';

  @override
  String get badgeBadgeMasterName => 'Badge Master';

  @override
  String get badgeBadgeMasterDesc => 'You earned 15 badges!';

  @override
  String get shopTitle => 'МАГАЗИН';

  @override
  String get shopScreenSubtitle => 'Customize your avatar!';

  @override
  String get tabHat => 'Шляпа';

  @override
  String get tabGlasses => 'Очки';

  @override
  String get tabOutfit => 'Наряд';

  @override
  String get owned => 'Куплено';

  @override
  String get equipped => 'Надето';

  @override
  String get shopSlotNone => 'Снять';

  @override
  String itemEquipped(String item) {
    return '$item надето!';
  }

  @override
  String itemUnequipped(String slot) {
    return '$slot снято';
  }

  @override
  String get slotHat => 'Шляпа';

  @override
  String get slotGlasses => 'Очки';

  @override
  String get slotOutfit => 'Наряд';

  @override
  String get insufficientPoints => 'Недостаточно очков! 😢';

  @override
  String get buyTitle => 'Купить предмет?';

  @override
  String buyDescription(int price) {
    return 'Вы хотите купить этот предмет за $price звезд?';
  }

  @override
  String get noBtn => 'Нет';

  @override
  String get yesBuyBtn => 'Да, купить!';

  @override
  String itemBought(String item) {
    return '$item куплено! 🎉';
  }

  @override
  String get freePointsBtn => 'СМОТРЕТЬ РЕКЛАМУ';

  @override
  String rewardEarned(int amount) {
    return 'Поздравляем! Вы заработали $amount очков! 🎉';
  }

  @override
  String get myQuestsTitle => 'МОИ ЗАДАНИЯ';

  @override
  String get questsScreenSubtitle => 'Complete quests and earn points!';

  @override
  String get questsDailySection => 'Daily Quests';

  @override
  String get questsWeeklySection => 'Weekly Quests';

  @override
  String get loadingQuests => 'Загрузка заданий...';

  @override
  String get dailyQuest => 'ЕЖЕДНЕВНОЕ ЗАДАНИЕ';

  @override
  String get weeklyQuest => 'ЕЖЕНЕДЕЛЬНОЕ ЗАДАНИЕ';

  @override
  String get hat_blue_cap => 'Синяя Кепка';

  @override
  String get hat_crown => 'Корона';

  @override
  String get hat_wizard => 'Шляпа Волшебника';

  @override
  String get hat_flower => 'Цветочный Венок';

  @override
  String get hat_pirate => 'Шляпа Пирата';

  @override
  String get hat_chef => 'Поварской Колпак';

  @override
  String get glasses_sun => 'Солнцезащитные очки';

  @override
  String get glasses_nerd => 'Очки Ботана';

  @override
  String get glasses_heart => 'Очки-Сердечки';

  @override
  String get glasses_3d => '3D Очки';

  @override
  String get glasses_vr => 'VR Шлем';

  @override
  String get glasses_ski => 'Лыжные Очки';

  @override
  String get glasses_mask => 'Маска';

  @override
  String get glasses_reading => 'Очки для Чтения';

  @override
  String get outfit_red => 'Красная Рубашка';

  @override
  String get outfit_super => 'Супергерой';

  @override
  String get outfit_green => 'Зеленая Толстовка';

  @override
  String get outfit_doctor => 'Халат Врача';

  @override
  String get outfit_space => 'Скафандр';

  @override
  String get outfit_sports => 'Джерси';

  @override
  String get outfit_police => 'Полицейская Форма';

  @override
  String get outfit_chef => 'Поварской Фартук';

  @override
  String get outfit_winter => 'Зимнее Пальто';

  @override
  String get outfit_tuxedo => 'Смокинг';

  @override
  String get badgesTitle => 'МОИ ЗНАЧКИ';

  @override
  String get totalBadges => 'Всего:';

  @override
  String get filterAll => 'ВСЕ';

  @override
  String get filterEarned => 'ПОЛУЧЕНО';

  @override
  String get filterLocked => 'ЗАКРЫТО';

  @override
  String get numbersTitle => 'Изучать числа';

  @override
  String get lettersTitle => 'Изучать буквы';

  @override
  String get shapesTitle => 'Изучать фигуры';

  @override
  String get colorsTitle => 'Learn Colors';

  @override
  String get wordsTitle => 'Build Words';

  @override
  String get badgeColorMasterName => 'Color Expert';

  @override
  String get badgeColorMasterDesc => 'You completed 50 color rounds!';

  @override
  String get badgeWordMasterName => 'Word Builder';

  @override
  String get badgeWordMasterDesc => 'You completed 50 words!';

  @override
  String get questsRefreshedMessage => 'Quests have been refreshed.';

  @override
  String get noBadgesFound => 'No badges found';

  @override
  String homeGreetingWithName(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homeSloganToday => 'What shall we learn today?';

  @override
  String homeStreakDays(int count) {
    return '$count-day streak';
  }

  @override
  String get homeLearningModes => 'Learning Modes';

  @override
  String get numbersTitleShort => 'Numbers';

  @override
  String get lettersTitleShort => 'Letters';

  @override
  String get shapesTitleShort => 'Shapes';

  @override
  String get wordsTitleShort => 'Words';

  @override
  String get colorsTitleShort => 'Colors';

  @override
  String get numbersSubtitle => 'Draw 0–9';

  @override
  String get lettersSubtitle => 'Draw A–Z';

  @override
  String get shapesSubtitle => 'New!';

  @override
  String get wordsSubtitle => 'Draw words';

  @override
  String get colorsSubtitle => 'Play & learn';

  @override
  String homeWhereYouLeft(String label) {
    return 'Where you left off: $label';
  }

  @override
  String homeStepsRemaining(int count) {
    return '$count steps left';
  }

  @override
  String homeContinueNumber(String number) {
    return 'Number $number';
  }

  @override
  String homeContinueLetter(String letter) {
    return 'Letter $letter';
  }

  @override
  String homeContinueShape(String number) {
    return 'Shape $number';
  }

  @override
  String get homeContinueWord => 'Words';

  @override
  String get homeContinueColor => 'Colors';

  @override
  String get homeContinueColorVision => 'Color Vision';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsChildName => 'Name';

  @override
  String get settingsChildNameHint => 'Enter your name';

  @override
  String get settingsSaveName => 'Save';

  @override
  String get settingsNameSaved => 'Name saved';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get badgesScreenTitle => 'My Badges';

  @override
  String badgesEarnedOfTotal(int count, int total) {
    return '$count / $total badges earned';
  }

  @override
  String badgesStreakDayCount(int count) {
    return '$count days';
  }

  @override
  String get badgesStreakSubtitle => 'Drawing streak';

  @override
  String get parentPanelTitle => 'Parent Panel';

  @override
  String parentPanelWeeklyProgress(String name) {
    return '$name\'s progress this week';
  }

  @override
  String get parentPanelWeeklyProgressNoName => 'Progress this week';

  @override
  String get parentPanelStatDuration => 'TIME';

  @override
  String get parentPanelStatCompleted => 'COMPLETED';

  @override
  String get parentPanelStatAccuracy => 'AVG. ACCURACY';

  @override
  String parentPanelDurationMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String parentPanelAccuracyPercent(int percent) {
    return '$percent%';
  }

  @override
  String get parentPanelChartTitle => 'Daily drawing time';

  @override
  String parentPanelInsightLettersLearned(String range) {
    return 'Letters $range learned';
  }

  @override
  String parentPanelInsightNumberStruggling(int number) {
    return 'Struggling with number $number';
  }

  @override
  String get parentPanelInsightGettingStarted => 'Learning journey is just starting';

  @override
  String get parentPanelToday => 'Today';

  @override
  String get parentPanelYesterday => 'Yesterday';

  @override
  String get settingsParentPanel => 'Parent Panel';

  @override
  String get settingsParentPanelSubtitle => 'Progress & insights';
}
