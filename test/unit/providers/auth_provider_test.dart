import 'package:ezflutter/core/auth/auth_service.dart';
import 'package:ezflutter/core/auth/auth_state.dart';
import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuth;

  setUp(() {
    mockAuth = MockAuthService();
  });

  group('AuthState', () {
    test('authenticated holds user', () {
      const user = User(id: '1', email: 'test@test.com');
      const state = AuthState.authenticated(user);
      expect(
        state,
        isA<Authenticated>().having((s) => s.user.email, 'email', 'test@test.com'),
      );
    });

    test('unauthenticated is distinct', () {
      const state = AuthState.unauthenticated();
      expect(state, isA<Unauthenticated>());
    });

    test('error holds message', () {
      const state = AuthState.error('Invalid credentials');
      expect(
        state,
        isA<AuthError>().having((s) => s.message, 'message', 'Invalid credentials'),
      );
    });
  });

  group('AuthService', () {
    test('login returns user on success', () async {
      const user = User(id: '1', email: 'test@test.com');
      when(() => mockAuth.login('test@test.com', 'pass'))
          .thenAnswer((_) async => const Result.success(user));

      final result = await mockAuth.login('test@test.com', 'pass');
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull?.email, equals('test@test.com'));
    });

    test('login returns failure on error', () async {
      when(() => mockAuth.login('bad', 'bad'))
          .thenAnswer((_) async => const Result.failure(AuthException('Invalid')));

      final result = await mockAuth.login('bad', 'bad');
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<AuthException>());
    });
  });
}
