import 'dart:convert';

import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/logging/log.dart';
import 'package:ezflutter/core/models/auth_token.dart';
import 'package:ezflutter/core/models/user.dart';
import 'package:ezflutter/core/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Abstract auth service — implement with your backend.
abstract class AuthService {
  Future<Result<User>> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<AuthToken?> getToken();
}

/// Default implementation using secure storage.
/// Replace this with your actual API auth implementation.
@Singleton(as: AuthService)
class DefaultAuthService implements AuthService {
  DefaultAuthService(this._secureStorage);

  final SecureStorageService _secureStorage;

  static const _tokenKey = 'auth_token';
  static const _userKey = 'current_user';

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      // TODO(dev): Replace with actual API call
      // final response = await dio.post('/auth/login', data: {...});

      // Placeholder: simulate successful login
      final user = User(
        id: '1',
        email: email,
        displayName: email.split('@').first,
      );

      final token = AuthToken(
        accessToken: 'placeholder_token',
        refreshToken: 'placeholder_refresh',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );

      await _secureStorage.write(_tokenKey, jsonEncode(token.toJson()));
      await _secureStorage.write(_userKey, jsonEncode(user.toJson()));

      Log.info('User logged in: ${user.email}');
      return Result.success(user);
    } on Exception catch (e, s) {
      Log.error('Login failed', error: e, stackTrace: s);
      return Result.failure(AuthException('Login failed: $e'));
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(_tokenKey);
    await _secureStorage.delete(_userKey);
    Log.info('User logged out');
  }

  @override
  Future<User?> getCurrentUser() async {
    final userData = await _secureStorage.read(_userKey);
    if (userData == null) return null;
    try {
      return User.fromJson(jsonDecode(userData) as Map<String, dynamic>);
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<AuthToken?> getToken() async {
    final tokenData = await _secureStorage.read(_tokenKey);
    if (tokenData == null) return null;
    try {
      return AuthToken.fromJson(
        jsonDecode(tokenData) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return null;
    }
  }
}
