import 'dart:async';
import 'dart:io';

import 'package:abc123/core/domain/ports/i_remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Uygulama başlarken Firebase Remote Config'den minimum build numarasını
/// çeker ve mevcut build bu değerden küçükse kapatılamayan bir güncelleme
/// dialogu gösterir.
///
/// Güncelleme gerekmiyorsa [child] doğrudan gösterilir.
class ForceUpdateGate extends StatefulWidget {
  const ForceUpdateGate({
    required this.remoteConfigService,
    required this.child,
    super.key,
  });

  final IRemoteConfigService remoteConfigService;
  final Widget child;

  @override
  State<ForceUpdateGate> createState() => _ForceUpdateGateState();
}

class _ForceUpdateGateState extends State<ForceUpdateGate> {
  bool _updateRequired = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    unawaited(_checkForUpdate());
  }

  Future<void> _checkForUpdate() async {
    try {
      await widget.remoteConfigService.fetchAndActivate();
      final minimumBuildNumber = widget.remoteConfigService.minimumBuildNumber;
      final packageInfo = await PackageInfo.fromPlatform();
      final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      if (!mounted) return;
      setState(() {
        _updateRequired = currentBuildNumber < minimumBuildNumber;
        _checked = true;
      });
    } on Exception catch (_) {
      // Remote Config erişilemezse uygulamayı engellemiyoruz.
      if (mounted) setState(() => _checked = true);
    }
  }

  Future<void> _openStore() async {
    final Uri storeUrl;
    if (Platform.isIOS) {
      // TODO(dev): Replace with your actual App Store ID.
      storeUrl = Uri.parse('https://apps.apple.com/app/id6504882813');
    } else {
      storeUrl = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.cengizhan.abc123',
      );
    }

    if (await canLaunchUrl(storeUrl)) {
      await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kontrol tamamlanmadan uygulamayı göster (splash üzerinde sezilmez).
    if (!_checked) return widget.child;

    if (!_updateRequired) return widget.child;

    // Güncelleme gerekiyor — uygulamanın geri kalanı tamamen engellenir.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // İkon
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.system_update_rounded,
                        size: 52,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Başlık
                    const Text(
                      'Güncelleme Gerekli',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Açıklama
                    Text(
                      "abc123'ün daha iyi bir sürümü mevcut.\n"
                      'Uygulamaya devam edebilmek için lütfen güncelleyin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Güncelle butonu
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _openStore,
                        icon: const Icon(Icons.download_rounded),
                        label: const Text(
                          'Güncelle',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF0D47A1),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
