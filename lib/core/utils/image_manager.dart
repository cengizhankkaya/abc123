import 'package:abc123/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ImageManager {
  // Varsayılan görsel yükleyici - kaliteyi korur
  static Widget getImage(String path,
      {double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      BorderRadius? borderRadius}) {
    Widget image = Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
    );

    // Eğer borderRadius belirtilmişse, ClipRRect kullan
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
    }

    return image;
  }

  // Robot görseli
  static Widget getRobotImage(
      {double? width, double? height, BorderRadius? borderRadius}) {
    return getImage(
      ImageConstants.robotImage,
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  // Numara görseli
  static Widget getNumberImage(
      {double? width, double? height, BorderRadius? borderRadius}) {
    return getImage(
      ImageConstants.numberImage,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
    );
  }

  // ABC görseli
  static Widget getABCImage(
      {double? width, double? height, BorderRadius? borderRadius}) {
    return getImage(
      ImageConstants.abcImage,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
    );
  }

  // Öğretici görseli
  static Widget getTutorialImage(
      {double? width, double? height, BorderRadius? borderRadius}) {
    return getImage(
      ImageConstants.tutorialImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      borderRadius: borderRadius,
    );
  }

  // Ders ikonu
  static Widget getLessonIcon({double? width, double? height, Color? color}) {
    return Image.asset(
      ImageConstants.lessonIcon,
      width: width,
      height: height,
      color: color,
    );
  }

  // Ekle ikonu
  static Widget getAddIcon({double? width, double? height, Color? color}) {
    return Image.asset(
      ImageConstants.addIcon,
      width: width,
      height: height,
      color: color,
    );
  }

  // Ayarlar ikonu
  static Widget getSettingsIcon({double? width, double? height, Color? color}) {
    return Image.asset(
      ImageConstants.settingsIcon,
      width: width,
      height: height,
      color: color,
    );
  }

  // Görsel varlığını kontrol et
  static Future<bool> checkImageExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      debugPrint('Görsel bulunamadı: $path');
      return false;
    }
  }

  // Yedek görsel (varsayılan)
  static Widget getPlaceholderImage(
      {double? width, double? height, String? text}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text ?? 'Görsel',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
