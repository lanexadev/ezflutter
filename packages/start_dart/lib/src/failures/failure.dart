import 'dart:collection';

/// A stable, user-safe description of an application failure.
///
/// [message] can be displayed to users. Put diagnostic details in [cause],
/// [stackTrace], or [metadata] and keep those values out of the UI.
sealed class Failure implements Exception {
  Failure({
    required this.code,
    required this.message,
    this.cause,
    this.stackTrace,
    Map<String, Object?> metadata = const {},
  }) : metadata = UnmodifiableMapView(Map.of(metadata));

  /// A machine-readable identifier suitable for analytics and branching.
  final String code;

  /// A safe, human-readable explanation.
  final String message;

  /// The original error, when one is available.
  final Object? cause;

  /// The original stack trace, when one is available.
  final StackTrace? stackTrace;

  /// Non-sensitive structured context for diagnostics.
  final Map<String, Object?> metadata;

  @override
  String toString() => 'Failure($code): $message';
}

/// A failure caused by invalid user or domain input.
final class ValidationFailure extends Failure {
  ValidationFailure({
    required super.message,
    super.code = 'validation.invalid',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure while communicating with a remote or local data source.
final class NetworkFailure extends Failure {
  NetworkFailure({
    required super.message,
    super.code = 'network.unavailable',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by missing or invalid authentication.
final class AuthenticationFailure extends Failure {
  AuthenticationFailure({
    required super.message,
    super.code = 'authentication.required',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by insufficient permissions.
final class AuthorizationFailure extends Failure {
  AuthorizationFailure({
    required super.message,
    super.code = 'authorization.denied',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by a missing resource.
final class NotFoundFailure extends Failure {
  NotFoundFailure({
    required super.message,
    super.code = 'resource.not_found',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by a state or write conflict.
final class ConflictFailure extends Failure {
  ConflictFailure({
    required super.message,
    super.code = 'resource.conflict',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by an operation exceeding its deadline.
final class TimeoutFailure extends Failure {
  TimeoutFailure({
    required super.message,
    super.code = 'operation.timeout',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure caused by intentional cancellation.
final class CancelledFailure extends Failure {
  CancelledFailure({
    required super.message,
    super.code = 'operation.cancelled',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}

/// A failure that cannot be represented by a more specific category.
final class UnexpectedFailure extends Failure {
  UnexpectedFailure({
    required super.message,
    super.code = 'unexpected',
    super.cause,
    super.stackTrace,
    super.metadata,
  });
}
