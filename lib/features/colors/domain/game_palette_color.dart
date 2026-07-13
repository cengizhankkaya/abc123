/// Renk eşleştirme paleti (18 renk) — `poolSize` ile listenin başından kesilir.
enum GamePaletteColor {
  red(0xFFE53935),
  blue(0xFF1E88E5),
  green(0xFF43A047),
  yellow(0xFFFDD835),
  orange(0xFFFB8C00),
  purple(0xFF8E24AA),
  pink(0xFFEC407A),
  cyan(0xFF00ACC1),
  brown(0xFF6D4C41),
  lime(0xFF9E9D24),
  teal(0xFF00897B),
  indigo(0xFF3949AB),
  magenta(0xFFC2185B),
  navy(0xFF1565C0),
  coral(0xFFFF6E40),
  gold(0xFFFFB300),
  violet(0xFF7E57C2),
  sky(0xFF039BE5);

  const GamePaletteColor(this.value);
  final int value;
}
