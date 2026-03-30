import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ezflutter/core/auth/auth_state.dart';
import 'package:ezflutter/core/auth/auth_service.dart';
import 'package:ezflutter/core/di/injection.dart';
import 'package:ezflutter/core/models/user.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  AuthService get _authService => getIt<AuthService>();

  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthState.loading();
  }

  Future<void> _checkAuthStatus() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      state = AuthState.authenticated(user);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await _authService.login(email, password);
    result.when(
      success: (user) => state = AuthState.authenticated(user),
      failure: (_) => state = const AuthState.unauthenticated(),
    );
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState.unauthenticated();
  }
}

@riverpod
User? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return switch (authState) {
    Authenticated(:final user) => user,
    _ => null,
  };
}
