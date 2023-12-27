import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/company_entity.dart';

CompanyEntity $CompanyEntityFromJson(Map<String, dynamic> json) {
	final CompanyEntity companyEntity = CompanyEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		companyEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		companyEntity.name = name;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		companyEntity.code = code;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		companyEntity.phone = phone;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		companyEntity.email = email;
	}
	return companyEntity;
}

Map<String, dynamic> $CompanyEntityToJson(CompanyEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['phone'] = entity.phone;
	data['email'] = entity.email;
	return data;
}