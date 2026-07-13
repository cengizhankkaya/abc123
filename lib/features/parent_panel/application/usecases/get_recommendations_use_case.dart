import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/entities/recommendation.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_recommendation_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecommendationsUseCase {
  final IRecommendationRepository _repository;

  GetRecommendationsUseCase(this._repository);

  FutureResult<List<Recommendation>> call({
    required List<ModuleProgress> progressList,
    required bool isTurkish,
  }) async {
    return await _repository.generateRecommendations(
      progressList: progressList,
      isTurkish: isTurkish,
    );
  }
}
