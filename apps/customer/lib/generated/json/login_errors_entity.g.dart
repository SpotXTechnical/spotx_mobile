import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/login_errors_entity.dart';

LoginErrorsEntity $LoginErrorsEntityFromJson(Map<String, dynamic> json) {
	final LoginErrorsEntity loginErrorsEntity = LoginErrorsEntity();
	final List<String>? identifier = jsonConvert.convertListNotNull<String>(json['identifier']);
	if (identifier != null) {
		loginErrorsEntity.identifier = identifier;
	}
	final List<String>? password = jsonConvert.convertListNotNull<String>(json['password']);
	if (password != null) {
		loginErrorsEntity.password = password;
	}
	return loginErrorsEntity;
}

Map<String, dynamic> $LoginErrorsEntityToJson(LoginErrorsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['identifier'] =  entity.identifier;
	data['password'] =  entity.password;
	return data;
}