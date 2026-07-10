// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class HomeLocalizationsZh extends HomeLocalizations {
  HomeLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get hello => '你好';

  @override
  String get slogan => '画画，学习，玩耍！';

  @override
  String get seeTutorial => '查看教程';

  @override
  String get tutorial => '教程';

  @override
  String get points => '分数';

  @override
  String get streakDay => '天';

  @override
  String get badgeFirstLoginName => '第一步';

  @override
  String get badgeFirstLoginDesc => '你第一次登录了！';

  @override
  String get badgeFirstDrawName => '初级画家';

  @override
  String get badgeFirstDrawDesc => '你完成了你的第一幅画！';

  @override
  String get badgeStreak3Name => '坚定';

  @override
  String get badgeStreak3Desc => '你连续来了3天！';

  @override
  String get badgeStreak7Name => '每周之星';

  @override
  String get badgeStreak7Desc => '你练习了7天！';

  @override
  String get badgeMasterArtistName => '大师级画家';

  @override
  String get badgeMasterArtistDesc => '你完成了100幅画！';

  @override
  String get badgeStreak30Name => '月度大师';

  @override
  String get badgeStreak30Desc => '你连续来了30天！';

  @override
  String get badgeBronzeArtistName => '铜铅笔';

  @override
  String get badgeBronzeArtistDesc => '你完成了10幅画！';

  @override
  String get badgeSilverArtistName => '银铅笔';

  @override
  String get badgeSilverArtistDesc => '你完成了50幅画！';

  @override
  String get badgeGoldArtistName => '金铅笔';

  @override
  String get badgeGoldArtistDesc => '你完成了250幅画！';

  @override
  String get badgeDiamondArtistName => '钻石艺术家';

  @override
  String get badgeDiamondArtistDesc => '你完成了500幅画！难以置信！';

  @override
  String get badgeEarlyBirdName => '早起的鸟儿';

  @override
  String get badgeEarlyBirdDesc => '你一大早就开始工作了！';

  @override
  String get badgeNightOwlName => '夜猫子';

  @override
  String get badgeNightOwlDesc => '你甚至在该夜还在工作！';

  @override
  String get badgeWeekendWarriorName => '周末乐趣';

  @override
  String get badgeWeekendWarriorDesc => '你在周末学习！';

  @override
  String get badgeNumberMasterName => '数学天才';

  @override
  String get badgeNumberMasterDesc => '你画了50个数字！';

  @override
  String get badgeLetterMasterName => '字母专家';

  @override
  String get badgeLetterMasterDesc => '你画了50个字母！';

  @override
  String get badgeShapeMasterName => '几何向导';

  @override
  String get badgeShapeMasterDesc => '你画了50个形状！';

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
  String get shopTitle => '商店';

  @override
  String get shopScreenSubtitle => 'Customize your avatar!';

  @override
  String get tabHat => '帽子';

  @override
  String get tabGlasses => '眼镜';

  @override
  String get tabOutfit => '服装';

  @override
  String get owned => '已拥有';

  @override
  String get equipped => '已装备';

  @override
  String get shopSlotNone => '移除';

  @override
  String itemEquipped(String item) {
    return '已装备$item！';
  }

  @override
  String itemUnequipped(String slot) {
    return '已移除$slot';
  }

  @override
  String get slotHat => '帽子';

  @override
  String get slotGlasses => '眼镜';

  @override
  String get slotOutfit => '服装';

  @override
  String get insufficientPoints => '积分不足！😢';

  @override
  String get buyTitle => '购买物品？';

  @override
  String buyDescription(int price) {
    return '你想花 $price 星星购买这个物品吗？';
  }

  @override
  String get noBtn => '不';

  @override
  String get yesBuyBtn => '是的，买！';

  @override
  String itemBought(String item) {
    return '$item 已购买！ 🎉';
  }

  @override
  String get freePointsBtn => '观看广告赚取积分';

  @override
  String rewardEarned(int amount) {
    return '恭喜！你获得了 $amount 积分！ 🎉';
  }

  @override
  String get myQuestsTitle => '我的任务';

  @override
  String get questsScreenSubtitle => 'Complete quests and earn points!';

  @override
  String get questsDailySection => 'Daily Quests';

  @override
  String get questsWeeklySection => 'Weekly Quests';

  @override
  String get loadingQuests => '加载任务中...';

  @override
  String get dailyQuest => '每日任务';

  @override
  String get weeklyQuest => '每周任务';

  @override
  String get hat_blue_cap => '蓝帽';

  @override
  String get hat_crown => '皇冠';

  @override
  String get hat_wizard => '巫师帽';

  @override
  String get hat_flower => '花冠';

  @override
  String get hat_pirate => '海盗帽';

  @override
  String get hat_chef => '厨师帽';

  @override
  String get glasses_sun => '太阳镜';

  @override
  String get glasses_nerd => '书呆子眼镜';

  @override
  String get glasses_heart => '心形眼镜';

  @override
  String get glasses_3d => '3D 眼镜';

  @override
  String get glasses_vr => 'VR 头显';

  @override
  String get glasses_ski => '滑雪镜';

  @override
  String get glasses_mask => '面具';

  @override
  String get glasses_reading => '老花镜';

  @override
  String get outfit_red => '红衬衫';

  @override
  String get outfit_super => '超级英雄';

  @override
  String get outfit_green => '绿连帽衫';

  @override
  String get outfit_doctor => '医生大褂';

  @override
  String get outfit_space => '宇航服';

  @override
  String get outfit_sports => '球衣';

  @override
  String get outfit_police => '警服';

  @override
  String get outfit_chef => '厨师围裙';

  @override
  String get outfit_winter => '冬衣';

  @override
  String get outfit_tuxedo => '燕尾服';

  @override
  String get badgesTitle => '我的徽章';

  @override
  String get totalBadges => '总计:';

  @override
  String get filterAll => '全部';

  @override
  String get filterEarned => '已获得';

  @override
  String get filterLocked => '未解锁';

  @override
  String get numbersTitle => '学习数字';

  @override
  String get lettersTitle => '学习字母';

  @override
  String get shapesTitle => '学习形状';

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
