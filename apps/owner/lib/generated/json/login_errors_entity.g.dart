import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/login_errors_entity.dart';

LoginErrorsEntity $LoginErrorsEntityFromJson(Map<String, dynamic> json) {
  final LoginErrorsEntity loginErrorsEntity = LoginErrorsEntity();
  final List<String>? identifier = (json['identifier'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (identifier != null) {
    loginErrorsEntity.identifier = identifier;
  }
  final List<String>? password = (json['password'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (password != null) {
    loginErrorsEntity.password = password;
  }
  return loginErrorsEntity;
}

Map<String, dynamic> $LoginErrorsEntityToJson(LoginErrorsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['identifier'] = entity.identifier;
  data['password'] = entity.password;
  return data;
}

extension LoginErrorsEntityExt on LoginErrorsEntity {
  LoginErrorsEntity copyWith({
    List<String>? identifier,
    List<String>? password,
  }) {
    return LoginErrorsEntity()
      ..identifier = identifier ?? this.identifier
      ..password = password ?? this.password;
  }
}