// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'draw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class DrawLocalizationsTr extends DrawLocalizations {
  DrawLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String drawNumberInstruction(String number) {
    return '$number rakamını çiziniz';
  }

  @override
  String get drawAnyNumberInstruction => 'Bir rakam çiziniz';

  @override
  String get watchAdToUnlock => 'Bu Bölümü Açmak için Reklam izle Puan Topla';

  @override
  String get drawSequentialMode => 'Sıralı Çizme Modu:';

  @override
  String drawCorrectTotal(int correct, int total) {
    return 'Doğru: $correct / Toplam: $total';
  }

  @override
  String get drawClear => 'Temizle';

  @override
  String get drawPen => 'Kalem';

  @override
  String get drawEraser => 'Silgi';

  @override
  String get drawRecognize => 'Tanımla';

  @override
  String get drawPenColor => 'Kalem Rengi';

  @override
  String get drawNumberSectionTitle => 'Rakam Öğrenme';

  @override
  String get drawLetterSectionTitle => 'Harf Öğrenme';

  @override
  String get drawShapeSectionTitle => 'Şekil Öğrenme';

  @override
  String get drawWordSectionTitle => 'Kelime Oluşturma';

  @override
  String get drawLetterPuzzlePreparing => 'Puzzle hazırlanıyor…';

  @override
  String get drawGamePausedTitle => 'OYUN DURAKLATILDI';

  @override
  String get drawContinue => 'Devam Et';

  @override
  String get drawStartGame => 'OYUNU BAŞLAT';

  @override
  String drawBalloonReady(int count) {
    return '$count adet balonla oynamaya hazır mısın?';
  }

  @override
  String get drawBalloonScoreHint =>
      'Balonları patlatarak puan kazan!\nNe kadar küçük balon patlatırsan o kadar çok puan alırsın.';

  @override
  String get drawSemanticMute => 'Sesi kapat';

  @override
  String get drawSemanticUnmute => 'Sesi aç';

  @override
  String get drawSemanticDrawingCanvas => 'Çizim alanı. Parmağınla çiz.';

  @override
  String get drawSemanticPauseGame => 'Oyunu duraklat';

  @override
  String get drawSemanticResumeGame => 'Oyuna devam et';

  @override
  String get drawSemanticPenColorBlack => 'Siyah kalem rengi';

  @override
  String get drawSemanticPenColorRed => 'Kırmızı kalem rengi';

  @override
  String get drawSemanticPenColorBlue => 'Mavi kalem rengi';

  @override
  String get drawSemanticPenColorYellow => 'Sarı kalem rengi';

  @override
  String get drawSemanticPenColorGreen => 'Yeşil kalem rengi';

  @override
  String get drawSemanticPenColorPurple => 'Mor kalem rengi';

  @override
  String get drawSemanticPenColorOrange => 'Turuncu kalem rengi';

  @override
  String get drawAdLabel => 'Reklam';

  @override
  String get drawPredictionResult => 'Tahmin Sonucu:';

  @override
  String get drawRedraw => 'Yeniden Çiz';

  @override
  String get drawIdentifying => 'Tanımlanıyor...';

  @override
  String get drawCongratulations => 'Tebrikler!';

  @override
  String get drawAllBalloonsPopped => 'Tüm balonları patlattın!';

  @override
  String get drawBalloonsPreparing => 'Balonlar hazırlanıyor...';

  @override
  String get drawNoBalloonsYet => 'Henüz balon yok. Çizmeye başla!';

  @override
  String get drawStartBalloonGameByDrawing => 'Başlamak için çiz!';

  @override
  String get drawScore => 'Puan:';

  @override
  String get drawBalloonCount => 'Balon:';

  @override
  String get drawLevel => 'Seviye:';

  @override
  String get drawTimeLeft => 'Kalan Süre:';
}
