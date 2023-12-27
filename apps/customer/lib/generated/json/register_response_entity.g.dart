import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/register_response_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';


RegisterResponseEntity $RegisterResponseEntityFromJson(Map<String, dynamic> json) {
	final RegisterResponseEntity registerResponseEntity = RegisterResponseEntity();
	final Token? token = jsonConvert.convert<Token>(json['token']);
	if (token != null) {
		registerResponseEntity.token = token;
	}
	final User? user = jsonConvert.convert<User>(json['user']);
	if (user != null) {
		registerResponseEntity.user = user;
	}
	return registerResponseEntity;
}

Map<String, dynamic> $RegisterResponseEntityToJson(RegisterResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['token'] = entity.token?.toJson();
	data['user'] = entity.user?.toJson();
	return data;
}

RegisterResponseEntityDataToken $RegisterResponseEntityDataTokenFromJson(Map<String, dynamic> json) {
	final RegisterResponseEntityDataToken registerResponseEntityDataToken = RegisterResponseEntityDataToken();
	final String? accessToken = jsonConvert.convert<String>(json['access_token']);
	if (accessToken != null) {
		registerResponseEntityDataToken.accessToken = accessToken;
	}
	final dynamic expiredAt = jsonConvert.convert<dynamic>(json['expired_at']);
	if (expiredAt != null) {
		registerResponseEntityDataToken.expiredAt = expiredAt;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		registerResponseEntityDataToken.type = type;
	}
	return registerResponseEntityDataToken;
}

Map<String, dynamic> $RegisterResponseEntityDataTokenToJson(RegisterResponseEntityDataToken entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['access_token'] = entity.accessToken;
	data['expired_at'] = entity.expiredAt;
	data['type'] = entity.type;
	return data;
}

RegisterResponseEntityDataUser $RegisterResponseEntityDataUserFromJson(Map<String, dynamic> json) {
	final RegisterResponseEntityDataUser registerResponseEntityDataUser = RegisterResponseEntityDataUser();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		registerResponseEntityDataUser.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		registerResponseEntityDataUser.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		registerResponseEntityDataUser.email = email;
	}
	final dynamic emailVerifiedAt = jsonConvert.convert<dynamic>(json['email_verified_at']);
	if (emailVerifiedAt != null) {
		registerResponseEntityDataUser.emailVerifiedAt = emailVerifiedAt;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		registerResponseEntityDataUser.phone = phone;
	}
	final dynamic phoneVerifiedAt = jsonConvert.convert<dynamic>(json['phone_verified_at']);
	if (phoneVerifiedAt != null) {
		registerResponseEntityDataUser.phoneVerifiedAt = phoneVerifiedAt;
	}
	final dynamic image = jsonConvert.convert<dynamic>(json['image']);
	if (image != null) {
		registerResponseEntityDataUser.image = image;
	}
	final String? cityId = jsonConvert.convert<String>(json['city_id']);
	if (cityId != null) {
		registerResponseEntityDataUser.cityId = cityId;
	}
	final RegisterResponseEntityDataUserCity? city = jsonConvert.convert<RegisterResponseEntityDataUserCity>(json['city']);
	if (city != null) {
		registerResponseEntityDataUser.city = city;
	}
	return registerResponseEntityDataUser;
}

Map<String, dynamic> $RegisterResponseEntityDataUserToJson(RegisterResponseEntityDataUser entity) {
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
	return data;
}

RegisterResponseEntityDataUserCity $RegisterResponseEntityDataUserCityFromJson(Map<String, dynamic> json) {
	final RegisterResponseEntityDataUserCity registerResponseEntityDataUserCity = RegisterResponseEntityDataUserCity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		registerResponseEntityDataUserCity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		registerResponseEntityDataUserCity.name = name;
	}
	return registerResponseEntityDataUserCity;
}

Map<String, dynamic> $RegisterResponseEntityDataUserCityToJson(RegisterResponseEntityDataUserCity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}