import 'package:flutter_test/flutter_test.dart';
import 'package:nativiq/nativiq.dart';

void main() {
  group('Failure', () {
    test('protects metadata from mutation', () {
      final metadata = <String, Object?>{'field': 'email'};
      final failure = ValidationFailure(
        message: 'Invalid',
        metadata: metadata,
      );
      metadata['field'] = 'name';

      final storedField = failure.metadata['field'];

      expect(storedField, 'email');
    });

    test('provides a stable default code for each category', () {
      final failures = <Failure>[
        ValidationFailure(message: 'Invalid'),
        NetworkFailure(message: 'Offline'),
        AuthenticationFailure(message: 'Sign in'),
        AuthorizationFailure(message: 'Denied'),
        NotFoundFailure(message: 'Missing'),
        ConflictFailure(message: 'Conflict'),
        TimeoutFailure(message: 'Timed out'),
        CancelledFailure(message: 'Cancelled'),
        UnexpectedFailure(message: 'Failed'),
      ];

      final codes = failures.map((failure) => failure.code).toSet();

      expect(codes, hasLength(failures.length));
    });
  });
}
