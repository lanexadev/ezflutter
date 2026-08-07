import 'package:flutter_test/flutter_test.dart';
import 'package:nativiq/nativiq.dart';

void main() {
  group('Validators', () {
    test('required rejects null', () {
      final validator = Validators.required<String>();

      final result = validator(null);

      expect(result, isA<Failed<String?>>());
    });

    test('nonEmpty rejects whitespace', () {
      final validator = Validators.nonEmpty();

      final result = validator('   ');

      expect(result, isA<Failed<String>>());
    });

    test('length accepts inclusive bounds', () {
      final validator = Validators.length(min: 2, max: 4);

      final results = [validator('ab'), validator('abcd')];

      expect(results.every((result) => result.isSuccess), isTrue);
    });

    test('email accepts a conventional address', () {
      final validator = Validators.email();

      final result = validator('dev@nativiq.dev');

      expect(result, isA<Success<String>>());
    });

    test('all returns the first validation failure', () {
      final validator = Validators.all<String>([
        Validators.nonEmpty(message: 'Empty'),
        Validators.length(min: 5, message: 'Short'),
      ]);

      final result = validator('abc');

      expect(
        result,
        isA<Failed<String>>().having(
          (it) => it.failure.message,
          'message',
          'Short',
        ),
      );
    });
  });
}
