import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppLanguage>(
      icon: Icon(Icons.language, color: Colors.orange, size: 32),
      onSelected: (AppLanguage selectedLang) async {
        await context.read<LanguageProvider>().setLanguage(selectedLang);
      },
      itemBuilder: (context) => [
        for (final langOption in supportedLanguages)
          PopupMenuItem(
            value: langOption.value,
            child: Row(
              children: [
                Text(langOption.flag),
                SizedBox(width: 8),
                Text(langOption.label),
              ],
            ),
          ),
      ],
    );
  }
}
