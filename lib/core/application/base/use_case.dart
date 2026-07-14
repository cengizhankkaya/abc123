import 'package:abc123/core/types/result.dart';

/// Represents a Command (write operation) with parameters.
abstract class Command<Params, Output> {
  FutureResult<Output> call(Params params);
}

/// Represents a Command (write operation) without parameters.
abstract class CommandNoParams<Output> {
  FutureResult<Output> call();
}

/// Represents a Query (read operation) with parameters.
abstract class Query<Params, Output> {
  FutureResult<Output> call(Params params);
}

/// Represents a Query (read operation) without parameters.
abstract class QueryNoParams<Output> {
  FutureResult<Output> call();
}

/// Represents a reactive Command (write operation) with parameters.
abstract class StreamCommand<Params, Output> {
  Stream<Output> call(Params params);
}

/// Represents a reactive Query (read operation) with parameters.
abstract class StreamQuery<Params, Output> {
  Stream<Output> call(Params params);
}

/// Represents a reactive Query (read operation) without parameters.
abstract class StreamQueryNoParams<Output> {
  Stream<Output> call();
}
