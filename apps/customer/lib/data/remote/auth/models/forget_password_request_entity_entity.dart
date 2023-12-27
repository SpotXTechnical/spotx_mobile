import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/forget_password_request_entity_entity.g.dart';

@JsonSerializable()
class ForgetPasswordRequestEntityEntity {

  factory ForgetPasswordRequestEntityEntity.fromJson(Map<String, dynamic> json) => $ForgetPasswordRequestEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $ForgetPasswordRequestEntityEntityToJson(this);

  ForgetPasswordRequestEntityEntity({this.email});
  String? email;
}
