import 'package:abc123/presentation/screens/drawscreen/models/drawing_content.dart';

/// Sıralı rakam ve harf çizimi için durum yönetim sınıfı
class SequentialDrawingManager {
  // Sıralı çizim modu aktif mi
  bool _isSequentialModeActive = false;

  // Kullanıcının çizmesi gereken mevcut rakam veya harf indeksi
  int _currentItemIndex = 0;

  // Doğru çizilen rakamların/harflerin sayısı
  int _correctlyDrawnCount = 0;

  // Toplam deneme sayısı
  int _totalAttempts = 0;

  // Ekran modu - varsayılan olarak rakam modu
  bool _isLetterMode = false;

  // Türkçe alfabe harfleri - EMNIST modelinin tanıyabildiği harfler
  final List<String> _letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  // Getters
  bool get isSequentialModeActive => _isSequentialModeActive;
  int get currentNumberIndex =>
      _currentItemIndex; // Eski adı korunmuştur (geriye dönük uyumluluk)
  int get correctlyDrawnCount => _correctlyDrawnCount;
  int get totalAttempts => _totalAttempts;
  bool get isLetterMode => _isLetterMode;

  // Ekran modunu ayarla - harf modu veya rakam modu
  set isLetterMode(bool value) {
    _isLetterMode = value;
  }

  // Çizilmesi gereken mevcut rakamı döndürür
  int get currentTargetNumber => _currentItemIndex % 10;

  // Çizilmesi gereken mevcut harfi döndürür - Yeni
  String get currentTargetLetter {
    if (_currentItemIndex >= 0 && _currentItemIndex < _letters.length) {
      return _letters[_currentItemIndex];
    }
    return 'A'; // Varsayılan olarak A harfi
  }

  // Sıralı modu aktif/pasif yapar
  void toggleSequentialMode(bool isActive) {
    _isSequentialModeActive = isActive;
    if (isActive) {
      // Modu aktif ederken sıfırla
      resetProgress();
    }
  }

  // İlerlemeyi sıfırla
  void resetProgress() {
    _currentItemIndex = 0;
    _correctlyDrawnCount = 0;
    _totalAttempts = 0;
  }

  // Mevcut aktif rehberi alır
  DrawingGuide getCurrentGuide() {
    // Harf modu aktifse ve harfler listesi doluysa
    if (_isLetterMode && _letters.isNotEmpty) {
      // Geçerli harfi alın, sınırları kontrol edin
      if (_currentItemIndex >= 0 && _currentItemIndex < _letters.length) {
        // Belirli bir harf rehberi bulunamazsa, genel bir harf rehberi al
        if (DrawingContentProvider.letterGuides.isNotEmpty) {
          // İndeks sınırları içinde kal
          int safeIndex =
              _currentItemIndex % DrawingContentProvider.letterGuides.length;
          return DrawingContentProvider.letterGuides[safeIndex];
        }
      }
    }

    // Rakam modu aktifse veya yukarıdaki koşullardan hiçbiri geçerli değilse, rakam rehberi döndür
    return DrawingContentProvider.numberGuides[currentTargetNumber];
  }

  // Rakam veya harf doğru tanındığında bir sonraki öğeye geç
  void moveToNextNumber(bool wasCorrect) {
    _totalAttempts++;

    if (wasCorrect) {
      _correctlyDrawnCount++;

      // Rakam modunda 0-9 arası döngü yap
      _currentItemIndex = (_currentItemIndex + 1) % 10;
    }
  }

  // Harf doğru tanındığında bir sonraki harfe geç
  void moveToNextLetter(bool wasCorrect) {
    _totalAttempts++;

    if (wasCorrect) {
      _correctlyDrawnCount++;

      // Harfler listesinde sonraki harfe geç
      if (_letters.isNotEmpty) {
        _currentItemIndex = (_currentItemIndex + 1) % _letters.length;
      }
    }
  }

  // Başarı oranını hesapla (yüzde olarak)
  double getSuccessRate() {
    if (_totalAttempts == 0) return 0.0;
    return (_correctlyDrawnCount / _totalAttempts) * 100;
  }

  // Tüm öğeleri tamamladı mı?
  bool hasCompletedAllItems() {
    return _correctlyDrawnCount >= 10; // Şimdilik 10 için
  }

  // Tanıma sonucunu değerlendir
  bool evaluateRecognitionResult(String recognizedItem) {
    // Rakam için
    if (!_isLetterMode &&
        recognizedItem.length == 1 &&
        int.tryParse(recognizedItem) != null) {
      return int.parse(recognizedItem) == currentTargetNumber;
    }
    // Harf için
    else if (_isLetterMode) {
      // Tanıma sonucunu ve hedef harfi büyük harfe çevirerek karşılaştırma
      String recognized = recognizedItem.trim().toUpperCase();
      String target = currentTargetLetter.trim().toUpperCase();

      // Tam eşleşme veya benzer harf kontrolü
      return recognized == target;
    }
    return false;
  }
}
