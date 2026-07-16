import 'dart:async';

import 'package:abc123/core/domain/ports/i_app_review_service.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAppReviewService)
class AppReviewService implements IAppReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  static const String _kSuccessCountKey = 'app_review_success_count';
  static const String _kHasRequestedKey = 'app_review_has_requested';

  @override
  Future<void> requestReviewIfNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final hasRequested = prefs.getBool(_kHasRequestedKey) ?? false;
      if (hasRequested) {
        return; // Daha önce oylama istendiyse tekrar rahatsız etme
      }

      int count = prefs.getInt(_kSuccessCountKey) ?? 0;
      count++;
      await prefs.setInt(_kSuccessCountKey, count);

      // Hedef başarı sayısına (3) ulaşıldıysa oylama penceresini göster
      if (count == 3) {
        if (await _inAppReview.isAvailable()) {
          // Bu metod native bir oylama (rating) popup'ı çıkarır
          await _inAppReview.requestReview();
          
          // Gösterildiğini kaydet ki bir daha sormasın
          await prefs.setBool(_kHasRequestedKey, true);
        }
      }
    } catch (e) {
      // SharedPreferences veya in_app_review hatalarında oyunu kesintiye uğratma
    }
  }
}
