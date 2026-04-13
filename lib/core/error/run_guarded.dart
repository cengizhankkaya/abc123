import 'package:abc123/core/error/failures/unexpected_failure.dart';
import 'package:abc123/core/types/result.dart';
import 'package:fpdart/fpdart.dart';

/// İstisnaları [UnexpectedFailure] olarak [Left]'e çevirir.
FutureResult<T> runGuarded<T>(Future<T> Function() action) async {
  try {
    return right(await action());
  } catch (e, st) {
    return left(
      UnexpectedFailure(message: e.toString(), stackTrace: st),
    );
  }
}
