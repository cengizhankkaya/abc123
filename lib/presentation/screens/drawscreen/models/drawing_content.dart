import 'package:abc123/core/constants/image_constants.dart';
import 'package:flutter/material.dart';

/// Sabit resim yolları için sınıf

/// Çizim rehberi modeli
class DrawingGuide {
  final String imagePath;

  DrawingGuide({
    required this.imagePath,
  });
}

/// Yardım bilgisi modeli
class HelpInfo {
  final String title;
  final String description;
  final IconData icon;

  HelpInfo({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Tüm rakamlar ve harfler için rehber ve yardım içeriklerini sağlayan sınıf
class DrawingContentProvider {
  // Tüm rakamlar için çizim rehberleri
  static final List<DrawingGuide> numberGuides = [
    DrawingGuide(
      imagePath: ImageFigures.zero,
    ),
    DrawingGuide(
      imagePath: ImageFigures.one,
    ),
    DrawingGuide(
      imagePath: ImageFigures.two,
    ),
    DrawingGuide(
      imagePath: ImageFigures.three,
    ),
    DrawingGuide(
      imagePath: ImageFigures.four,
    ),
    DrawingGuide(
      imagePath: ImageFigures.five,
    ),
    DrawingGuide(
      imagePath: ImageFigures.six,
    ),
    DrawingGuide(
      imagePath: ImageFigures.seven,
    ),
    DrawingGuide(
      imagePath: ImageFigures.eight,
    ),
    DrawingGuide(
      imagePath: ImageFigures.nine,
    ),
  ];

  // Tüm harfler için çizim rehberleri
  static final List<DrawingGuide> letterGuides = [
    DrawingGuide(
      imagePath: ImageFigures.letterA,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterB,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterC,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterD,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterE,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterF,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterG,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterH,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterI,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterJ,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterK,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterL,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterM,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterN,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterO,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterP,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterQ,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterR,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterS,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterT,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterU,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterV,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterW,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterX,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterY,
    ),
    DrawingGuide(
      imagePath: ImageFigures.letterZ,
    ),
  ];

  // Aktif rakam rehberi indeksi
  static int _activeGuideIndex = 0;

  // Aktif harf rehberi indeksi
  static int _activeLetterGuideIndex = 0;

  // Aktif rakam rehberini al
  static DrawingGuide get activeGuide => numberGuides[_activeGuideIndex];

  // Aktif harf rehberini al
  static DrawingGuide get activeLetterGuide => letterGuides.isNotEmpty
      ? letterGuides[_activeLetterGuideIndex % letterGuides.length]
      : numberGuides[0];

  // Rakam rehberi indeksini değiştir
  static void setGuideIndex(int index) {
    if (index >= 0 && index < numberGuides.length) {
      _activeGuideIndex = index;
    }
  }

  // Harf rehberi indeksini değiştir
  static void setLetterGuideIndex(int index) {
    if (letterGuides.isNotEmpty && index >= 0 && index < letterGuides.length) {
      _activeLetterGuideIndex = index;
    }
  }

  // Sonraki rakam rehberine geç
  static DrawingGuide nextGuide() {
    _activeGuideIndex = (_activeGuideIndex + 1) % numberGuides.length;
    return activeGuide;
  }

  // Önceki rakam rehberine geç
  static DrawingGuide previousGuide() {
    _activeGuideIndex =
        (_activeGuideIndex - 1 + numberGuides.length) % numberGuides.length;
    return activeGuide;
  }

  // Sonraki harf rehberine geç
  static DrawingGuide nextLetterGuide() {
    if (letterGuides.isNotEmpty) {
      _activeLetterGuideIndex =
          (_activeLetterGuideIndex + 1) % letterGuides.length;
      return activeLetterGuide;
    }
    return activeGuide; // Harf rehberi yoksa rakam rehberi döndür
  }

  // Önceki harf rehberine geç
  static DrawingGuide previousLetterGuide() {
    if (letterGuides.isNotEmpty) {
      _activeLetterGuideIndex =
          (_activeLetterGuideIndex - 1 + letterGuides.length) %
              letterGuides.length;
      return activeLetterGuide;
    }
    return activeGuide; // Harf rehberi yoksa rakam rehberi döndür
  }

  // Harf rehberlerini alma metodları
  static DrawingGuide getLetterGuide(int index) {
    if (letterGuides.isNotEmpty && index >= 0 && index < letterGuides.length) {
      return letterGuides[index];
    }
    // Eğer harf rehberi yoksa veya indeks geçersizse, rakam rehberi döndür
    return numberGuides[0]; // Varsayılan olarak ilk rakam rehberini döndür
  }

  // Yardım bilgilerini al
  static List<HelpInfo> getHelpInfos() {
    return [
      HelpInfo(
        title: "1. Kalem rengi ve boyutunu seçin",
        description: "Üst panelden istediğiniz kalemi ayarlayabilirsiniz.",
        icon: Icons.palette,
      ),
      HelpInfo(
        title: "2. Bir rakam çizin",
        description:
            "Orta paneldeki beyaz alana bir rakam çizin. Sol taraftaki rehberden yardım alabilirsiniz.",
        icon: Icons.edit,
      ),
      HelpInfo(
        title: "3. Tanımlama yapın",
        description:
            "Çizimi tamamladığınızda 'Tanımla' butonuna basarak yapay zeka ile rakamı tanımlayın.",
        icon: Icons.psychology,
      ),
      HelpInfo(
        title: "4. Temizle butonu",
        description: "Çizimi silmek için 'Temizle' butonunu kullanabilirsiniz.",
        icon: Icons.delete_outline,
      ),
      HelpInfo(
        title: "5. Silgi kullanımı",
        description: "Silgi butonuyla çizimin bir kısmını silebilirsiniz.",
        icon: Icons.cleaning_services_outlined,
      ),
    ];
  }
}
