import 'package:owner/generated/json/register_response_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

import 'login_response_entity.dart';

@JsonSerializable()
class RegisterResponseEntity {
  RegisterResponseEntity();

  factory RegisterResponseEntity.fromJson(Map<String, dynamic> json) => $RegisterResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterResponseEntityToJson(this);

  Token? token;
  User? user;
}

@JsonSerializable()
class RegisterResponseEntityDataToken {
  RegisterResponseEntityDataToken();

  factory RegisterResponseEntityDataToken.fromJson(Map<String, dynamic> json) => $RegisterResponseEntityDataTokenFromJson(json);

  Map<String, dynamic> toJson() => $RegisterResponseEntityDataTokenToJson(this);

  @JSONField(name: "access_token")
  String? accessToken;
  @JSONField(name: "expired_at")
  dynamic expiredAt;
  String? type;
}
