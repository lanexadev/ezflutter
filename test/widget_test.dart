import 'package:ezflutter/core/env/env.dart';
import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Env', () {
    test('defaults to dev environment', () {
      expect(Env.current, equals(Environment.dev));
      expect(Env.isDev, isTrue);
    });
  });

  group('Result', () {
    test('success holds data', () {
      const result = Result<int>.success(42);
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, equals(42));
    });

    test('failure holds error', () {
      const result = Result<int>.failure(
        NetworkException('timeout'),
      );
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<NetworkException>());
    });

    test('when dispatches correctly', () {
      const result = Result<String>.success('hello');
      final output = result.when(
        success: (data) => 'got: $data',
        failure: (error) => 'error: ${error.message}',
      );
      expect(output, equals('got: hello'));
    });

    test('map transforms success', () {
      const result = Result<int>.success(21);
      final mapped = result.map((n) => n * 2);
      expect(mapped.dataOrNull, equals(42));
    });
  });

  group('AppException', () {
    test('subtypes are distinct', () {
      const network = NetworkException('timeout');
      const auth = AuthException('unauthorized');
      const cache = CacheException('read failed');
      const validation = ValidationException('invalid email');

      expect(network, isA<AppException>());
      expect(auth, isA<AppException>());
      expect(cache, isA<AppException>());
      expect(validation, isA<AppException>());
    });
  });
}
