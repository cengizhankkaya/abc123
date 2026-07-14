import 'package:abc123/core/error/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef StreamResult<T> = Stream<Either<Failure, T>>;
