import 'package:dio/dio.dart';
import 'package:ezflutter/core/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Injects the JWT token into requests and handles token refresh.
@singleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final SecureStorageService _secureStorage;

  static const _tokenKey = 'access_token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(_tokenKey);
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
    // Token refresh can be implemented here when needed.
    handler.next(err);
  }
}
