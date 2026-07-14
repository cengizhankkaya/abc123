import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_url_launcher.dart';
import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class YoutubeVideoScreen extends StatelessWidget {
  const YoutubeVideoScreen({super.key});

  final String youtubeUrl = 'https://www.youtube.com/watch?v=Dzg3JjjoeX8';

  Future<void> _launchYoutube(BuildContext context) async {
    final url = Uri.parse(youtubeUrl);
    final launcher = getIt<IUrlLauncher>();
    if (!launcher.isAllowed(url)) {
      if (context.mounted) {
        final msg = AppLocalizations.of(context)!.tutorialHttpsOnlyMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
      return;
    }
    final success = await launcher.launch(url);
    if (!success && context.mounted) {
      final msg = AppLocalizations.of(context)!.tutorialOpenFailedMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran açılır açılmaz otomatik açmak için:
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchYoutube(context));

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tutorialScreenTitle)),
      body: Center(
        child: Text(l10n.tutorialRedirectMessage),
      ),
    );
  }
}
