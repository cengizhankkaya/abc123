import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_progress_aggregator_repository.dart';
class GetProgressSummaryUseCase {
  final IProgressAggregatorRepository _repository;

  GetProgressSummaryUseCase(this._repository);

  FutureResult<List<ModuleProgress>> getAllModuleProgress() async {
    return await _repository.getAllModuleProgress();
  }

  FutureResult<double> getOverallAccuracyRate() async {
    return await _repository.getOverallAccuracyRate();
  }

  FutureResult<double> getOverallCompletionPercentage() async {
    return await _repository.getOverallCompletionPercentage();
  }
}
