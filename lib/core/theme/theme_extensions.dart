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
