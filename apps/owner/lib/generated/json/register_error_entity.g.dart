import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/register_error_entity.dart';


RegisterErrorsEntity $RegisterErrorsEntityFromJson(Map<String, dynamic> json) {
  final RegisterErrorsEntity registerErrorsEntity = RegisterErrorsEntity();
  final List<String>? email = (json['email'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (email != null) {
    registerErrorsEntity.email = email;
  }
  final List<String>? password = (json['password'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (password != null) {
    registerErrorsEntity.password = password;
  }
  final List<String>? name = (json['name'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (name != null) {
    registerErrorsEntity.name = name;
  }
  final List<String>? phone = (json['phone'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (phone != null) {
    registerErrorsEntity.phone = phone;
  }
  final List<String>? image = (json['image'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (image != null) {
    registerErrorsEntity.image = image;
  }
  final List<String>? type = (json['type'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (type != null) {
    registerErrorsEntity.type = type;
  }
  final List<String>? nationalIdImage = (json['national_id_image'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (nationalIdImage != null) {
    registerErrorsEntity.nationalIdImage = nationalIdImage;
  }
  final List<String>? nationalId = (json['national_id'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (nationalId != null) {
    registerErrorsEntity.nationalId = nationalId;
  }
  final List<String>? whatApp = (json['whatsapp'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (whatApp != null) {
    registerErrorsEntity.whatApp = whatApp;
  }
  return registerErrorsEntity;
}

Map<String, dynamic> $RegisterErrorsEntityToJson(RegisterErrorsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['email'] = entity.email;
  data['password'] = entity.password;
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  data['image'] = entity.image;
  data['type'] = entity.type;
  data['national_id_image'] = entity.nationalIdImage;
  data['national_id'] = entity.nationalId;
  data['whatsapp'] = entity.whatApp;
  return data;
}

extension RegisterErrorsEntityExt on RegisterErrorsEntity {
  RegisterErrorsEntity copyWith({
    List<String>? email,
    List<String>? password,
    List<String>? name,
    List<String>? phone,
    List<String>? image,
    List<String>? type,
    List<String>? nationalIdImage,
    List<String>? nationalId,
    List<String>? whatApp,
  }) {
    return RegisterErrorsEntity()
      ..email = email ?? this.email
      ..password = password ?? this.password
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..image = image ?? this.image
      ..type = type ?? this.type
      ..nationalIdImage = nationalIdImage ?? this.nationalIdImage
      ..nationalId = nationalId ?? this.nationalId
      ..whatApp = whatApp ?? this.whatApp;
  }
}