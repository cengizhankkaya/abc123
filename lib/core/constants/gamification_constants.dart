class GamificationConstants {
  // Point Values
  static const int pointsPerCorrectDraw = 10;
  static const int pointsPerStreakDay = 50;

  // Badge IDs
  static const String badgeFirstLogin = 'badge_first_login';
  static const String badgeFirstDraw = 'badge_first_draw';
  static const String badgeStreak3 = 'badge_streak_3';
  static const String badgeStreak7 = 'badge_streak_7';
  static const String badgeStreak30 = 'badge_streak_30'; // New
  static const String badgeBronzeArtist = 'badge_bronze_artist'; // 10 drawings
  static const String badgeSilverArtist = 'badge_silver_artist'; // 50 drawings
  static const String badgeMasterArtist = 'badge_master_artist'; // 100 drawings
  static const String badgeGoldArtist = 'badge_gold_artist'; // 250 drawings
  static const String badgeDiamondArtist =
      'badge_diamond_artist'; // 500 drawings
  static const String badgeEarlyBird = 'badge_early_bird'; // Morning login
  static const String badgeNightOwl = 'badge_night_owl'; // Night login
  static const String badgeWeekendWarrior =
      'badge_weekend_warrior'; // Weekend login

  // Category Badges
  static const String badgeNumberMaster = 'badge_number_master'; // 50 numbers
  static const String badgeLetterMaster = 'badge_letter_master'; // 50 letters
  static const String badgeShapeMaster = 'badge_shape_master'; // 50 shapes

  // Meta Badges (Score & Collection)
  static const String badgeHighScorer = 'badge_high_scorer'; // 1000 points
  static const String badgeScoreLegend = 'badge_score_legend'; // 5000 points
  static const String badgeBadgeCollector = 'badge_badge_collector'; // 5 badges
  static const String badgeBadgeMaster = 'badge_badge_master'; // 15 badges

  // Storage Keys
  static const String keyPoints = 'user_points';
  static const String keyStreak = 'user_streak';
  static const String keyLastLoginDate = 'last_login_date';
  static const String keyUnlockedBadges = 'unlocked_badges';
  static const String keyTotalDrawings = 'total_drawings';
  static const String keyNumberDrawings = 'number_drawings';
  static const String keyLetterDrawings = 'letter_drawings';
  static const String keyShapeDrawings = 'shape_drawings';

  // Shop Keys
  static const String keyOwnedItems = 'owned_items';
  static const String keyEquippedItems = 'equipped_items';
}

enum DrawingType { number, letter, shape, any }
