import 'package:abc123/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// İş durumu renkleri — [ColorScheme.error] dışındaki pozitif / uyarı / bilgi.
@immutable
class SemanticColors extends ThemeExtension<SemanticColors> {
  const SemanticColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color info;

  static const SemanticColors light = SemanticColors(
    success: AppColors.successColor,
    warning: AppColors.warningColor,
    info: AppColors.infoColor,
  );

  static const SemanticColors dark = SemanticColors(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFB74D),
    info: Color(0xFF64B5F6),
  );

  @override
  SemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return SemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  SemanticColors lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) {
      return this;
    }
    return SemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

/// Matematik (numbers_advanced) modülü için özel renkler.
@immutable
class MathColors extends ThemeExtension<MathColors> {
  const MathColors({
    required this.purple,
    required this.teal,
    required this.orange,
    required this.yellow,
    required this.deepPurple,
  });

  final Color purple;
  final Color teal;
  final Color orange;
  final Color yellow;
  final Color deepPurple;

  static const MathColors light = MathColors(
    purple: Color(0xFF6C63FF),
    teal: Color(0xFF00CEC9),
    orange: Color(0xFFE17055),
    yellow: Color(0xFFFDCB6E),
    deepPurple: Color(0xFF6C5CE7),
  );

  static const MathColors dark = MathColors(
    purple: Color(0xFF8C84FF),
    teal: Color(0xFF4DD8D5),
    orange: Color(0xFFE99682),
    yellow: Color(0xFFFFD98C),
    deepPurple: Color(0xFF8C7FFF),
  );

  @override
  MathColors copyWith({
    Color? purple,
    Color? teal,
    Color? orange,
    Color? yellow,
    Color? deepPurple,
  }) {
    return MathColors(
      purple: purple ?? this.purple,
      teal: teal ?? this.teal,
      orange: orange ?? this.orange,
      yellow: yellow ?? this.yellow,
      deepPurple: deepPurple ?? this.deepPurple,
    );
  }

  @override
  MathColors lerp(ThemeExtension<MathColors>? other, double t) {
    if (other is! MathColors) {
      return this;
    }
    return MathColors(
      purple: Color.lerp(purple, other.purple, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      deepPurple: Color.lerp(deepPurple, other.deepPurple, t)!,
    );
  }
}
