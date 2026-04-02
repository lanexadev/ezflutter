import 'package:dio/dio.dart';
import 'package:ezflutter/core/env/env.dart';
import 'package:ezflutter/core/network/interceptors/auth_interceptor.dart';
import 'package:ezflutter/core/network/interceptors/error_interceptor.dart';
import 'package:ezflutter/core/network/interceptors/log_interceptor.dart';
import 'package:ezflutter/core/network/interceptors/retry_interceptor.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    AppErrorInterceptor errorInterceptor,
    AppLogInterceptor logInterceptor,
    RetryInterceptor retryInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      logInterceptor,
      retryInterceptor,
      errorInterceptor,
    ]);

    return dio;
  }
}
