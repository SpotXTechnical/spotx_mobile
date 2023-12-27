import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/register_request_entity.dart';

RegisterRequestEntity $RegisterRequestEntityFromJson(
    Map<String, dynamic> json) {
  final RegisterRequestEntity registerRequestEntity = RegisterRequestEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    registerRequestEntity.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    registerRequestEntity.email = email;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    registerRequestEntity.phone = phone;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    registerRequestEntity.password = password;
  }
  final String? cityId = jsonConvert.convert<String>(json['cityId']);
  if (cityId != null) {
    registerRequestEntity.cityId = cityId;
  }
  return registerRequestEntity;
}

Map<String, dynamic> $RegisterRequestEntityToJson(
    RegisterRequestEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['phone'] = entity.phone;
  data['password'] = entity.password;
  data['cityId'] = entity.cityId;
  return data;
}

extension RegisterRequestEntityExt on RegisterRequestEntity {
  RegisterRequestEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? cityId,
  }) {
    return RegisterRequestEntity()
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..phone = phone ?? this.phone
      ..password = password ?? this.password
      ..cityId = cityId ?? this.cityId;
  }
}