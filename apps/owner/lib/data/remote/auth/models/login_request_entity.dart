import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/login_request_entity.g.dart';

@JsonSerializable()
class LoginRequestEntity {
  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) => $LoginRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginRequestEntityToJson(this);

  LoginRequestEntity({this.email, this.password});
  String? email;
  String? password;
}
