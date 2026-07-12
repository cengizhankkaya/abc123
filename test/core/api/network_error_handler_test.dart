import 'dart:io';

import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/api/exceptions/network_exception.dart';
import 'package:abc123/core/api/network_error_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAppLogger extends Mock implements AppLogger {}

void main() {
  late _MockAppLogger logger;
  late NetworkErrorHandler handler;

  setUp(() {
    logger = _MockAppLogger();
    handler = NetworkErrorHandler(logger);
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
        data: any(named: 'data'),
        tag: any(named: 'tag'),
      ),
    ).thenReturn(null);
  });

  test('SocketException NetworkException olarak yeniden fırlatılır', () {
    expect(
      () => handler.handleError(
        const SocketException('bağlantı yok'),
        StackTrace.empty,
      ),
      throwsA(isA<NetworkException>()),
    );
  });
}
