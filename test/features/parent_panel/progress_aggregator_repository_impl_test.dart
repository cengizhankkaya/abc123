import 'package:abc123/core/error/exception_handler.dart';
import 'package:abc123/core/error/failure_mapper.dart';
import 'package:abc123/core/logging/loggers/console_logger.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:abc123/features/parent_panel/infrastructure/repositories/progress_aggregator_repository_impl.dart';
import 'package:abc123/features/parent_panel/infrastructure/repositories/recommendation_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeProgressSource implements ProgressSource {

  _FakeProgressSource({
    required this.moduleName,
    required this.completionPercentage,
    required this.accuracyRate,
    this.lastActivityDate,
    this.strugglingItems = const [],
  });
  @override
  final String moduleName;
  @override
  final double completionPercentage;
  @override
  final double accuracyRate;
  @override
  final DateTime? lastActivityDate;
  @override
  final List<String> strugglingItems;
}

void main() {
  group('ProgressAggregatorRepositoryImpl & RecommendationRepositoryImpl Testleri', () {
    test('Tüm kaynaklardan veriyi doğru toplar ve genel doğruluk hesaplar', () async {
      final s1 = _FakeProgressSource(
        moduleName: 'numbers',
        completionPercentage: 50,
        accuracyRate: 80,
        lastActivityDate: DateTime(2026, 7, 10),
        strugglingItems: ['5', '8'],
      );
      final s2 = _FakeProgressSource(
        moduleName: 'letters',
        completionPercentage: 100,
        accuracyRate: 90,
        lastActivityDate: DateTime(2026, 7, 9),
        strugglingItems: ['G'],
      );

      final service = ProgressAggregatorRepositoryImpl([s1, s2], ExceptionHandlerImpl(ConsoleLogger()), DefaultFailureMapper());

      final allResult = await service.getAllModuleProgress();
      final all = allResult.getOrElse((_) => []);
      expect(all.length, 2);
      expect(all[0].moduleName, 'numbers');
      expect(all[1].moduleName, 'letters');

      // Ortalama doğruluk: (80 + 90) / 2 = 85.0
      final accResult = await service.getOverallAccuracyRate();
      final acc = accResult.getOrElse((_) => 0.0);
      expect(acc, 85.0);
    });

    test('RecommendationRepositoryImpl zorlanılan öğeler veya düşük doğruluk için akıllı öneri üretir', () async {
      final p1 = ModuleProgress(
        moduleName: 'numbers',
        completionPercentage: 40,
        accuracyRate: 65,
        lastActivityDate: DateTime.now(),
        strugglingItems: ['4', '7', '8'],
      );

      final recsResult = await RecommendationRepositoryImpl(ExceptionHandlerImpl(ConsoleLogger()), DefaultFailureMapper()).generateRecommendations(
        progressList: [p1],
        isTurkish: true,
      );
      final recs = recsResult.getOrElse((_) => []);

      expect(recs, isNotEmpty);
      expect(recs.first.title, contains('Rakam'));
    });
  });
}
