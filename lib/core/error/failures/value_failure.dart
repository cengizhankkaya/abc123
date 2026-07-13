import 'package:abc123/core/error/failures/failure.dart';

abstract class ValueFailure<T> extends Failure {
  const ValueFailure();
  
  T? get failedValue => null;
}
