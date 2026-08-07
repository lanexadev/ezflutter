import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart/start_dart.dart';

void main() {
  group('RetryPolicy', () {
    test('calculates deterministic exponential backoff', () {
      const policy = RetryPolicy(
        initialDelay: Duration(milliseconds: 100),
        maxDelay: Duration(seconds: 1),
        jitter: 0,
      );

      final delays = [
        policy.delayAfter(1),
        policy.delayAfter(2),
        policy.delayAfter(3),
      ];

      expect(delays, const [
        Duration(milliseconds: 100),
        Duration(milliseconds: 200),
        Duration(milliseconds: 400),
      ]);
    });

    test('caps exponential backoff at the maximum delay', () {
      const policy = RetryPolicy(
        initialDelay: Duration(milliseconds: 500),
        maxDelay: Duration(seconds: 1),
        jitter: 0,
      );

      final delay = policy.delayAfter(5);

      expect(delay, const Duration(seconds: 1));
    });
  });

  group('retry', () {
    test('returns after a transient operation succeeds', () async {
      var calls = 0;
      final delays = <Duration>[];

      final value = await retry<int>(
        () {
          calls++;
          if (calls < 3) throw const FormatException('Transient');
          return 42;
        },
        policy: const RetryPolicy(jitter: 0),
        delay: (duration) async => delays.add(duration),
      );

      expect(
        (value, calls, delays.length),
        (42, 3, 2),
      );
    });

    test('rethrows after the final attempt', () async {
      var calls = 0;

      final operation = retry<void>(
        () {
          calls++;
          throw StateError('Still failing');
        },
        policy: const RetryPolicy(maxAttempts: 2),
        delay: (_) async {},
        random: Random(1),
      );

      await expectLater(operation, throwsStateError);
      expect(calls, 2);
    });

    test('does not retry a rejected error', () async {
      var calls = 0;

      final operation = retry<void>(
        () {
          calls++;
          throw const FormatException('Permanent');
        },
        policy: RetryPolicy(retryWhen: (_, _) => false),
        delay: (_) async {},
      );

      await expectLater(operation, throwsFormatException);
      expect(calls, 1);
    });
  });
}
