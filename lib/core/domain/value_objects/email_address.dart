import 'package:abc123/core/domain/base/value_object.dart';
import 'package:abc123/core/error/failures/value_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

sealed class EmailFailure extends ValueFailure<String> {
  const EmailFailure();

  const factory EmailFailure.invalidFormat({required String failedValue}) = _InvalidFormat;
  const factory EmailFailure.empty() = _Empty;
}

final class _InvalidFormat extends EmailFailure {
  const _InvalidFormat({required this.failedValue});
  @override
  final String failedValue;
}

final class _Empty extends EmailFailure {
  const _Empty();
}

/// E-posta adresini doğrulayan ve sargılayan value object.
///
/// Geçersiz format veya boş değer durumunda [EmailFailure] döndürür;
/// güvenilir kaynaktan gelen değerler için [EmailAddress.fromTrustedSource] kullanın.
///
/// ```dart
/// final email = EmailAddress('user@example.com');
/// email.value.fold(
///   (failures) => print('Geçersiz: $failures'),
///   (valid)    => print('E-posta: $valid'),
/// );
/// ```
@immutable
class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) {
    return EmailAddress._(_validateEmailAddress(input));
  }

  const EmailAddress._(this.value);

  factory EmailAddress.fromTrustedSource(String input) {
    return EmailAddress._(right(input));
  }
  @override
  final Either<List<ValueFailure<String>>, String> value;

  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static Either<List<ValueFailure<String>>, String> _validateEmailAddress(String? input) {
    if (input == null || input.isEmpty) {
      return left([const EmailFailure.empty()]);
    }

    if (!_emailRegex.hasMatch(input)) {
      return left([
        EmailFailure.invalidFormat(failedValue: input),
      ]);
    }

    return right(input.trim().toLowerCase());
  }
}
