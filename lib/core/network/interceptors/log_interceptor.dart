import 'package:dio/dio.dart';
import 'package:ezflutter/core/env/env.dart';
import 'package:ezflutter/core/logging/log.dart';
import 'package:injectable/injectable.dart';

/// Logs HTTP requests and responses in dev mode only.
@singleton
class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Env.isDev) {
      Log.debug('→ ${options.method} ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (Env.isDev) {
      Log.debug(
        '← ${response.statusCode} ${response.requestOptions.uri}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (Env.isDev) {
      Log.error(
        '✗ ${err.response?.statusCode ?? 'ERR'} ${err.requestOptions.uri}',
        error: err,
      );
    }
    handler.next(err);
  }
}
