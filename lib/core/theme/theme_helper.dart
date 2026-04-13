import 'package:abc123/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

extension ThemeAccessX on BuildContext {
  /// [SemanticColors] tema uzantısı (`23_theming.md`).
  SemanticColors get semanticColors {
    final ext = Theme.of(this).extension<SemanticColors>();
    assert(ext != null, 'SemanticColors ThemeExtension eksik');
    return ext!;
  }

  ColorScheme get appColorScheme => ColorScheme.of(this);

  TextTheme get appTextTheme => TextTheme.of(this);
}
