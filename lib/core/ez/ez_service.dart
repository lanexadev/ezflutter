import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/logging/log.dart';

/// Base class for services with automatic error handling.
///
/// Provides [guard] to wrap any async operation in a [Result] with
/// automatic try/catch, logging, and exception mapping.
///
/// ```dart
/// @injectable
/// class ProductService extends EzService {
///   final ProductApi _api;
///   ProductService(this._api);
///
///   Future<Result<List<Product>>> getProducts() =>
///       guard(() => _api.getProducts());
///
///   Future<Result<Product>> getProduct(String id) =>
///       guard(() => _api.getProduct(id), tag: 'getProduct');
/// }
/// ```
abstract class EzService {
  /// Wraps an async operation in a [Result].
  ///
  /// Catches all exceptions, logs them, and returns [Result.failure].
  /// On success, returns [Result.success].
  Future<Result<T>> guard<T>(
    Future<T> Function() action, {
    String? tag,
  }) async {
    try {
      final data = await action();
      return Result.success(data);
    } on Exception catch (e, s) {
      final label = tag ?? runtimeType.toString();
      Log.error('$label failed', error: e, stackTrace: s);
      return Result.failure(_mapException(e));
    }
  }

  /// Synchronous version of [guard].
  Result<T> guardSync<T>(
    T Function() action, {
    String? tag,
  }) {
    try {
      final data = action();
      return Result.success(data);
    } on Exception catch (e, s) {
      final label = tag ?? runtimeType.toString();
      Log.error('$label failed', error: e, stackTrace: s);
      return Result.failure(_mapException(e));
    }
  }

  AppException _mapException(Object error) {
    if (error is AppException) return error;
    return ServerException(error.toString());
  }
}
