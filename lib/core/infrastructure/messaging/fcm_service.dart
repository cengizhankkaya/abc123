import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Uygulama başlatıldığında çağrılacak background message handler.
///
/// Bu fonksiyon top-level olmalı (sınıf dışında) — Firebase zorunluluğu.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Background'da gelen mesajlar burada işlenir.
  // Firebase.initializeApp() zaten bootstrap'ta çağrıldığı için tekrar gerekmez.
  debugPrint('[FCM] Background message: ${message.messageId}');
}

/// Firebase Cloud Messaging servisini başlatır ve bildirim izinlerini yönetir.
///
/// Kullanım:
/// ```dart
/// await FcmService.initialize();
/// ```
final class FcmService {
  FcmService._();

  static FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  /// FCM'i başlatır, izin ister ve handler'ları kaydeder.
  static Future<void> initialize() async {
    // Background mesaj handler'ı kaydet.
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // iOS / macOS için bildirim izni iste.
    if (Platform.isIOS || Platform.isMacOS) {
      await _messaging.requestPermission();
    } else if (Platform.isAndroid) {
      // Android 13+ için POST_NOTIFICATIONS izni.
      await _messaging.requestPermission();
    }

    // Foreground'da gelen bildirimleri işle.
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Bildirime tıklanarak uygulama açıldığında (background → foreground).
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpened);

    // Uygulama kapalıyken bildirime tıklanarak açıldığında.
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      unawaited(_handleMessageOpened(initialMessage));
    }

    // FCM token'ı logla (geliştirme için).
    if (kDebugMode) {
      final token = await _messaging.getToken();
      debugPrint('[FCM] Token: $token');
    }
  }

  /// Foreground'da gelen mesajı işler.
  ///
  /// Foreground'da sistem bildirimi otomatik gösterilmez;
  /// uygulama içi banner için gerekirse flutter_local_notifications kullanılabilir.
  static void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[FCM] Foreground message: ${message.notification?.title}');
    // Opsiyonel: flutter_local_notifications ile local bildirim göster.
  }

  /// Bildirime tıklanınca çalışır — varsa store URL'ye yönlendirir.
  static Future<void> _handleMessageOpened(RemoteMessage message) async {
    debugPrint('[FCM] Message opened: ${message.data}');

    final action = message.data['action'] as String?;
    if (action == 'open_store') {
      await _openStore();
    }
  }

  /// Platform'a göre App Store / Play Store'u açar.
  static Future<void> _openStore() async {
    final Uri storeUrl;
    if (Platform.isIOS) {
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

  /// Güncel FCM token'ını döndürür.
  ///
  /// Belirli bir cihaza test bildirimi göndermek için kullanılabilir.
  static Future<String?> getToken() => _messaging.getToken();
}
