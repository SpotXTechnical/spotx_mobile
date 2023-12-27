import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/room_details_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';


RoomDetailsEntity $RoomDetailsEntityFromJson(Map<String, dynamic> json) {
	final RoomDetailsEntity roomDetailsEntity = RoomDetailsEntity();
	final RoomDetailsData? data = jsonConvert.convert<RoomDetailsData>(json['data']);
	if (data != null) {
		roomDetailsEntity.data = data;
	}
	final dynamic message = jsonConvert.convert<dynamic>(json['message']);
	if (message != null) {
		roomDetailsEntity.message = message;
	}
	return roomDetailsEntity;
}

Map<String, dynamic> $RoomDetailsEntityToJson(RoomDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	return data;
}

RoomDetailsData $RoomDetailsDataFromJson(Map<String, dynamic> json) {
	final RoomDetailsData roomDetailsData = RoomDetailsData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		roomDetailsData.id = id;
	}
	final String? model = jsonConvert.convert<String>(json['model']);
	if (model != null) {
		roomDetailsData.model = model;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		roomDetailsData.code = code;
	}
	final int? defaultPrice = jsonConvert.convert<int>(json['default_price']);
	if (defaultPrice != null) {
		roomDetailsData.defaultPrice = defaultPrice;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		roomDetailsData.title = title;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		roomDetailsData.description = description;
	}
	final int? beds = jsonConvert.convert<int>(json['beds']);
	if (beds != null) {
		roomDetailsData.beds = beds;
	}
	final int? guests = jsonConvert.convert<int>(json['guests']);
	if (guests != null) {
		roomDetailsData.guests = guests;
	}
	final int? bathrooms = jsonConvert.convert<int>(json['bathrooms']);
	if (bathrooms != null) {
		roomDetailsData.bathrooms = bathrooms;
	}
	final List<ActiveReservation>? activeReservations = jsonConvert.convertListNotNull<ActiveReservation>(json['active_reservations']);
	if (activeReservations != null) {
		roomDetailsData.activeReservations = activeReservations;
	}
	final List<ActiveRange>? activeRanges = jsonConvert.convertListNotNull<ActiveRange>(json['active_ranges']);
	if (activeRanges != null) {
		roomDetailsData.activeRanges = activeRanges;
	}
	return roomDetailsData;
}

Map<String, dynamic> $RoomDetailsDataToJson(RoomDetailsData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['model'] = entity.model;
	data['code'] = entity.code;
	data['default_price'] = entity.defaultPrice;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['beds'] = entity.beds;
	data['guests'] = entity.guests;
	data['bathrooms'] = entity.bathrooms;
	data['active_reservations'] =  entity.activeReservations?.map((v) => v.toJson()).toList();
	data['active_ranges'] =  entity.activeRanges?.map((v) => v.toJson()).toList();
	return data;
}