import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/login_errors_entity.g.dart';

@JsonSerializable()
class LoginErrorsEntity {
  LoginErrorsEntity();

  factory LoginErrorsEntity.fromJson(Map<String, dynamic> json) => $LoginErrorsEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginErrorsEntityToJson(this);

  List<String>? identifier;
  List<String>? password;
}
