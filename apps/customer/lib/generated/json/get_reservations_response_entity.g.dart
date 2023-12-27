import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

import 'package:spotx/utils/network/list_helper/links.dart';

import 'package:spotx/utils/network/list_helper/meta.dart';


GetReservationsResponseEntity $GetReservationsResponseEntityFromJson(Map<String, dynamic> json) {
	final GetReservationsResponseEntity getReservationsResponseEntity = GetReservationsResponseEntity();
	final List<Reservation>? data = jsonConvert.convertListNotNull<Reservation>(json['data']);
	if (data != null) {
		getReservationsResponseEntity.data = data;
	}
	final Links? links = jsonConvert.convert<Links>(json['links']);
	if (links != null) {
		getReservationsResponseEntity.links = links;
	}
	final Meta? meta = jsonConvert.convert<Meta>(json['meta']);
	if (meta != null) {
		getReservationsResponseEntity.meta = meta;
	}
	return getReservationsResponseEntity;
}

Map<String, dynamic> $GetReservationsResponseEntityToJson(GetReservationsResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	data['links'] = entity.links?.toJson();
	data['meta'] = entity.meta?.toJson();
	return data;
}

Reservation $ReservationFromJson(Map<String, dynamic> json) {
	final Reservation reservation = Reservation();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		reservation.id = id;
	}
	final DateTime? from = jsonConvert.convert<DateTime>(json['from']);
	if (from != null) {
		reservation.from = from;
	}
	final DateTime? to = jsonConvert.convert<DateTime>(json['to']);
	if (to != null) {
		reservation.to = to;
	}
	final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
	if (totalPrice != null) {
		reservation.totalPrice = totalPrice;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		reservation.status = status;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		reservation.days = days;
	}
	final Unit? unit = jsonConvert.convert<Unit>(json['unit']);
	if (unit != null) {
		reservation.unit = unit;
	}
	final List<GetReservationsResponseDataPrices>? prices = jsonConvert.convertListNotNull<GetReservationsResponseDataPrices>(json['prices']);
	if (prices != null) {
		reservation.prices = prices;
	}
	final int? discount = jsonConvert.convert<int>(json['discount']);
	if (discount != null) {
		reservation.discount = discount;
	}
	final int? subTotal = jsonConvert.convert<int>(json['sub_total']);
	if (subTotal != null) {
		reservation.subTotal = subTotal;
	}
	final bool? isReviewed = jsonConvert.convert<bool>(json['is_reviewed']);
	if (isReviewed != null) {
		reservation.isReviewed = isReviewed;
	}
	return reservation;
}

Map<String, dynamic> $ReservationToJson(Reservation entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['from'] = entity.from?.toIso8601String();
	data['to'] = entity.to?.toIso8601String();
	data['total_price'] = entity.totalPrice;
	data['status'] = entity.status;
	data['days'] = entity.days;
	data['unit'] = entity.unit?.toJson();
	data['prices'] =  entity.prices?.map((v) => v.toJson()).toList();
	data['discount'] = entity.discount;
	data['sub_total'] = entity.subTotal;
	data['is_reviewed'] = entity.isReviewed;
	return data;
}

GetReservationsResponseDataPrices $GetReservationsResponseDataPricesFromJson(Map<String, dynamic> json) {
	final GetReservationsResponseDataPrices getReservationsResponseDataPrices = GetReservationsResponseDataPrices();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		getReservationsResponseDataPrices.id = id;
	}
	final int? reservationId = jsonConvert.convert<int>(json['reservation_id']);
	if (reservationId != null) {
		getReservationsResponseDataPrices.reservationId = reservationId;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		getReservationsResponseDataPrices.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		getReservationsResponseDataPrices.to = to;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		getReservationsResponseDataPrices.price = price;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		getReservationsResponseDataPrices.days = days;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		getReservationsResponseDataPrices.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		getReservationsResponseDataPrices.updatedAt = updatedAt;
	}
	return getReservationsResponseDataPrices;
}

Map<String, dynamic> $GetReservationsResponseDataPricesToJson(GetReservationsResponseDataPrices entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['reservation_id'] = entity.reservationId;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['price'] = entity.price;
	data['days'] = entity.days;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}