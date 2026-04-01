import 'package:dio/dio.dart';
import 'package:ezflutter/core/logging/log.dart';
import 'package:injectable/injectable.dart';

/// Automatically retries failed requests on network errors.
@singleton
class RetryInterceptor extends Interceptor {
  static const _maxRetries = 3;
  static const _retryDelay = Duration(seconds: 1);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_isRetryable(err)) {
      handler.next(err);
      return;
    }

    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    if (retryCount >= _maxRetries) {
      handler.next(err);
      return;
    }

    Log.debug('Retrying request (${retryCount + 1}/$_maxRetries)...');
    await Future<void>.delayed(_retryDelay * (retryCount + 1));

    err.requestOptions.extra['retryCount'] = retryCount + 1;

    try {
      // Use a fresh Dio with same base options but no interceptors
      // to avoid infinite retry loops.
      final retryDio = Dio(
        BaseOptions(
          baseUrl: err.requestOptions.baseUrl,
          connectTimeout: err.requestOptions.connectTimeout,
          receiveTimeout: err.requestOptions.receiveTimeout,
          headers: err.requestOptions.headers,
        ),
      );
      final response = await retryDio.fetch<dynamic>(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  bool _isRetryable(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.sendTimeout;
  }
}
