// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResponse<T> {

 bool get success; T? get data; String? get message; int? get statusCode;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<T, ApiResponse<T>> get copyWith => _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(this as ApiResponse<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(data),message,statusCode);

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, data: $data, message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T,$Res>  {
  factory $ApiResponseCopyWith(ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 bool success, T? data, String? message, int? statusCode
});




}
/// @nodoc
class _$ApiResponseCopyWithImpl<T,$Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = freezed,Object? message = freezed,Object? statusCode = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  T? data,  String? message,  int? statusCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.data,_that.message,_that.statusCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  T? data,  String? message,  int? statusCode)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.success,_that.data,_that.message,_that.statusCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  T? data,  String? message,  int? statusCode)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.data,_that.message,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc


class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse({required this.success, this.data, this.message, this.statusCode});
  

@override final  bool success;
@override final  T? data;
@override final  String? message;
@override final  int? statusCode;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith => __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(data),message,statusCode);

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, data: $data, message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T,$Res> implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, T? data, String? message, int? statusCode
});




}
/// @nodoc
class __$ApiResponseCopyWithImpl<T,$Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = freezed,Object? message = freezed,Object? statusCode = freezed,}) {
  return _then(_ApiResponse<T>(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
