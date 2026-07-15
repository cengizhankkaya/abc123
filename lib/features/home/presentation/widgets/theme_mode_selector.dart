import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/core/theme/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Açık / koyu / sistem tema seçimi (`ThemeModeProvider`).
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = ColorScheme.of(context);
    final mode = context.watch<ThemeModeProvider>().appThemeMode;

    return PopupMenuButton<AppThemeMode>(
      tooltip: l10n.themeModeTooltip,
      icon: Icon(
        switch (mode) {
          AppThemeMode.light => Icons.light_mode_outlined,
          AppThemeMode.dark => Icons.dark_mode_outlined,
          AppThemeMode.system => Icons.brightness_auto_outlined,
        },
        color: scheme.primary,
        size: 32,
      ),
      onSelected: (selected) async {
        await context.read<ThemeModeProvider>().setAppThemeMode(selected);
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: AppThemeMode.light,
          child: Row(
            children: [
              Icon(
                Icons.light_mode_outlined,
                color: mode == AppThemeMode.light ? scheme.primary : null,
              ),
              const SizedBox(width: 8),
              Text(l10n.themeModeLight),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppThemeMode.dark,
          child: Row(
            children: [
              Icon(
                Icons.dark_mode_outlined,
                color: mode == AppThemeMode.dark ? scheme.primary : null,
              ),
              const SizedBox(width: 8),
              Text(l10n.themeModeDark),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppThemeMode.system,
          child: Row(
            children: [
              Icon(
                Icons.brightness_auto_outlined,
                color: mode == AppThemeMode.system ? scheme.primary : null,
              ),
              const SizedBox(width: 8),
              Text(l10n.themeModeSystem),
            ],
          ),
        ),
      ],
    );
  }
}
