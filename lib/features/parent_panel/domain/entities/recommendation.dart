

/// Ebeveyn Paneli'nde gösterilecek akıllı öneri modeli.
class Recommendation {

  const Recommendation({
    required this.title,
    required this.description,
    required this.targetModule,
    required this.routePath,
    required this.iconCode,
    required this.accentColorArgb,
  });
  final String title;
  final String description;
  final String targetModule;
  final String routePath;
  final String iconCode;
  final int accentColorArgb;
}
