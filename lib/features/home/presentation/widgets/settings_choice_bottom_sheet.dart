import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/animated_choice_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Dil seçimi için çocuk dostu, büyük dokunma alanlı modal bottom sheet.
void showLanguageSelectionBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: HomeDesignTokens.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) => const _LanguageBottomSheetContent(),
  );
}

class _LanguageBottomSheetContent extends StatelessWidget {
  const _LanguageBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    final currentLang = context.watch<LanguageProvider>().language;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: HomeDesignTokens.navInactive.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HomeDesignTokens.colorsCard.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.language_rounded,
                    color: HomeDesignTokens.colorsCard,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    h.settingsChooseLanguage ?? h.settingsLanguage,
                    style: HomeDesignTokens.headingSection(
                      color: HomeDesignTokens.darkText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + bottomInset),
              itemCount: supportedLanguages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final option = supportedLanguages[index];
                final isSelected = option.value == currentLang;

                return AnimatedChoiceCard(
                  title: option.label,
                  subtitle: option.code,
                  leading: Text(
                    option.flag,
                    style: const TextStyle(fontSize: 26),
                  ),
                  isSelected: isSelected,
                  activeBorderColor: HomeDesignTokens.colorsCard,
                  activeBgColor: HomeDesignTokens.colorsCard.withValues(alpha: 0.1),
                  minHeight: 56.0,
                  onTap: () async {
                    await context.read<LanguageProvider>().setLanguage(option.value);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
