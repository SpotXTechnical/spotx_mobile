import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';

UnitFilterConfigEntity $UnitFilterConfigEntityFromJson(Map<String, dynamic> json) {
	final UnitFilterConfigEntity unitFilterConfigEntity = UnitFilterConfigEntity();
	final int? maxPrice = jsonConvert.convert<int>(json['max_price']);
	if (maxPrice != null) {
		unitFilterConfigEntity.maxPrice = maxPrice;
	}
	final int? minPrice = jsonConvert.convert<int>(json['min_price']);
	if (minPrice != null) {
		unitFilterConfigEntity.minPrice = minPrice;
	}
	final int? maxRooms = jsonConvert.convert<int>(json['max_rooms']);
	if (maxRooms != null) {
		unitFilterConfigEntity.maxRooms = maxRooms;
	}
	final int? maxBeds = jsonConvert.convert<int>(json['max_beds']);
	if (maxBeds != null) {
		unitFilterConfigEntity.maxBeds = maxBeds;
	}
	final List<UnitFilterConfigTypes>? types = jsonConvert.convertListNotNull<UnitFilterConfigTypes>(json['types']);
	if (types != null) {
		unitFilterConfigEntity.types = types;
	}
	return unitFilterConfigEntity;
}

Map<String, dynamic> $UnitFilterConfigEntityToJson(UnitFilterConfigEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['max_price'] = entity.maxPrice;
	data['min_price'] = entity.minPrice;
	data['max_rooms'] = entity.maxRooms;
	data['max_beds'] = entity.maxBeds;
	data['types'] =  entity.types?.map((v) => v.toJson()).toList();
	return data;
}

UnitFilterConfigTypes $UnitFilterConfigTypesFromJson(Map<String, dynamic> json) {
	final UnitFilterConfigTypes unitFilterConfigTypes = UnitFilterConfigTypes();
	final String? value = jsonConvert.convert<String>(json['value']);
	if (value != null) {
		unitFilterConfigTypes.value = value;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		unitFilterConfigTypes.name = name;
	}
	return unitFilterConfigTypes;
}

Map<String, dynamic> $UnitFilterConfigTypesToJson(UnitFilterConfigTypes entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['value'] = entity.value;
	data['name'] = entity.name;
	return data;
}