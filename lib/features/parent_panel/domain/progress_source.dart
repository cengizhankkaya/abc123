/// Tüm öğrenme modüllerinin (Rakamlar, Harfler, Şekiller, Kelimeler, Sayılar/Matematik vb.)
/// Ebeveyn Paneli'ne ortak veri sağlaması için uygulaması gereken arayüz (Interface).
abstract class ProgressSource {
  /// Modülün tekil kimliği/adı (örn. 'numbers', 'letters', 'shapes', 'words', 'math_advanced').
  String get moduleName;

  /// Modülün tamamlanma yüzdesi (0.0 ile 100.0 arasında).
  double get completionPercentage;

  /// Modüldeki genel doğruluk oranı (0.0 ile 100.0 arasında).
  double get accuracyRate;

  /// Bu modülde yapılan son aktivite tarihi (hiç aktivite yoksa null).
  DateTime? get lastActivityDate;

  /// En çok hata yapılan / zorlanılan öğelerin listesi (Harf, Rakam veya İşlem adları).
  List<String> get strugglingItems;
}
