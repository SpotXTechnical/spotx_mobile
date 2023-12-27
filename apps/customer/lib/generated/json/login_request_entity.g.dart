import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/login_request_entity.dart';

LoginRequestEntity $LoginRequestEntityFromJson(Map<String, dynamic> json) {
	final LoginRequestEntity loginRequestEntity = LoginRequestEntity();
	final String? identifier = jsonConvert.convert<String>(json['identifier']);
	if (identifier != null) {
		loginRequestEntity.identifier = identifier;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		loginRequestEntity.password = password;
	}
	return loginRequestEntity;
}

Map<String, dynamic> $LoginRequestEntityToJson(LoginRequestEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['identifier'] = entity.identifier;
	data['password'] = entity.password;
	return data;
}