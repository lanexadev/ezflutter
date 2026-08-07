import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart/start_dart.dart';

void main() {
  group('AsyncState', () {
    test('exposes stale data while loading', () {
      const state = AsyncState<int>.loading(previousData: 12);

      final data = state.dataOrNull;

      expect(data, 12);
    });

    test('exposes stale data after failure', () {
      final state = AsyncState<int>.failure(
        NetworkFailure(message: 'Offline'),
        previousData: 12,
      );

      final data = state.dataOrNull;

      expect(data, 12);
    });

    test('maps fresh data', () {
      const state = AsyncState<int>.data(4);

      final mapped = state.map((data) => 'value:$data');

      expect(
        mapped,
        isA<AsyncData<String>>().having(
          (it) => it.data,
          'data',
          'value:4',
        ),
      );
    });

    test('maps stale data while preserving a failure', () {
      final failure = NetworkFailure(message: 'Offline');
      final state = AsyncState<int>.failure(failure, previousData: 4);

      final mapped = state.map((data) => 'value:$data');

      expect(
        mapped,
        isA<AsyncFailure<String>>()
            .having((it) => it.previousData, 'previousData', 'value:4')
            .having((it) => it.failure, 'failure', same(failure)),
      );
    });
  });
}
