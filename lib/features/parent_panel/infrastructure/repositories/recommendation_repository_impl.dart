import 'package:abc123/core/infrastructure/base/base_repository.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/entities/recommendation.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_recommendation_repository.dart';
import 'package:injectable/injectable.dart';

/// Ebeveyn Paneli için kural tabanlı akıllı öneri motoru.
@LazySingleton(as: IRecommendationRepository)
class RecommendationRepositoryImpl extends BaseRepository implements IRecommendationRepository {
  RecommendationRepositoryImpl(
    super.exceptionHandler,
    super.failureMapper,
  );

  /// Modül verilerini analiz ederek ebeveyn için eylem odaklı öneriler üretir.
  @override
  FutureResult<List<Recommendation>> generateRecommendations({
    required List<ModuleProgress> progressList,
    required bool isTurkish,
  }) => execute(() async {
    final recommendations = <Recommendation>[];

    for (final module in progressList) {
      if (module.moduleName == 'numbers') {
        if (module.strugglingItems.isNotEmpty || (module.accuracyRate < 75.0 && module.completionPercentage > 0)) {
          final itemsText = module.strugglingItems.isNotEmpty
              ? module.strugglingItems.take(3).join(', ')
              : (isTurkish ? 'bazı rakamlar' : 'some digits');
          recommendations.add(
            Recommendation(
              title: isTurkish
                  ? 'Rakam Pratiğini Güçlendirin'
                  : 'Strengthen Number Practice',
              description: isTurkish
                  ? 'Çocuğunuz özellikle ($itemsText) çiziminde zorlanıyor. Düzenli tekrar önerilir.'
                  : 'Your child is struggling with ($itemsText). Regular practice is recommended.',
              targetModule: 'numbers',
              routePath: AppRoutes.draw,
              iconCode: 'numbers_rounded',
              accentColorArgb: 0xFF6C63FF,
            ),
          );
        }
      } else if (module.moduleName == 'letters') {
        if (module.strugglingItems.isNotEmpty || (module.accuracyRate < 75.0 && module.completionPercentage > 0)) {
          final itemsText = module.strugglingItems.isNotEmpty
              ? module.strugglingItems.take(3).join(', ')
              : (isTurkish ? 'zor harfler' : 'tricky letters');
          recommendations.add(
            Recommendation(
              title: isTurkish
                  ? 'Harf Çizimlerine Odaklanın'
                  : 'Focus on Letter Drawings',
              description: isTurkish
                  ? 'Son çalışmalarda ($itemsText) harflerinde hata oranı yüksek. Harfler modülünde alıştırma yapın.'
                  : 'Recent attempts show difficulties in letters ($itemsText). Practice in Letters module.',
              targetModule: 'letters',
              routePath: AppRoutes.letters,
              iconCode: 'abc_rounded',
              accentColorArgb: 0xFF2196F3,
            ),
          );
        }
      } else if (module.moduleName == 'shapes') {
        if (module.strugglingItems.isNotEmpty || (module.accuracyRate < 70.0 && module.completionPercentage > 0)) {
          recommendations.add(
            Recommendation(
              title: isTurkish
                  ? 'Geometrik Şekilleri Tekrar Edin'
                  : 'Review Geometric Shapes',
              description: isTurkish
                  ? 'Daire, Kare ve Üçgen çizimlerinde doğruluk oranını artırmak için şekiller modülünü açın.'
                  : 'Open the Shapes module to improve drawing accuracy for Circle, Square, and Triangle.',
              targetModule: 'shapes',
              routePath: AppRoutes.shapes,
              iconCode: 'category_rounded',
              accentColorArgb: 0xFFFF9800,
            ),
          );
        }
      } else if (module.moduleName == 'math_advanced') {
        if (module.strugglingItems.isNotEmpty || (module.accuracyRate < 75.0 && module.completionPercentage > 0)) {
          final itemsText = module.strugglingItems.isNotEmpty
              ? module.strugglingItems.take(2).join(', ')
              : (isTurkish ? 'işlemler' : 'operations');
          recommendations.add(
            Recommendation(
              title: isTurkish
                  ? 'Matematik İşlemlerini Geliştirin'
                  : 'Improve Math Operations',
              description: isTurkish
                  ? 'En çok ($itemsText) alanında pratik gerekiyor. Görsel & Sembolik işlemleri deneyin.'
                  : 'More practice needed specifically in ($itemsText). Try Visual & Symbolic operations.',
              targetModule: 'math_advanced',
              routePath: AppRoutes.mathAdvanced,
              iconCode: 'calculate_rounded',
              accentColorArgb: 0xFFE91E63,
            ),
          );
        }
      } else if (module.moduleName == 'words') {
        if (module.completionPercentage < 20.0 && progressList.any((p) => p.moduleName == 'letters' && p.completionPercentage > 30.0)) {
          recommendations.add(
            Recommendation(
              title: isTurkish
                  ? 'Kelime Çizmeye Başlama Zamanı'
                  : 'Time to Build Words',
              description: isTurkish
                  ? 'Harf bilgisi gelişti! Artık harfleri birleştirerek kelimeler oluşturma pratiği yapabilirsiniz.'
                  : 'Letter recognition has improved! Try combining letters to build words now.',
              targetModule: 'words',
              routePath: AppRoutes.words,
              iconCode: 'spellcheck_rounded',
              accentColorArgb: 0xFF00B0FF,
            ),
          );
        }
      }
    }

    // Hiçbir kritik öneri yoksa veya liste boşsa harika gidiyor önerisi
    if (recommendations.isEmpty) {
      recommendations.add(
        Recommendation(
          title: isTurkish
              ? 'Harika İlerleme! Düzenli Çalışmaya Devam'
              : 'Excellent Progress! Keep Up Regular Practice',
          description: isTurkish
              ? 'Tüm modüllerde doğruluk ve ilerleme oranları çok iyi seviyede. Günlük görevlerle pratikleri sürdürün.'
              : 'Accuracy and progress rates are very high across all modules. Keep practicing with daily quests.',
          targetModule: 'home',
          routePath: AppRoutes.quests,
          iconCode: 'auto_awesome_rounded',
          accentColorArgb: 0xFF00C853,
        ),
      );
    }

    return recommendations;
  });
}
