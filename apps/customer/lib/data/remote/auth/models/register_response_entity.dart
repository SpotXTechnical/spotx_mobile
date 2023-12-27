import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/generated/json/register_response_entity.g.dart';
import 'package:spotx/generated/json/base/json_field.dart';

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

@JsonSerializable()
class RegisterResponseEntityDataUser {
  RegisterResponseEntityDataUser();

  factory RegisterResponseEntityDataUser.fromJson(Map<String, dynamic> json) => $RegisterResponseEntityDataUserFromJson(json);

  Map<String, dynamic> toJson() => $RegisterResponseEntityDataUserToJson(this);

  int? id;
  String? name;
  String? email;
  @JSONField(name: "email_verified_at")
  dynamic emailVerifiedAt;
  String? phone;
  @JSONField(name: "phone_verified_at")
  dynamic phoneVerifiedAt;
  dynamic image;
  @JSONField(name: "city_id")
  String? cityId;
  RegisterResponseEntityDataUserCity? city;
}

@JsonSerializable()
class RegisterResponseEntityDataUserCity {
  RegisterResponseEntityDataUserCity();

  factory RegisterResponseEntityDataUserCity.fromJson(Map<String, dynamic> json) => $RegisterResponseEntityDataUserCityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterResponseEntityDataUserCityToJson(this);

  int? id;
  String? name;
}