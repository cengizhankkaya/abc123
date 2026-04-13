import 'package:abc123/core/types/result.dart';
import 'package:fpdart/fpdart.dart';

/// Okuma: kalıcı durumu değiştirmez (CQRS — Query, `04_application_layer.md`).
abstract class AsyncQueryNoParams<Output> {
  Future<Output> call();
}

/// Okuma; hata [Either] ile taşınır (`08_error_handling.md`).
abstract class AsyncQueryNoParamsResult<Output> {
  FutureResult<Output> call();
}

/// Yazma: dış sistem / kalıcılık üzerinden yan etki (CQRS — Command).
abstract class AsyncCommand<Input> {
  Future<void> call(Input input);
}

/// Yazma; hata [Either] ile taşınır (`08_error_handling.md`).
abstract class AsyncCommandResult<Input> {
  FutureResult<Unit> call(Input input);
}
