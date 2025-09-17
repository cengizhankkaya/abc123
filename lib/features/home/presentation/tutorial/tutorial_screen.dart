import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoScreen extends StatelessWidget {
  final String youtubeUrl = 'https://www.youtube.com/watch?v=Dzg3JjjoeX8';

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse(youtubeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'YouTube açılamadı: $youtubeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran açılır açılmaz otomatik açmak için:
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchYoutube());

    return Scaffold(
      appBar: AppBar(title: Text('Abc123 Tutorial')),
      body: Center(
        child: Text('YouTube videosuna yönlendiriliyorsunuz...'),
      ),
    );
  }
}
