import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_progress_aggregator_repository.dart';
class GetProgressSummaryUseCase {
  final IProgressAggregatorRepository _repository;

  GetProgressSummaryUseCase(this._repository);

  List<ModuleProgress> getAllModuleProgress() {
    return _repository.getAllModuleProgress();
  }

  double getOverallAccuracyRate() {
    return _repository.getOverallAccuracyRate();
  }

  double getOverallCompletionPercentage() {
    return _repository.getOverallCompletionPercentage();
  }
}
