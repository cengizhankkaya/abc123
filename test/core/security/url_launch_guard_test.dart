import 'package:abc123/core/security/url_launch_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isAllowedExternalLaunchUri', () {
    test('https ve host kabul', () {
      expect(
        isAllowedExternalLaunchUri(Uri.parse('https://www.youtube.com/watch?v=x')),
        isTrue,
      );
    });

    test('http reddedilir', () {
      expect(
        isAllowedExternalLaunchUri(Uri.parse('http://evil.example/phish')),
        isFalse,
      );
    });

    test('ftp reddedilir', () {
      expect(
        isAllowedExternalLaunchUri(Uri.parse('ftp://files.example/file')),
        isFalse,
      );
    });
  });
}
