import 'package:abc123/core/error/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

/// `Future<Either<Failure, T>>` için kısa ad (`08_error_handling.md`).
typedef FutureResult<T> = Future<Either<Failure, T>>;
