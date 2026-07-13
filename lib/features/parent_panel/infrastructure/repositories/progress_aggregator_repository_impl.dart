import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:fpdart/fpdart.dart';

import 'package:abc123/features/parent_panel/domain/repositories/i_progress_aggregator_repository.dart';

/// Tüm modül provider'larından [ProgressSource] arayüzü üzerinden veri çeken,
/// bunları ortak [ModuleProgress] modellerine dönüştüren merkezi veri hub'ı servisi.
class ProgressAggregatorRepositoryImpl implements IProgressAggregatorRepository {
  final List<ProgressSource> _sources;

  const ProgressAggregatorRepositoryImpl(this._sources);

  /// Kayıtlı tüm modüllerin ilerleme modellerini döndürür.
  @override
  FutureResult<List<ModuleProgress>> getAllModuleProgress() async {
    return right(_sources.map((source) => ModuleProgress.fromSource(source)).toList());
  }

  /// Tüm modüllerdeki genel ortalama doğruluk oranını (% olarak) hesaplar.
  @override
  FutureResult<double> getOverallAccuracyRate() async {
    if (_sources.isEmpty) return right(0.0);
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
      return right(100.0);
    }
    return right((sum / count).clamp(0.0, 100.0));
  }

  /// Tüm modüllerdeki genel ortalama tamamlanma yüzdesini hesaplar.
  @override
  FutureResult<double> getOverallCompletionPercentage() async {
    if (_sources.isEmpty) return right(0.0);
    double sum = 0.0;
    for (final s in _sources) {
      sum += s.completionPercentage;
    }
    return right((sum / _sources.length).clamp(0.0, 100.0));
  }
}
