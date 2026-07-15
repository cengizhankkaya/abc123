import 'package:abc123/core/error/failures/value_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class UnexpectedValueError extends Error {
  UnexpectedValueError(this.failures);
  final List<ValueFailure> failures;

  @override
  String toString() {
    return Error.safeToString(
        'Encountered a ValueFailure at an unrecoverable point. Terminating. Failures: $failures');
  }
}

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<List<ValueFailure<T>>, T> get value;

  T getOrCrash() {
    return value.fold(
      (failures) => throw UnexpectedValueError(failures),
      (v) => v,
    );
  }

  T? getOrNull() => value.fold((_) => null, (v) => v);

  bool get isValid => value.isRight();

  List<ValueFailure<T>>? getFailuresOrNull() => value.fold(
        (failures) => failures,
        (_) => null,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueObject($value)';
}
