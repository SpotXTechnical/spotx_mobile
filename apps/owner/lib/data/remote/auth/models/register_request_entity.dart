import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/register_request_entity.g.dart';

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

enum UserType { company, owner }
