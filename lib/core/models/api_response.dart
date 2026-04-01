import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

/// Generic API response wrapper.
@freezed
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    T? data,
    String? message,
    int? statusCode,
  }) = _ApiResponse<T>;
}
