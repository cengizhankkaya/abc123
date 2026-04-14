import 'package:abc123/features/colors/domain/color_vision_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RG zayıf, BY iyi → redGreenAxisLikely', () {
    final p = resolveColorVisionProfile(
      rgCorrect: 1,
      rgTotal: 6,
      byCorrect: 4,
      byTotal: 4,
    );
    expect(p, ColorVisionHeuristicProfile.redGreenAxisLikely);
  });

  test('BY zayıf, RG iyi → blueYellowAxisLikely', () {
    final p = resolveColorVisionProfile(
      rgCorrect: 6,
      rgTotal: 6,
      byCorrect: 1,
      byTotal: 4,
    );
    expect(p, ColorVisionHeuristicProfile.blueYellowAxisLikely);
  });

  test('Her ikisi de iyi → typical', () {
    final p = resolveColorVisionProfile(
      rgCorrect: 5,
      rgTotal: 6,
      byCorrect: 3,
      byTotal: 4,
    );
    expect(p, ColorVisionHeuristicProfile.typical);
  });
}
