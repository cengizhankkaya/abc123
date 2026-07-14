import 'package:abc123/features/parent_panel/domain/progress_source.dart';

/// Ebeveyn Paneli'nde gösterilecek tekil modülün ilerleme modeli.
class ModuleProgress {

  const ModuleProgress({
    required this.moduleName,
    required this.completionPercentage,
    required this.accuracyRate,
    required this.strugglingItems, this.lastActivityDate,
  });

  /// Bir [ProgressSource] örneğinden [ModuleProgress] modeli üretir.
  factory ModuleProgress.fromSource(ProgressSource source) {
    return ModuleProgress(
      moduleName: source.moduleName,
      completionPercentage: source.completionPercentage.clamp(0.0, 100.0),
      accuracyRate: source.accuracyRate.clamp(0.0, 100.0),
      lastActivityDate: source.lastActivityDate,
      strugglingItems: List<String>.from(source.strugglingItems),
    );
  }
  final String moduleName;
  final double completionPercentage;
  final double accuracyRate;
  final DateTime? lastActivityDate;
  final List<String> strugglingItems;
}
