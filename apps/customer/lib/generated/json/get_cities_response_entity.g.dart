import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';

GetCitiesResponseEntity $GetCitiesResponseEntityFromJson(Map<String, dynamic> json) {
	final GetCitiesResponseEntity getCitiesResponseEntity = GetCitiesResponseEntity();
	final List<City>? data = jsonConvert.convertListNotNull<City>(json['data']);
	if (data != null) {
		getCitiesResponseEntity.data = data;
	}
	return getCitiesResponseEntity;
}

Map<String, dynamic> $GetCitiesResponseEntityToJson(GetCitiesResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	return data;
}

City $CityFromJson(Map<String, dynamic> json) {
	final City city = City();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		city.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		city.name = name;
	}
	return city;
}

Map<String, dynamic> $CityToJson(City entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}