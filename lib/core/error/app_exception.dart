/// Base exception class for all application errors.
sealed class AppException implements Exception {
  const AppException(this.message, [this.originalError, this.stackTrace]);

  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  /// A human-readable name for this exception type.
  String get typeName;

  @override
  String toString() => '$typeName: $message';
}

/// Network-related errors (timeout, no internet, server error).
class NetworkException extends AppException {
  const NetworkException(super.message, [super.originalError, super.stackTrace]);

  @override
  String get typeName => 'NetworkException';
}

/// Authentication errors (unauthorized, token expired, forbidden).
class AuthException extends AppException {
  const AuthException(super.message, [super.originalError, super.stackTrace]);

  @override
  String get typeName => 'AuthException';
}

/// Cache/storage errors (read/write failure).
class CacheException extends AppException {
  const CacheException(super.message, [super.originalError, super.stackTrace]);

  @override
  String get typeName => 'CacheException';
}

/// Input validation errors.
class ValidationException extends AppException {
  const ValidationException(
    super.message, [
    super.originalError,
    super.stackTrace,
  ]);

  @override
  String get typeName => 'ValidationException';
}

/// Server returned an error response.
class ServerException extends AppException {
  const ServerException(
    String message, {
    this.statusCode,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(message, originalError, stackTrace);

  final int? statusCode;

  @override
  String get typeName => 'ServerException';
}
