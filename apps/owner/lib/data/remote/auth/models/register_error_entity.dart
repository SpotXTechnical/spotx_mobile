import 'package:owner/generated/json/register_error_entity.g.dart';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:owner/generated/json/base/json_field.dart';

part 'register_error_entity.g.dart';

@CopyWith()
@JsonSerializable()
class RegisterErrorsEntity {
  factory RegisterErrorsEntity.fromJson(Map<String, dynamic> json) => $RegisterErrorsEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegisterErrorsEntityToJson(this);

  List<String>? email;
  List<String>? password;
  List<String>? name;
  List<String>? phone;
  List<String>? image;
  List<String>? type;
  @JSONField(name: "national_id_image")
  List<String>? nationalIdImage;
  @JSONField(name: "national_id")
  List<String>? nationalId;
  @JSONField(name: "whatsapp")
  List<String>? whatApp;

  RegisterErrorsEntity(
      {this.email, this.password, this.name, this.phone, this.image, this.type, this.nationalIdImage, this.nationalId, this.whatApp});
}
