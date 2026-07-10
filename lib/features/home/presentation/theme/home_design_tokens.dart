import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Ana sayfa mockup renkleri ve tipografi sabitleri.
abstract final class HomeDesignTokens {
  static const Color background = Color(0xFFFAF8F5);
  static const Color headerBlue = Color(0xFF5B9FD4);
  static const Color headerCircle = Color(0x66FFFFFF);
  static const Color darkText = Color(0xFF2D3436);
  static const Color mutedText = Color(0xFF636E72);
  static const Color navActive = Color(0xFFFF7675);
  static const Color navInactive = Color(0xFFB2BEC3);
  static const Color continueIconBlue = Color(0xFF74B9FF);

  static const Color numbersCard = Color(0xFFFF7675);
  static const Color lettersCard = Color(0xFF6BCB77);
  static const Color shapesCard = Color(0xFFFFD93D);
  static const Color wordsCard = Color(0xFF9B59B6);
  static const Color colorsCard = Color(0xFFFFB74D);
  static const Color colorVisionCard = Color(0xFF7E6BCE);
  static const Color mathCard = Color(0xFF6C63FF);

  static const double headerBottomRadius = 32;
  static const double cardRadius = 20;
  static const double continueCardRadius = 20;
  static const Color continueSubtitleText = Color(0xFF95A5A6);

  static const Color parentPanelHeader = Color(0xFF2D2051);
  static const Color parentPanelAccent = Color(0xFF6C5CE7);
  static const Color parentPanelChart = Color(0xFF74B9FF);

  // Settings Screen Semantic Tokens
  static const Color settingsSectionChild = Color(0xFFFFF9F2);
  static const Color settingsSectionParent = Color(0xFFF4F1FE);
  static const Color settingsCardBorder = Color(0xFFE9ECEF);
  static const Color settingsParentCardBorder = Color(0xFFD6C8FF);
  static const Color settingsChoiceActiveBg = Color(0xFFEBF8FF);
  static const Color settingsChoiceActiveBorder = Color(0xFF5B9FD4);
  static const Color settingsChoiceInactiveBorder = Color(0xFFE2E8F0);
  static const Color checkmarkGreen = Color(0xFF6BCB77);
  static const Color settingsTileHover = Color(0xFFF8F9FA);

  static TextStyle headingLarge({Color color = Colors.white}) {
    return GoogleFonts.nunito(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle headingSection({Color color = darkText}) {
    return GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = Colors.white}) {
    return GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle cardTitle({required Color color}) {
    return GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle cardSubtitle({required Color color}) {
    return GoogleFonts.nunito(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle navLabel({required Color color}) {
    return GoogleFonts.nunito(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle continueTitle({Color color = darkText}) {
    return GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.25,
    );
  }

  static TextStyle continueSubtitle({Color color = continueSubtitleText}) {
    return GoogleFonts.nunito(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle continueBadgeText({Color color = Colors.white}) {
    return GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1,
    );
  }
}
