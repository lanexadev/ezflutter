import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart/start_dart.dart';

void main() {
  group('Result', () {
    test('maps a successful value', () {
      const result = Result<int>.success(2);

      final mapped = result.map((value) => value * 3);

      expect(mapped, isA<Success<int>>().having((it) => it.value, 'value', 6));
    });

    test('preserves a failure while mapping', () {
      final failure = UnexpectedFailure(message: 'Failed');
      final result = Result<int>.failure(failure);

      final mapped = result.map((value) => value * 3);

      expect(
        mapped,
        isA<Failed<int>>().having((it) => it.failure, 'failure', same(failure)),
      );
    });

    test('flatMaps a successful value', () {
      const result = Result<int>.success(2);

      final mapped = result.flatMap((value) => Result.success('$value!'));

      expect(
        mapped,
        isA<Success<String>>().having((it) => it.value, 'value', '2!'),
      );
    });

    test('folds a failure', () {
      final result = Result<int>.failure(
        ValidationFailure(message: 'Invalid'),
      );

      final message = result.fold(
        onSuccess: (value) => '$value',
        onFailure: (failure) => failure.message,
      );

      expect(message, 'Invalid');
    });

    test('maps a successful value asynchronously', () async {
      const result = Result<int>.success(2);

      final mapped = await result.mapAsync((value) async => value + 1);

      expect(mapped, isA<Success<int>>().having((it) => it.value, 'value', 3));
    });

    test('computes a fallback for a failure', () {
      final result = Result<int>.failure(
        UnexpectedFailure(message: 'Failed'),
      );

      final value = result.getOrElse((_) => 42);

      expect(value, 42);
    });
  });
}
