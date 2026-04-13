/// Material Design 3 pencere genişliği sınıfları (`14_adaptive_ui_strategy.md`).
enum ScreenSize {
  compact,
  medium,
  expanded,
  large,
  extraLarge;

  /// Genişliğe göre [ScreenSize] döndürür (dp).
  static ScreenSize fromWidth(double width) {
    if (width < 600) return ScreenSize.compact;
    if (width < 840) return ScreenSize.medium;
    if (width < 1200) return ScreenSize.expanded;
    if (width < 1600) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }

  /// Telefon boyutu (compact).
  bool get isMobile => this == ScreenSize.compact;

  /// İki bölmeli düzen uygun mu (expanded ve üzeri).
  bool get supportsTwoPane => index >= ScreenSize.expanded.index;

  /// Üç bölmeli düzen uygun mu (large ve üzeri).
  bool get supportsThreePane => index >= ScreenSize.large.index;
}
