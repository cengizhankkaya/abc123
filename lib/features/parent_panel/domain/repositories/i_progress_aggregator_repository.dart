import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';

abstract interface class IProgressAggregatorRepository {
  FutureResult<List<ModuleProgress>> getAllModuleProgress();
  FutureResult<double> getOverallAccuracyRate();
  FutureResult<double> getOverallCompletionPercentage();
}
