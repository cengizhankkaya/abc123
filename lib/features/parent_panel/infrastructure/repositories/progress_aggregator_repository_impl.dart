import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_progress_aggregator_repository.dart';

/// Tüm modül provider'larından [ProgressSource] arayüzü üzerinden veri çeken,
/// bunları ortak [ModuleProgress] modellerine dönüştüren merkezi veri hub'ı servisi.
class ProgressAggregatorRepositoryImpl extends BaseRepository
    implements IProgressAggregatorRepository {
  ProgressAggregatorRepositoryImpl(
    this._sources,
    super.exceptionHandler,
    super.failureMapper,
  );
  final List<ProgressSource> _sources;

  /// Kayıtlı tüm modüllerin ilerleme modellerini döndürür.
  @override
  FutureResult<List<ModuleProgress>> getAllModuleProgress() => execute(() async {
        return _sources.map(ModuleProgress.fromSource).toList();
      });

  /// Tüm modüllerdeki genel ortalama doğruluk oranını (% olarak) hesaplar.
  @override
  FutureResult<double> getOverallAccuracyRate() => execute(() async {
        if (_sources.isEmpty) return 0.0;
        var sum = 0;
        var count = 0;
        for (final s in _sources) {
          if (s.completionPercentage > 0 || s.lastActivityDate != null || s.accuracyRate > 0) {
            sum += s.accuracyRate as int;
            count++;
          }
        }
        if (count == 0) {
          // Henüz aktivite yoksa varsayılan
          return 100.0;
        }
        return (sum / count).clamp(0.0, 100.0);
      });

  /// Tüm modüllerdeki genel ortalama tamamlanma yüzdesini hesaplar.
  @override
  FutureResult<double> getOverallCompletionPercentage() => execute(() async {
        if (_sources.isEmpty) return 0.0;
        var sum = 0;
        for (final s in _sources) {
          sum += s.completionPercentage as int;
        }
        return (sum / _sources.length).clamp(0.0, 100.0);
      });
}
