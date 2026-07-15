import 'package:flutter/material.dart';

/// Ada haritası renk sabitleri — `abc123-v7.html` CSS değişkenlerinden alınmıştır.
abstract final class IslandColors {
  // ── Deniz gradyanı ─────────────────────────────────────────────────────
  static const Color seaTop = Color(0xFF4FA8DE);
  static const Color seaMid = Color(0xFF7FC8EA);
  static const Color seaBot = Color(0xFFCDEFEA);

  // ── Mürekkep / yazı ────────────────────────────────────────────────────
  static const Color ink = Color(0xFF213255);
  static const Color muted = Color(0xFF6B7A9E);

  // ── Altın / mercan ─────────────────────────────────────────────────────
  static const Color gold = Color(0xFFFFC93C);
  static const Color goldDk = Color(0xFFE8A400);
  static const Color coral = Color(0xFFFF6B5B);
  static const Color coralDk = Color(0xFFE14F42);

  // ── Kum (gizem adası) ──────────────────────────────────────────────────
  static const Color sand = Color(0xFFF3E3B8);
  static const Color sandDk = Color(0xFFDCC28A);

  // ── Bölge ana renkleri ─────────────────────────────────────────────────
  static const Color numbers = Color(0xFFFF6B6B);
  static const Color numbersDk = Color(0xFFD6473F);
  static const Color letters = Color(0xFF4ECB71);
  static const Color lettersDk = Color(0xFF2FA351);
  static const Color shapes = Color(0xFF8A93A6);
  static const Color shapesDk = Color(0xFF5F6A80);
  static const Color words = Color(0xFFE0B24A);
  static const Color wordsDk = Color(0xFFB98A24);
  static const Color colors = Color(0xFFFF9F43);
  static const Color colorsDk = Color(0xFFE17E1A);
  static const Color vision = Color(0xFF6C63FF);
  static const Color visionDk = Color(0xFF4C41E0);
  static const Color boss = Color(0xFF2FBFC4);
  static const Color bossDk = Color(0xFF1C9297);

  // ── Bölge tint (açık ton — ada gradyan üstü) ───────────────────────────
  static const Color tintNumbers = Color(0xFFFFE29B);
  static const Color tintLetters = Color(0xFF8FDBA0);
  static const Color tintShapes = Color(0xFFB9C2CE);
  static const Color tintWords = Color(0xFFE7C25C);
  static const Color tintColors = Color(0xFFFFC98C);
  static const Color tintVision = Color(0xFFC9BFFF);
  static const Color tintBoss = Color(0xFFFFDD8A);
}
