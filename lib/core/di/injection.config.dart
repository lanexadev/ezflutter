// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../auth/auth_service.dart' as _i88;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../network/interceptors/log_interceptor.dart' as _i543;
import '../network/interceptors/retry_interceptor.dart' as _i914;
import '../storage/secure_storage_service.dart' as _i666;
import '../storage/settings_service.dart' as _i112;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i511.AppErrorInterceptor>(() => _i511.AppErrorInterceptor());
    gh.singleton<_i543.AppLogInterceptor>(() => _i543.AppLogInterceptor());
    gh.singleton<_i914.RetryInterceptor>(() => _i914.RetryInterceptor());
    gh.singleton<_i666.SecureStorageService>(
      () => _i666.SecureStorageService(),
    );
    gh.singleton<_i112.SettingsService>(
      () => _i112.SettingsService(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i88.AuthService>(
      () => _i88.DefaultAuthService(gh<_i666.SecureStorageService>()),
    );
    gh.singleton<_i745.AuthInterceptor>(
      () => _i745.AuthInterceptor(gh<_i666.SecureStorageService>()),
    );
    gh.singleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i745.AuthInterceptor>(),
        gh<_i511.AppErrorInterceptor>(),
        gh<_i543.AppLogInterceptor>(),
        gh<_i914.RetryInterceptor>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i667.NetworkModule {}
