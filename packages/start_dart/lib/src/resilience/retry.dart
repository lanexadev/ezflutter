import 'dart:async';
import 'dart:math';

/// Decides whether [error] should be retried after [attempt] failed.
typedef RetryWhen = bool Function(Object error, int attempt);

/// Waits for a retry delay. Injectable to make tests deterministic.
typedef Delay = Future<void> Function(Duration duration);

/// Configuration for retrying transient operations.
final class RetryPolicy {
  /// Creates a retry policy.
  const RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 5),
    this.multiplier = 2,
    this.jitter = 0.1,
    this.retryWhen = _retryAll,
  }) : assert(maxAttempts > 0, 'maxAttempts must be greater than zero'),
       assert(multiplier >= 1, 'multiplier must be at least one'),
       assert(
         jitter >= 0 && jitter <= 1,
         'jitter must be between zero and one',
       );

  /// Total number of attempts, including the initial call.
  final int maxAttempts;

  /// Delay before the second attempt.
  final Duration initialDelay;

  /// Upper bound for a retry delay.
  final Duration maxDelay;

  /// Exponential backoff multiplier.
  final double multiplier;

  /// Random variation from zero to one, expressed as a ratio.
  final double jitter;

  /// Predicate used to reject non-transient errors.
  final RetryWhen retryWhen;

  /// Calculates the delay after [failedAttempt].
  Duration delayAfter(int failedAttempt, {double randomValue = 0.5}) {
    assert(failedAttempt > 0, 'failedAttempt must be greater than zero');
    assert(
      randomValue >= 0 && randomValue <= 1,
      'randomValue must be between zero and one',
    );
    final exponential =
        initialDelay.inMicroseconds * pow(multiplier, failedAttempt - 1);
    final capped = min(exponential, maxDelay.inMicroseconds).toDouble();
    final jitterFactor = 1 + ((randomValue * 2) - 1) * jitter;
    return Duration(microseconds: (capped * jitterFactor).round());
  }

  static bool _retryAll(Object error, int attempt) => true;
}

/// Runs [operation] according to [policy], rethrowing the final error with its
/// original stack trace.
Future<T> retry<T>(
  FutureOr<T> Function() operation, {
  RetryPolicy policy = const RetryPolicy(),
  Delay delay = Future<void>.delayed,
  Random? random,
}) async {
  final source = random ?? Random();
  for (var attempt = 1; attempt <= policy.maxAttempts; attempt++) {
    try {
      return await operation();
    } on Object catch (error, stackTrace) {
      final isFinalAttempt = attempt == policy.maxAttempts;
      if (isFinalAttempt || !policy.retryWhen(error, attempt)) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      await delay(
        policy.delayAfter(attempt, randomValue: source.nextDouble()),
      );
    }
  }
  throw StateError('Retry loop completed without returning or throwing.');
}
