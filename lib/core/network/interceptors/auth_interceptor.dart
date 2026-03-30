import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezflutter/core/models/auth_token.dart';
import 'package:ezflutter/core/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Injects the JWT token into requests and handles token refresh.
@singleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final SecureStorageService _secureStorage;

  static const _tokenKey = 'auth_token';

  String? _cachedToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _cachedToken ?? await _readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      _cachedToken = null;
    }
    handler.next(err);
  }

  Future<String?> _readToken() async {
    final raw = await _secureStorage.read(_tokenKey);
    if (raw == null) return null;
    try {
      final token = AuthToken.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      if (token.isExpired) return null;
      _cachedToken = token.accessToken;
      return _cachedToken;
    } catch (_) {
      return null;
    }
  }

  void clearCache() => _cachedToken = null;
}
