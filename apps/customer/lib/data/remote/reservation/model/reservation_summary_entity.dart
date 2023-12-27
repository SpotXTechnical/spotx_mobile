import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/reservation_summary_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ReservationSummaryEntity {
	@JSONField(name: "check_in")
	String? checkIn;
	@JSONField(name: "check_out")
	String? checkOut;
	ImageEntity? image;
	@JSONField(name: "total_price")
	int? totalPrice;
	int? discount;
	@JSONField(name: "sub_total")
	int? subTotal;
	String? from;
	String? to;
	int? nights;
	List<ReservationSummaryPrices>? prices;

	ReservationSummaryEntity();

	factory ReservationSummaryEntity.fromJson(Map<String, dynamic> json) => $ReservationSummaryEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReservationSummaryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}


@JsonSerializable()
class ReservationSummaryPrices {
	String? from;
	String? to;
	int? price;
	int? days;

	ReservationSummaryPrices();

	factory ReservationSummaryPrices.fromJson(Map<String, dynamic> json) => $ReservationSummaryPricesFromJson(json);

	Map<String, dynamic> toJson() => $ReservationSummaryPricesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}