import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';
import 'package:abc123/features/parent_panel/domain/repositories/i_progress_aggregator_repository.dart';

class GetProgressSummary {
  GetProgressSummary(this._repository);
  final IProgressAggregatorRepository _repository;

  FutureResult<List<ModuleProgress>> getAllModuleProgress() async {
    return _repository.getAllModuleProgress();
  }

  FutureResult<double> getOverallAccuracyRate() async {
    return _repository.getOverallAccuracyRate();
  }

  FutureResult<double> getOverallCompletionPercentage() async {
    return _repository.getOverallCompletionPercentage();
  }
}
