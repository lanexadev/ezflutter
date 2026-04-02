import 'package:dio/dio.dart';
import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/logging/log.dart';
import 'package:injectable/injectable.dart';

/// Converts Dio errors into typed AppExceptions.
@singleton
class AppErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapException(err);
    Log.error(
      'Network error: ${exception.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _mapException(DioException err) {
    return switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const NetworkException('Connection timed out'),
      DioExceptionType.connectionError =>
        const NetworkException('No internet connection'),
      DioExceptionType.badResponse => _mapStatusCode(err.response?.statusCode),
      DioExceptionType.cancel =>
        const NetworkException('Request cancelled'),
      _ => NetworkException('Unexpected error: ${err.message}'),
    };
  }

  AppException _mapStatusCode(int? statusCode) {
    return switch (statusCode) {
      401 => const AuthException('Unauthorized'),
      403 => const AuthException('Forbidden'),
      404 => const ServerException('Not found', statusCode: 404),
      500 => const ServerException('Internal server error', statusCode: 500),
      _ => ServerException(
          'Server error',
          statusCode: statusCode,
        ),
    };
  }
}
