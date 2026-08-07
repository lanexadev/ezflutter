import 'package:nativiq/src/failures/failure.dart';

/// The explicit outcome of an operation that can fail.
sealed class Result<T> {
  const Result();

  /// Creates a successful result.
  const factory Result.success(T value) = Success<T>;

  /// Creates a failed result.
  const factory Result.failure(Failure failure) = Failed<T>;

  /// Whether this result contains a value.
  bool get isSuccess => this is Success<T>;

  /// Whether this result contains a failure.
  bool get isFailure => this is Failed<T>;

  /// Transforms this result into a single value.
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => switch (this) {
    Success<T>(:final value) => onSuccess(value),
    Failed<T>(:final failure) => onFailure(failure),
  };

  /// Transforms a successful value and preserves failures.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success<T>(:final value) => Result.success(transform(value)),
    Failed<T>(:final failure) => Result.failure(failure),
  };

  /// Chains an operation that also returns a [Result].
  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
    Success<T>(:final value) => transform(value),
    Failed<T>(:final failure) => Result.failure(failure),
  };

  /// Asynchronously transforms a successful value and preserves failures.
  Future<Result<R>> mapAsync<R>(
    Future<R> Function(T value) transform,
  ) async => switch (this) {
    Success<T>(:final value) => Result.success(await transform(value)),
    Failed<T>(:final failure) => Result.failure(failure),
  };

  /// Returns the value or computes a fallback from the failure.
  T getOrElse(T Function(Failure failure) fallback) => switch (this) {
    Success<T>(:final value) => value,
    Failed<T>(:final failure) => fallback(failure),
  };
}

/// A successful [Result].
final class Success<T> extends Result<T> {
  /// Creates a successful result containing [value].
  const Success(this.value);

  /// The successful value.
  final T value;
}

/// A failed [Result].
final class Failed<T> extends Result<T> {
  /// Creates a failed result containing [failure].
  const Failed(this.failure);

  /// The typed application failure.
  final Failure failure;
}
