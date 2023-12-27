import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/login_request_entity.g.dart';

@JsonSerializable()
class LoginRequestEntity {
  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) => $LoginRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginRequestEntityToJson(this);

  LoginRequestEntity({this.identifier, this.password});
  String? identifier;
  String? password;
}
