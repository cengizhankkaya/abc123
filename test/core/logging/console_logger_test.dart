import 'package:abc123/core/logging/loggers/console_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ConsoleLogger seviyeleri çağrılabilir', () {
    final logger = ConsoleLogger(name: 'test');
    expect(() => logger.debug('d', tag: 'T'), returnsNormally);
    expect(() => logger.info('i', tag: 'T'), returnsNormally);
    expect(() => logger.warning('w', tag: 'T'), returnsNormally);
    expect(
      () => logger.error('e', tag: 'T', error: StateError('x')),
      returnsNormally,
    );
    expect(
      () => logger.fatal('f', tag: 'T', error: StateError('x')),
      returnsNormally,
    );
  });
}
