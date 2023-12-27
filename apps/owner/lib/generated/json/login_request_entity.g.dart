import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/login_request_entity.dart';

LoginRequestEntity $LoginRequestEntityFromJson(Map<String, dynamic> json) {
  final LoginRequestEntity loginRequestEntity = LoginRequestEntity();
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    loginRequestEntity.email = email;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    loginRequestEntity.password = password;
  }
  return loginRequestEntity;
}

Map<String, dynamic> $LoginRequestEntityToJson(LoginRequestEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['email'] = entity.email;
  data['password'] = entity.password;
  return data;
}

extension LoginRequestEntityExt on LoginRequestEntity {
  LoginRequestEntity copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequestEntity()
      ..email = email ?? this.email
      ..password = password ?? this.password;
  }
}