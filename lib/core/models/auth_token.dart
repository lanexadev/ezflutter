import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.freezed.dart';
part 'auth_token.g.dart';

@freezed
abstract class AuthToken with _$AuthToken {
  const factory AuthToken({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) = _AuthToken;

  const AuthToken._();

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
