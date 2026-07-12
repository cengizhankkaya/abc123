import 'package:abc123/features/parent_panel/domain/entities/module_progress.dart';

abstract interface class IProgressAggregatorRepository {
  List<ModuleProgress> getAllModuleProgress();
  double getOverallAccuracyRate();
  double getOverallCompletionPercentage();
}
