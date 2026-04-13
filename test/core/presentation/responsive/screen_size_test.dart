import 'package:abc123/core/presentation/responsive/screen_size.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScreenSize.fromWidth', () {
    test('599 ve altı compact', () {
      expect(ScreenSize.fromWidth(599), ScreenSize.compact);
      expect(ScreenSize.fromWidth(0), ScreenSize.compact);
    });

    test('600–839 medium', () {
      expect(ScreenSize.fromWidth(600), ScreenSize.medium);
      expect(ScreenSize.fromWidth(839), ScreenSize.medium);
    });

    test('840–1199 expanded', () {
      expect(ScreenSize.fromWidth(840), ScreenSize.expanded);
      expect(ScreenSize.fromWidth(1199), ScreenSize.expanded);
    });

    test('1200–1599 large', () {
      expect(ScreenSize.fromWidth(1200), ScreenSize.large);
      expect(ScreenSize.fromWidth(1599), ScreenSize.large);
    });

    test('1600+ extraLarge', () {
      expect(ScreenSize.fromWidth(1600), ScreenSize.extraLarge);
    });
  });

  group('ScreenSize bayrakları', () {
    test('supportsTwoPane expanded ve üzeri', () {
      expect(ScreenSize.compact.supportsTwoPane, isFalse);
      expect(ScreenSize.medium.supportsTwoPane, isFalse);
      expect(ScreenSize.expanded.supportsTwoPane, isTrue);
      expect(ScreenSize.large.supportsThreePane, isTrue);
    });
  });
}
