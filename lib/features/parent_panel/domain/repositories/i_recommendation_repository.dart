import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/entities/recommendation.dart';

abstract interface class IRecommendationRepository {
  List<Recommendation> generateRecommendations({
    required List<ModuleProgress> progressList,
    required bool isTurkish,
  });
}
