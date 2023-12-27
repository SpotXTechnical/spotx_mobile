import 'package:spotx/generated/json/get_reservations_response_entity.g.dart';

import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/utils/network/list_helper/links.dart';
import 'package:spotx/utils/network/list_helper/meta.dart';

@JsonSerializable()
class GetReservationsResponseEntity {
  GetReservationsResponseEntity();

  factory GetReservationsResponseEntity.fromJson(Map<String, dynamic> json) =>
      $GetReservationsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $GetReservationsResponseEntityToJson(this);

  List<Reservation>? data;
  Links? links;
  Meta? meta;
}

@JsonSerializable()
class Reservation {
  Reservation();

  factory Reservation.fromJson(Map<String, dynamic> json) => $ReservationFromJson(json);

  Map<String, dynamic> toJson() => $ReservationToJson(this);

  int? id;
  DateTime? from;
  DateTime? to;
  @JSONField(name: "total_price")
  int? totalPrice;
  String? status;
  int? days;
  Unit? unit;
  List<GetReservationsResponseDataPrices>? prices;
  int? discount;
  @JSONField(name: "sub_total")
  int? subTotal;
  @JSONField(name: "is_reviewed")
  bool? isReviewed;
}

@JsonSerializable()
class GetReservationsResponseDataPrices {
  GetReservationsResponseDataPrices();

  factory GetReservationsResponseDataPrices.fromJson(Map<String, dynamic> json) =>
      $GetReservationsResponseDataPricesFromJson(json);

  Map<String, dynamic> toJson() => $GetReservationsResponseDataPricesToJson(this);

  int? id;
  @JSONField(name: "reservation_id")
  int? reservationId;
  String? from;
  String? to;
  int? price;
  int? days;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "updated_at")
  String? updatedAt;
}

const reservationApprovedStatus = "approved";
const reservationPendingStatus = "pending";