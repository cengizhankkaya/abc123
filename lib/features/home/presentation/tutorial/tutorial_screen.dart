import 'package:abc123/core/l10n/generated/app_localizations.dart';
import 'package:abc123/core/infrastructure/security/url_launch_guard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoScreen extends StatelessWidget {
  final String youtubeUrl = 'https://www.youtube.com/watch?v=Dzg3JjjoeX8';

  Future<void> _launchYoutube(BuildContext context) async {
    final url = Uri.parse(youtubeUrl);
    if (!isAllowedExternalLaunchUri(url)) {
      if (context.mounted) {
        final msg = AppLocalizations.of(context)!.tutorialHttpsOnlyMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
      return;
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
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
