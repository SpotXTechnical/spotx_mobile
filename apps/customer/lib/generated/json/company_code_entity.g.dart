import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/company_code_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';


CompanyCodeEntity $CompanyCodeEntityFromJson(Map<String, dynamic> json) {
	final CompanyCodeEntity companyCodeEntity = CompanyCodeEntity();
	final User? user = jsonConvert.convert<User>(json['user']);
	if (user != null) {
		companyCodeEntity.user = user;
	}
	return companyCodeEntity;
}

Map<String, dynamic> $CompanyCodeEntityToJson(CompanyCodeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user?.toJson();
	return data;
}