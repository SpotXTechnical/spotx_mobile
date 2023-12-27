import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/data/remote/auth/models/company_entity.dart';


LoginResponseEntity $LoginResponseEntityFromJson(Map<String, dynamic> json) {
	final LoginResponseEntity loginResponseEntity = LoginResponseEntity();
	final Token? token = jsonConvert.convert<Token>(json['token']);
	if (token != null) {
		loginResponseEntity.token = token;
	}
	final User? user = jsonConvert.convert<User>(json['user']);
	if (user != null) {
		loginResponseEntity.user = user;
	}
	return loginResponseEntity;
}

Map<String, dynamic> $LoginResponseEntityToJson(LoginResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['token'] = entity.token?.toJson();
	data['user'] = entity.user?.toJson();
	return data;
}

Token $TokenFromJson(Map<String, dynamic> json) {
	final Token token = Token();
	final String? accessToken = jsonConvert.convert<String>(json['access_token']);
	if (accessToken != null) {
		token.accessToken = accessToken;
	}
	final dynamic expiredAt = jsonConvert.convert<dynamic>(json['expired_at']);
	if (expiredAt != null) {
		token.expiredAt = expiredAt;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		token.type = type;
	}
	return token;
}

Map<String, dynamic> $TokenToJson(Token entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['access_token'] = entity.accessToken;
	data['expired_at'] = entity.expiredAt;
	data['type'] = entity.type;
	return data;
}

User $UserFromJson(Map<String, dynamic> json) {
	final User user = User();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		user.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		user.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		user.email = email;
	}
	final dynamic emailVerifiedAt = jsonConvert.convert<dynamic>(json['email_verified_at']);
	if (emailVerifiedAt != null) {
		user.emailVerifiedAt = emailVerifiedAt;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		user.phone = phone;
	}
	final dynamic phoneVerifiedAt = jsonConvert.convert<dynamic>(json['phone_verified_at']);
	if (phoneVerifiedAt != null) {
		user.phoneVerifiedAt = phoneVerifiedAt;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		user.image = image;
	}
	final int? cityId = jsonConvert.convert<int>(json['city_id']);
	if (cityId != null) {
		user.cityId = cityId;
	}
	final City? city = jsonConvert.convert<City>(json['city']);
	if (city != null) {
		user.city = city;
	}
	final CompanyEntity? companyEntity = jsonConvert.convert<CompanyEntity>(json['company']);
	if (companyEntity != null) {
		user.companyEntity = companyEntity;
	}
	return user;
}

Map<String, dynamic> $UserToJson(User entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['email_verified_at'] = entity.emailVerifiedAt;
	data['phone'] = entity.phone;
	data['phone_verified_at'] = entity.phoneVerifiedAt;
	data['image'] = entity.image;
	data['city_id'] = entity.cityId;
	data['city'] = entity.city?.toJson();
	data['company'] = entity.companyEntity?.toJson();
	return data;
}