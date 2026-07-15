import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/providers/theme_mode_provider.dart';
import 'package:abc123/core/theme/app_theme_mode.dart';
import 'package:abc123/features/home/l10n/generated/home_localizations.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/animated_choice_card.dart';
import 'package:abc123/features/home/presentation/widgets/child_name_editor.dart';
import 'package:abc123/features/home/presentation/widgets/settings_choice_bottom_sheet.dart';
import 'package:abc123/features/home/presentation/widgets/settings_section_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Hem çocuk hem ebeveyn için yeniden tasarlanmış, iki ana bölümlü,
/// oyunlaştırılmış mikro-etkileşimli ve tam erişilebilir Ayarlar ekranı.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return ColoredBox(
      color: HomeDesignTokens.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                  children: [
                    _TopHeader(title: h.settingsTitle),
                    const SizedBox(height: 24),

                    // BÖLÜM 1: BENİM AYARLARIM (Çocuk Odaklı)
                    SettingsSectionHeader(
                      title: h.settingsSectionChild ?? 'Benim Ayarlarım',
                      icon: Icons.child_care_rounded,
                      iconColor: HomeDesignTokens.headerBlue,
                    ),
                    const SizedBox(height: 8),
                    const _ChildSettingsSection(),

                    // GÖRSEL AYRAÇ & BOŞLUK
                    const SizedBox(height: 32),
                    const _VisualSeparator(),
                    const SizedBox(height: 32),

                    // BÖLÜM 2: EBEVEYN ALANI (Güven Veren, Sade Blok)
                    SettingsSectionHeader(
                      title: h.settingsSectionParent ?? 'Ebeveyn Alanı',
                      subtitle: h.settingsSectionParentWarning ??
                          'Ebeveynlere özel kontroller ve raporlar',
                      icon: Icons.security_rounded,
                      iconColor: HomeDesignTokens.parentPanelAccent,
                    ),
                    const SizedBox(height: 8),
                    const _ParentSettingsSection(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: HomeDesignTokens.headerBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.settings_rounded,
              color: HomeDesignTokens.headerBlue,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: HomeDesignTokens.headingLarge(
              color: HomeDesignTokens.darkText,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChildSettingsSection extends StatelessWidget {
  const _ChildSettingsSection();

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    final appL10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HomeDesignTokens.settingsSectionChild,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: HomeDesignTokens.settingsCardBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            h.settingsChildName,
            style: HomeDesignTokens.cardSubtitle(
              color: HomeDesignTokens.mutedText,
            ),
          ),
          const SizedBox(height: 8),
          Selector<GamificationProvider, String>(
            selector: (_, provider) => provider.childName,
            builder: (context, childName, _) {
              return ChildNameEditor(
                initialName: childName,
                onSave: (name) => context.read<GamificationProvider>().setChildName(name),
                hintText: h.settingsChildNameHint,
                saveText: h.settingsSaveName,
                savedText: h.settingsNameSavedShort ?? h.settingsNameSaved,
                emptyErrorText: h.settingsEmptyNameError ?? 'İsim boş olamaz',
              );
            },
          ),
          const SizedBox(height: 20),
          const Divider(
            color: HomeDesignTokens.settingsCardBorder,
            height: 1,
          ),
          const SizedBox(height: 20),

          // Tema Seçimi (Segmented Choice Cards)
          Text(
            h.settingsAppearance,
            style: HomeDesignTokens.cardSubtitle(
              color: HomeDesignTokens.mutedText,
            ),
          ),
          const SizedBox(height: 10),
          _ThemeSegmentedControl(h: h, appL10n: appL10n),
          const SizedBox(height: 20),
          const Divider(
            color: HomeDesignTokens.settingsCardBorder,
            height: 1,
          ),
          const SizedBox(height: 20),

          // Dil Seçimi (Modal Bottom Sheet tetikleyici kart)
          Text(
            h.settingsLanguage,
            style: HomeDesignTokens.cardSubtitle(
              color: HomeDesignTokens.mutedText,
            ),
          ),
          const SizedBox(height: 10),
          _LanguageChoiceCard(h: h),
        ],
      ),
    );
  }
}

class _ThemeSegmentedControl extends StatelessWidget {
  const _ThemeSegmentedControl({
    required this.h,
    required this.appL10n,
  });

  final HomeLocalizations h;
  final AppLocalizations? appL10n;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeModeProvider>().appThemeMode;

    return Row(
      children: [
        Expanded(
          child: AnimatedChoiceCard(
            title: h.settingsThemeLight ?? appL10n?.themeModeLight ?? 'Açık',
            leading: const Text('☀️', style: TextStyle(fontSize: 20)),
            isSelected: mode == AppThemeMode.light,
            showCheckmark: false,
            onTap: () => context.read<ThemeModeProvider>().setAppThemeMode(AppThemeMode.light),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AnimatedChoiceCard(
            title: h.settingsThemeDark ?? appL10n?.themeModeDark ?? 'Koyu',
            leading: const Text('🌙', style: TextStyle(fontSize: 20)),
            isSelected: mode == AppThemeMode.dark,
            showCheckmark: false,
            onTap: () => context.read<ThemeModeProvider>().setAppThemeMode(AppThemeMode.dark),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AnimatedChoiceCard(
            title: h.settingsThemeSystem ?? appL10n?.themeModeSystem ?? 'Sistem',
            leading: const Text('⚙️', style: TextStyle(fontSize: 20)),
            isSelected: mode == AppThemeMode.system,
            showCheckmark: false,
            onTap: () => context.read<ThemeModeProvider>().setAppThemeMode(AppThemeMode.system),
          ),
        ),
      ],
    );
  }
}

class _LanguageChoiceCard extends StatelessWidget {
  const _LanguageChoiceCard({required this.h});

  final HomeLocalizations h;

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<LanguageProvider>().language;
    final currentOption = supportedLanguages.firstWhere(
      (l) => l.value == currentLang,
      orElse: () => supportedLanguages.first,
    );

    return _InteractiveChoiceTile(
      leading: Text(currentOption.flag, style: const TextStyle(fontSize: 28)),
      title: currentOption.label,
      subtitle: currentOption.code,
      onTap: () => showLanguageSelectionBottomSheet(context),
    );
  }
}

class _ParentSettingsSection extends StatelessWidget {
  const _ParentSettingsSection();

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HomeDesignTokens.settingsSectionParent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: HomeDesignTokens.settingsParentCardBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: HomeDesignTokens.parentPanelAccent.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _ParentActionTile(
            icon: Icons.family_restroom_rounded,
            iconColor: HomeDesignTokens.parentPanelAccent,
            title: h.settingsParentPanel,
            subtitle: h.settingsParentPanelSubtitle,
            onTap: () => context.push(AppRoutes.parentPanel),
          ),
          const SizedBox(height: 12),
          _ParentActionTile(
            icon: Icons.play_circle_fill_rounded,
            iconColor: HomeDesignTokens.parentPanelChart,
            title: h.tutorial,
            subtitle: h.seeTutorial,
            onTap: () => context.push(AppRoutes.tutorial),
          ),
        ],
      ),
    );
  }
}

class _VisualSeparator extends StatelessWidget {
  const _VisualSeparator();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      excludeSemantics: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 6,
            decoration: BoxDecoration(
              color: HomeDesignTokens.headerBlue.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 6,
            decoration: BoxDecoration(
              color: HomeDesignTokens.lettersCard.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 16,
            height: 6,
            decoration: BoxDecoration(
              color: HomeDesignTokens.parentPanelAccent.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveChoiceTile extends StatefulWidget {
  const _InteractiveChoiceTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  State<_InteractiveChoiceTile> createState() => _InteractiveChoiceTileState();
}

class _InteractiveChoiceTileState extends State<_InteractiveChoiceTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${widget.title}, ${widget.subtitle}',
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          child: Container(
            constraints: const BoxConstraints(minHeight: 56, minWidth: 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: HomeDesignTokens.settingsChoiceInactiveBorder,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                widget.leading,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: HomeDesignTokens.cardTitle(
                          color: HomeDesignTokens.darkText,
                        ).copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: HomeDesignTokens.cardSubtitle(
                          color: HomeDesignTokens.mutedText,
                        ).copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HomeDesignTokens.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: HomeDesignTokens.darkText,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParentActionTile extends StatefulWidget {
  const _ParentActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  State<_ParentActionTile> createState() => _ParentActionTileState();
}

class _ParentActionTileState extends State<_ParentActionTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${widget.title}${widget.subtitle != null ? ', ${widget.subtitle}' : ''}',
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          child: Container(
            constraints: const BoxConstraints(minHeight: 64, minWidth: 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.iconColor.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.iconColor.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(widget.icon, color: widget.iconColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: HomeDesignTokens.cardTitle(
                          color: HomeDesignTokens.parentPanelHeader,
                        ).copyWith(fontSize: 16),
                      ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          widget.subtitle!,
                          style: HomeDesignTokens.cardSubtitle(
                            color: HomeDesignTokens.mutedText,
                          ).copyWith(fontSize: 13),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: HomeDesignTokens.mutedText,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
