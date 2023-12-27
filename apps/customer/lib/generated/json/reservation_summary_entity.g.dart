import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/reservation/model/reservation_summary_entity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';


ReservationSummaryEntity $ReservationSummaryEntityFromJson(Map<String, dynamic> json) {
	final ReservationSummaryEntity reservationSummaryEntity = ReservationSummaryEntity();
	final String? checkIn = jsonConvert.convert<String>(json['check_in']);
	if (checkIn != null) {
		reservationSummaryEntity.checkIn = checkIn;
	}
	final String? checkOut = jsonConvert.convert<String>(json['check_out']);
	if (checkOut != null) {
		reservationSummaryEntity.checkOut = checkOut;
	}
	final ImageEntity? image = jsonConvert.convert<ImageEntity>(json['image']);
	if (image != null) {
		reservationSummaryEntity.image = image;
	}
	final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
	if (totalPrice != null) {
		reservationSummaryEntity.totalPrice = totalPrice;
	}
	final int? discount = jsonConvert.convert<int>(json['discount']);
	if (discount != null) {
		reservationSummaryEntity.discount = discount;
	}
	final int? subTotal = jsonConvert.convert<int>(json['sub_total']);
	if (subTotal != null) {
		reservationSummaryEntity.subTotal = subTotal;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		reservationSummaryEntity.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		reservationSummaryEntity.to = to;
	}
	final int? nights = jsonConvert.convert<int>(json['nights']);
	if (nights != null) {
		reservationSummaryEntity.nights = nights;
	}
	final List<ReservationSummaryPrices>? prices = jsonConvert.convertListNotNull<ReservationSummaryPrices>(json['prices']);
	if (prices != null) {
		reservationSummaryEntity.prices = prices;
	}
	return reservationSummaryEntity;
}

Map<String, dynamic> $ReservationSummaryEntityToJson(ReservationSummaryEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['check_in'] = entity.checkIn;
	data['check_out'] = entity.checkOut;
	data['image'] = entity.image?.toJson();
	data['total_price'] = entity.totalPrice;
	data['discount'] = entity.discount;
	data['sub_total'] = entity.subTotal;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['nights'] = entity.nights;
	data['prices'] =  entity.prices?.map((v) => v.toJson()).toList();
	return data;
}

ReservationSummaryPrices $ReservationSummaryPricesFromJson(Map<String, dynamic> json) {
	final ReservationSummaryPrices reservationSummaryPrices = ReservationSummaryPrices();
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		reservationSummaryPrices.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		reservationSummaryPrices.to = to;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		reservationSummaryPrices.price = price;
	}
	final int? days = jsonConvert.convert<int>(json['days']);
	if (days != null) {
		reservationSummaryPrices.days = days;
	}
	return reservationSummaryPrices;
}

Map<String, dynamic> $ReservationSummaryPricesToJson(ReservationSummaryPrices entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['price'] = entity.price;
	data['days'] = entity.days;
	return data;
}