import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';


OfferEntity $OfferEntityFromJson(Map<String, dynamic> json) {
	final OfferEntity offerEntity = OfferEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		offerEntity.id = id;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		offerEntity.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		offerEntity.to = to;
	}
	final DateTime? startDate = jsonConvert.convert<DateTime>(json['from']);
	if (startDate != null) {
		offerEntity.startDate = startDate;
	}
	final DateTime? endDate = jsonConvert.convert<DateTime>(json['to']);
	if (endDate != null) {
		offerEntity.endDate = endDate;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		offerEntity.price = price;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		offerEntity.createdAt = createdAt;
	}
	final dynamic unitId = jsonConvert.convert<dynamic>(json['unit_id']);
	if (unitId != null) {
		offerEntity.unitId = unitId;
	}
	final Unit? unit = jsonConvert.convert<Unit>(json['unit']);
	if (unit != null) {
		offerEntity.unit = unit;
	}
	final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
	if (totalPrice != null) {
		offerEntity.totalPrice = totalPrice;
	}
	final int? dayCount = jsonConvert.convert<int>(json['days_count']);
	if (dayCount != null) {
		offerEntity.dayCount = dayCount;
	}
	return offerEntity;
}

Map<String, dynamic> $OfferEntityToJson(OfferEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['from'] = entity.startDate?.toIso8601String();
	data['to'] = entity.endDate?.toIso8601String();
	data['price'] = entity.price;
	data['created_at'] = entity.createdAt;
	data['unit_id'] = entity.unitId;
	data['unit'] = entity.unit?.toJson();
	data['total_price'] = entity.totalPrice;
	data['days_count'] = entity.dayCount;
	return data;
}