import 'package:abc123/features/parent_panel/data/models/module_progress.dart';
import 'package:abc123/features/parent_panel/data/services/progress_aggregator_service.dart';
import 'package:abc123/features/parent_panel/data/services/recommendation_engine.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeProgressSource implements ProgressSource {
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

  _FakeProgressSource({
    required this.moduleName,
    required this.completionPercentage,
    required this.accuracyRate,
    this.lastActivityDate,
    this.strugglingItems = const [],
  });
}

void main() {
  group('ProgressAggregatorService & RecommendationEngine Testleri', () {
    test('Tüm kaynaklardan veriyi doğru toplar ve genel doğruluk hesaplar', () {
      final s1 = _FakeProgressSource(
        moduleName: 'numbers',
        completionPercentage: 50.0,
        accuracyRate: 80.0,
        lastActivityDate: DateTime(2026, 7, 10),
        strugglingItems: ['5', '8'],
      );
      final s2 = _FakeProgressSource(
        moduleName: 'letters',
        completionPercentage: 100.0,
        accuracyRate: 90.0,
        lastActivityDate: DateTime(2026, 7, 9),
        strugglingItems: ['G'],
      );

      final service = ProgressAggregatorService([s1, s2]);

      final all = service.getAllModuleProgress();
      expect(all.length, 2);
      expect(all[0].moduleName, 'numbers');
      expect(all[1].moduleName, 'letters');

      // Ortalama doğruluk: (80 + 90) / 2 = 85.0
      expect(service.getOverallAccuracyRate(), 85.0);
    });

    test('RecommendationEngine zorlanılan öğeler veya düşük doğruluk için akıllı öneri üretir', () {
      final p1 = ModuleProgress(
        moduleName: 'numbers',
        completionPercentage: 40.0,
        accuracyRate: 65.0,
        lastActivityDate: DateTime.now(),
        strugglingItems: ['4', '7', '8'],
      );

      final recs = RecommendationEngine.generateRecommendations(
        progressList: [p1],
        isTurkish: true,
      );

      expect(recs, isNotEmpty);
      expect(recs.first.title, contains('Rakam'));
    });
  });
}
