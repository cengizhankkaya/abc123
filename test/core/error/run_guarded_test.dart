@TestOn('vm')
library;

import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/core/error/run_guarded.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('runGuarded', () {
    test('başarılı aksiyonda Right döner', () async {
      final result = await runGuarded(() async => 42);

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => -1, (r) => r), 42);
    });

    test('istisnada UnexpectedFailure ile Left döner', () async {
      final result = await runGuarded<int>(() async {
        throw StateError('boom');
      });

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) {
          expect(l, isA<UnexpectedFailure>());
          expect((l as UnexpectedFailure).message, contains('boom'));
        },
        (_) => fail('Right olmamalı'),
      );
    });
  });
}
