import 'package:abc123/presentation/screens/drawscreen/models/drawing_content.dart';
import 'package:flutter/material.dart';

class LettersScreenController extends ChangeNotifier {
  // Aktif harf rehberi
  DrawingGuide _activeLetterGuide = DrawingContentProvider.activeLetterGuide;
  DrawingGuide get activeLetterGuide => _activeLetterGuide;

  // Mevcut seçili rehberi güncelle
  void updateActiveGuide() {
    _activeLetterGuide = DrawingContentProvider.activeLetterGuide;
    notifyListeners();
  }

  // Sonraki harfe geç
  void nextLetter() {
    _activeLetterGuide = DrawingContentProvider.nextLetterGuide();
    notifyListeners();
  }

  // Önceki harfe geç
  void previousLetter() {
    _activeLetterGuide = DrawingContentProvider.previousLetterGuide();
    notifyListeners();
  }

  // Belirli bir indeksteki harfe geç
  void goToLetter(int index) {
    DrawingContentProvider.setLetterGuideIndex(index);
    updateActiveGuide();
  }
}
