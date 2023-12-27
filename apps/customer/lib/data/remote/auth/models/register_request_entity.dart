import 'package:spotx/generated/json/register_request_entity.g.dart';

import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class RegisterRequestEntity {
  factory RegisterRequestEntity.fromJson(Map<String, dynamic> json) => $RegisterRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterRequestEntityToJson(this);

  RegisterRequestEntity({this.name, this.email, this.phone, this.cityId, this.password});
  String? name;
  String? email;
  String? phone;
  String? password;
  String? cityId;
}
