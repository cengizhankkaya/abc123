import 'package:abc123/core/error/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

/// E-posta doğrulama hatası — [EmailAddress] value object'i ile birlikte yaşar
/// (`01_project_structure.md` — Value Objects and Failures).
sealed class EmailFailure extends Failure {
  const EmailFailure();

  /// E-posta formatı geçersiz.
  const factory EmailFailure.invalid() = _Invalid;

  /// E-posta adresi boş.
  const factory EmailFailure.empty() = _Empty;
}

final class _Invalid extends EmailFailure {
  const _Invalid();
}

final class _Empty extends EmailFailure {
  const _Empty();
}

/// E-posta adresini temsil eden value object (`01_project_structure.md`).
///
/// Kimliği yoktur; eşitlik değere göre belirlenir.
/// Doğrulama başarısız olursa [EmailFailure] döner.
///
/// ```dart
/// final email = EmailAddress.create('test@example.com');
/// email.fold(
///   (failure) => print('Geçersiz: $failure'),
///   (address) => print('Geçerli: ${address.value}'),
/// );
/// ```
final class EmailAddress {
  const EmailAddress._(this.value);

  /// Doğrulanmış e-posta adresi.
  final String value;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  /// [raw] e-posta adresini doğrular ve [EmailAddress] veya [EmailFailure] döner.
  static Either<EmailFailure, EmailAddress> create(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const Left(EmailFailure.empty());
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return const Left(EmailFailure.invalid());
    }
    return Right(EmailAddress._(trimmed));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAddress && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EmailAddress($value)';
}
