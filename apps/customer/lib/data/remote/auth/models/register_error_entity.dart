import 'package:spotx/generated/json/register_error_entity.g.dart';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:spotx/generated/json/base/json_field.dart';

part 'register_error_entity.g.dart';

@CopyWith()
@JsonSerializable()
class RegisterErrorsEntity {
  factory RegisterErrorsEntity.fromJson(Map<String, dynamic> json) => $RegisterErrorsEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterErrorsEntityToJson(this);

  List<String>? name;
  List<String>? email;
  List<String>? phone;
  List<String>? password;
  @JSONField(name: "city_id")
  List<String>? cityId;

  RegisterErrorsEntity({this.name, this.email, this.phone, this.password, this.cityId});
}
