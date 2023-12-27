import 'package:spotx/data/remote/auth/models/company_entity.dart';
import 'package:spotx/generated/json/login_response_entity.g.dart';

import 'package:spotx/generated/json/base/json_field.dart';

import 'get_cities_response_entity.dart';

@JsonSerializable()
class LoginResponseEntity {
  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => $LoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginResponseEntityToJson(this);

  Token? token;
  User? user;

  LoginResponseEntity({this.token, this.user});
}

@JsonSerializable()
class Token {
  Token();

  factory Token.fromJson(Map<String, dynamic> json) => $TokenFromJson(json);

  Map<String, dynamic> toJson() => $TokenToJson(this);

  @JSONField(name: "access_token")
  String? accessToken;
  @JSONField(name: "expired_at")
  dynamic expiredAt;
  String? type;
}

@JsonSerializable()
class User {
  User();

  factory User.fromJson(Map<String, dynamic> json) => $UserFromJson(json);

  Map<String, dynamic> toJson() => $UserToJson(this);

  int? id;
  String? name;
  String? email;
  @JSONField(name: "email_verified_at")
  dynamic emailVerifiedAt;
  String? phone;
  @JSONField(name: "phone_verified_at")
  dynamic phoneVerifiedAt;
  String? image;
  @JSONField(name: "city_id")
  int? cityId;
  City? city;
  @JSONField(name: "company")
  CompanyEntity? companyEntity;
}