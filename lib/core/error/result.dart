import 'package:ezflutter/core/error/app_exception.dart';

/// A Result type for error handling without exceptions.
///
/// Usage:
/// ```dart
/// final result = await fetchUser(42);
/// result.when(
///   success: (user) => showProfile(user),
///   failure: (error) => showError(error.message),
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(AppException error) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  AppException? get errorOrNull => switch (this) {
        Success() => null,
        Failure(:final error) => error,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(AppException error) failure,
  }) =>
      switch (this) {
        Success(:final data) => success(data),
        Failure(:final error) => failure(error),
      };

  Result<R> map<R>(R Function(T data) transform) => switch (this) {
        Success(:final data) => Result.success(transform(data)),
        Failure(:final error) => Result.failure(error),
      };

  Future<Result<R>> asyncMap<R>(
    Future<R> Function(T data) transform,
  ) async =>
      switch (this) {
        Success(:final data) => Result.success(await transform(data)),
        Failure(:final error) => Result.failure(error),
      };
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppException error;
}
