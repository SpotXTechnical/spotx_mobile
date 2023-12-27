import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/register_error_entity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';


RegisterErrorsEntity $RegisterErrorsEntityFromJson(Map<String, dynamic> json) {
	final RegisterErrorsEntity registerErrorsEntity = RegisterErrorsEntity();
	final List<String>? name = jsonConvert.convertListNotNull<String>(json['name']);
	if (name != null) {
		registerErrorsEntity.name = name;
	}
	final List<String>? email = jsonConvert.convertListNotNull<String>(json['email']);
	if (email != null) {
		registerErrorsEntity.email = email;
	}
	final List<String>? phone = jsonConvert.convertListNotNull<String>(json['phone']);
	if (phone != null) {
		registerErrorsEntity.phone = phone;
	}
	final List<String>? password = jsonConvert.convertListNotNull<String>(json['password']);
	if (password != null) {
		registerErrorsEntity.password = password;
	}
	final List<String>? cityId = jsonConvert.convertListNotNull<String>(json['city_id']);
	if (cityId != null) {
		registerErrorsEntity.cityId = cityId;
	}
	return registerErrorsEntity;
}

Map<String, dynamic> $RegisterErrorsEntityToJson(RegisterErrorsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] =  entity.name;
	data['email'] =  entity.email;
	data['phone'] =  entity.phone;
	data['password'] =  entity.password;
	data['city_id'] =  entity.cityId;
	return data;
}