import 'package:dio/dio.dart';
import 'package:ezflutter/core/models/user.dart';
import 'package:retrofit/retrofit.dart';

part 'sample_api.g.dart';

/// Example Retrofit API interface.
///
/// Copy this pattern to create your own type-safe API client:
///
/// 1. Define your interface with annotations
/// 2. Run: dart run build_runner build --delete-conflicting-outputs
/// 3. Register in DI or access via: SampleApi(getIt<Dio>())
///
/// ```dart
/// final api = SampleApi(getIt<Dio>());
/// final users = await api.getUsers();
/// ```
@RestApi()
abstract class SampleApi {
  factory SampleApi(Dio dio, {String? baseUrl}) = _SampleApi;

  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser(@Path('id') String id);

  @POST('/users')
  Future<User> createUser(@Body() Map<String, dynamic> body);

  @PUT('/users/{id}')
  Future<User> updateUser(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') String id);
}
