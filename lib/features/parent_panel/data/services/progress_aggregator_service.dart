import 'package:abc123/features/parent_panel/data/models/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';

/// Tüm modül provider'larından [ProgressSource] arayüzü üzerinden veri çeken,
/// bunları ortak [ModuleProgress] modellerine dönüştüren merkezi veri hub'ı servisi.
class ProgressAggregatorService {
  final List<ProgressSource> _sources;

  const ProgressAggregatorService(this._sources);

  /// Kayıtlı tüm modüllerin ilerleme modellerini döndürür.
  List<ModuleProgress> getAllModuleProgress() {
    return _sources.map((source) => ModuleProgress.fromSource(source)).toList();
  }

  /// Tüm modüllerdeki genel ortalama doğruluk oranını (% olarak) hesaplar.
  double getOverallAccuracyRate() {
    if (_sources.isEmpty) return 0.0;
    double sum = 0.0;
    int count = 0;
    for (final s in _sources) {
      if (s.completionPercentage > 0 || s.lastActivityDate != null || s.accuracyRate > 0) {
        sum += s.accuracyRate;
        count++;
      }
    }
    if (count == 0) {
      // Henüz aktivite yoksa varsayılan
      return 100.0;
    }
    return (sum / count).clamp(0.0, 100.0);
  }

  /// Tüm modüllerdeki genel ortalama tamamlanma yüzdesini hesaplar.
  double getOverallCompletionPercentage() {
    if (_sources.isEmpty) return 0.0;
    double sum = 0.0;
    for (final s in _sources) {
      sum += s.completionPercentage;
    }
    return (sum / _sources.length).clamp(0.0, 100.0);
  }
}
