import 'package:start_dart/src/failures/failure.dart';

/// A complete state model for asynchronous UI data.
sealed class AsyncState<T> {
  const AsyncState();

  /// Creates a state before any work has started.
  const factory AsyncState.idle() = AsyncIdle<T>;

  /// Creates a loading state, optionally preserving stale [previousData].
  const factory AsyncState.loading({T? previousData}) = AsyncLoading<T>;

  /// Creates a state containing fresh [data].
  const factory AsyncState.data(T data) = AsyncData<T>;

  /// Creates a failed state, optionally preserving stale [previousData].
  const factory AsyncState.failure(Failure failure, {T? previousData}) =
      AsyncFailure<T>;

  /// The most recent data, including stale data during refresh or failure.
  T? get dataOrNull => switch (this) {
    AsyncIdle<T>() => null,
    AsyncLoading<T>(:final previousData) => previousData,
    AsyncData<T>(:final data) => data,
    AsyncFailure<T>(:final previousData) => previousData,
  };

  /// Whether an operation is currently in progress.
  bool get isLoading => this is AsyncLoading<T>;

  /// Transforms all data carried by the state.
  AsyncState<R> map<R>(R Function(T data) transform) => switch (this) {
    AsyncIdle<T>() => const AsyncState.idle(),
    AsyncLoading<T>(:final previousData) => AsyncState.loading(
      previousData: previousData == null ? null : transform(previousData),
    ),
    AsyncData<T>(:final data) => AsyncState.data(transform(data)),
    AsyncFailure<T>(:final failure, :final previousData) => AsyncState.failure(
      failure,
      previousData: previousData == null ? null : transform(previousData),
    ),
  };
}

/// No asynchronous operation has started.
final class AsyncIdle<T> extends AsyncState<T> {
  /// Creates an idle state.
  const AsyncIdle();
}

/// An asynchronous operation is in progress.
final class AsyncLoading<T> extends AsyncState<T> {
  /// Creates a loading state.
  const AsyncLoading({this.previousData});

  /// Stale data that can remain visible during refresh.
  final T? previousData;
}

/// An asynchronous operation completed successfully.
final class AsyncData<T> extends AsyncState<T> {
  /// Creates a state containing [data].
  const AsyncData(this.data);

  /// The current data.
  final T data;
}

/// An asynchronous operation completed with a [failure].
final class AsyncFailure<T> extends AsyncState<T> {
  /// Creates a failed state.
  const AsyncFailure(this.failure, {this.previousData});

  /// The typed application failure.
  final Failure failure;

  /// Stale data that can remain visible after failure.
  final T? previousData;
}
