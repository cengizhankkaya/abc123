import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/language_selector.dart';
import 'package:abc123/features/home/presentation/widgets/theme_mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _nameController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final name = context.read<GamificationProvider>().childName;
      _nameController = TextEditingController(text: name);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _nameController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            Text(
              h.settingsTitle,
              style: HomeDesignTokens.headingSection(),
            ),
            const SizedBox(height: 24),
            Text(
              h.settingsChildName,
              style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: h.settingsChildNameHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                context.read<GamificationProvider>().setChildName(value);
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<GamificationProvider>().setChildName(_nameController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(h.settingsNameSaved)),
                  );
                },
                child: Text(h.settingsSaveName),
              ),
            ),
            const SizedBox(height: 16),
            _SettingsTile(
              icon: Icons.brightness_6_outlined,
              title: h.settingsAppearance,
              trailing: const ThemeModeSelector(),
            ),
            const SizedBox(height: 12),
            _SettingsTile(
              icon: Icons.language_outlined,
              title: h.settingsLanguage,
              trailing: const LanguageSelector(),
            ),
            const SizedBox(height: 12),
            _SettingsTile(
              icon: Icons.family_restroom_rounded,
              title: h.settingsParentPanel,
              subtitle: h.settingsParentPanelSubtitle,
              onTap: () => context.push(AppRoutes.parentPanel),
            ),
            const SizedBox(height: 12),
            _SettingsTile(
              icon: Icons.play_circle_outline,
              title: h.tutorial,
              onTap: () => context.push(AppRoutes.tutorial),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: HomeDesignTokens.headerBlue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: HomeDesignTokens.cardTitle(color: HomeDesignTokens.darkText),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: HomeDesignTokens.cardSubtitle(color: HomeDesignTokens.mutedText),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              if (onTap != null)
                const Icon(Icons.chevron_right, color: HomeDesignTokens.mutedText),
            ],
          ),
        ),
      ),
    );
  }
}
