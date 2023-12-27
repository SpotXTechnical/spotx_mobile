import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/forget_password_request_entity_entity.dart';

ForgetPasswordRequestEntityEntity $ForgetPasswordRequestEntityEntityFromJson(
    Map<String, dynamic> json) {
  final ForgetPasswordRequestEntityEntity forgetPasswordRequestEntityEntity = ForgetPasswordRequestEntityEntity();
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    forgetPasswordRequestEntityEntity.email = email;
  }
  return forgetPasswordRequestEntityEntity;
}

Map<String, dynamic> $ForgetPasswordRequestEntityEntityToJson(
    ForgetPasswordRequestEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['email'] = entity.email;
  return data;
}

extension ForgetPasswordRequestEntityEntityExt on ForgetPasswordRequestEntityEntity {
  ForgetPasswordRequestEntityEntity copyWith({
    String? email,
  }) {
    return ForgetPasswordRequestEntityEntity()
      ..email = email ?? this.email;
  }
}